function [xy] = PeakFinderLSGaussian(I,threshold,edge_pad,bg_subtract,percentilecut,max_ellipticity,max_radius,min_radius)
% Find peaks image using Gaussian least-squares fitting
% Alex Johnson-Buck, The University of Michigan, 2024
arguments
    I {mustBeNumeric} % Input image
    threshold double = 10; % Background cutoff value for peak localization
    edge_pad {mustBeNumeric} = 10 % Pixels to ignore at edge of image
    bg_subtract logical = true % Whether to subtract image background prior to fitting
    percentilecut double = 0.9 % percentile cutoff for determining BG S.D.
    max_ellipticity double = 1.25 % max spot ellipticity
    max_radius double = 4 % max spot radius in pixels
    min_radius double = 0.5 % min spot radius in pixels
end


xdim = size(I,2);
ydim = size(I,1);

if bg_subtract
    I = I - imopen(I,strel('disk',10));
end

Iorig = I;
I = im2double(I);
I = I/max(max(I));

Ilinear = reshape(I,1,size(I,1)*size(I,2));
Ilinear = sort(Ilinear);
Istd = std(Ilinear(1:round(length(Ilinear)*percentilecut)));

I(I<0) = 0;
% for i = 1:size(I,1)
    % for j = 1:size(I,2)
        % if I(i,j)<0
            % I(i,j)=0;
        % end
    % end
% end

ISupp = imhmax(I,Istd*threshold, 8);
IrMax = imregionalmax(ISupp);
regions = bwlabel(IrMax);
centroids = regionprops(regions, 'centroid','Circularity');
RegArr = struct2cell(centroids);
RegMat = cell2mat(RegArr.');

N=size(RegMat,1);
molecules = zeros(0,3);

r = 3; % Radius of fit window
gauss2d = @(p, x, y) p(1) * exp(-((x - p(2)).^2 / (2 * p(3)^2) + (y - p(4)).^2 / (2 * p(5)^2))) + p(6); % 2D Gaussian Model

        
% Parameters: [Amplitude, x0, sigma_x, y0, sigma_y, offset]
fitResults = [];

for n = 1:N
    % Extract local region around the initial position
    x0 = round(RegMat(n, 1));
    y0 = round(RegMat(n, 2));
    xRange = max(1, x0-r):min(size(I, 2), x0+r);
    yRange = max(1, y0-r):min(size(I, 1), y0+r);

    subImage = I(yRange, xRange);
    [subX, subY] = meshgrid(xRange, yRange);

    if RegMat(n,1) > edge_pad && RegMat(n,1) < xdim-edge_pad && RegMat(n,2) > edge_pad && RegMat(n,2) < ydim-edge_pad && max(max(subImage)) >= Istd*threshold   

        
        % Initial guess for the parameters
        initialGuess = [max(subImage(:)), x0, 2, y0, 2, min(subImage(:))];
        
        % Least-squares fitting
        options = optimset('Display', 'off');
        [params, resnorm] = lsqcurvefit(@D2GaussFunction, initialGuess, cat(3,subX,subY), subImage, [], [], options);
        
        max_sigma = max([abs(params(3)),abs(params(5))]);
        min_sigma = min([abs(params(3)),abs(params(5))]);
        if max_sigma <= max_radius && min_sigma >= min_radius
            if max_sigma/min_sigma <= max_ellipticity
                % 
                % figure(10);
                % imshow(subImage, [min(min(subImage)), max(max(subImage))],'InitialMagnification',1000,'XData',subX(1,:),'YData',subY(:,1));
                % hold on
                % plot(params(2),params(4),'bx');
                % hold off
                
                fitResults = [fitResults; params];

            end
        end
        
        % molecules=cat(1,molecules,[params(2),params(4)]);
    end
end

% figure(10)
% imshow(I)
% hold on
% plot(fitResults(:,2),fitResults(:,4), 'bo');
% hold off

xy = cat(2,fitResults(:,2),fitResults(:,4));

end

function F = D2GaussFunction(x,xdata)
    F = x(1)*exp(-((xdata(:,:,1)-x(2)).^2/(2*x(3)^2) + (xdata(:,:,2)-x(4)).^2/(2*x(5)^2) )    );
end
