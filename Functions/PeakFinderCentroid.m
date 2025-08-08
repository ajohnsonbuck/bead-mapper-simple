function Coords = PeakFinderCentroid(Image,Threshold,EdgePixels,CircularityCutoff)
    IBG = sort(Image(:));
    IBG = IBG(1:round(numel(IBG)*0.9));
    Threshold = Threshold*std(IBG);
    IAvgCut = Image;
    IAvgCut(IAvgCut<0) = 0;
    IAvg2Supp = imhmax(IAvgCut,Threshold, 8); %Suppress local maxima
    Regions = logical(imregionalmax(IAvg2Supp));
    Centroids = regionprops(Regions, 'centroid'); RegArr = struct2cell(Centroids); RegMat = cell2mat(RegArr.');
    Circularity = regionprops(Regions, 'Circularity'); Circularity = struct2cell(Circularity); Circularity = cell2mat(Circularity);

    Coords = zeros(0,2);
    for n = 1:size(RegMat,1)
        if RegMat(n,1)>EdgePixels && RegMat(n,1)<size(Image,2)-EdgePixels && RegMat(n,2)>EdgePixels && RegMat(n,2)<size(Image,1)-EdgePixels  % Excludes everything within specified number of  pixels of the edge
            if Circularity(n) >= CircularityCutoff
                Coords=cat(1,Coords,RegMat(n,:));
            end
        end
    end
end