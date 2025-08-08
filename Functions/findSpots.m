function Coords = findSpots(Image, Threshold, EdgePixels, CircularityCutoff, EllipticityCutoff, SpotMethod)
    arguments
        Image {mustBeNumeric} % spot image
        Threshold double = 8; % Threshold for spot finding (for Centroid: multiples of s.d. of background; for Gaussian, 
        EdgePixels double = 10; % Pixels to ignore near edge of image
        CircularityCutoff double = 0.95; % for Centroid fitting
        EllipticityCutoff double = 1.25; % for Gaussian fitting
        SpotMethod {mustBeTextScalar} = 'Centroid'; % Gaussian or Centroid
    end
    
    if strcmpi(SpotMethod,'Gaussian')
        Coords = PeakFinderLSGaussian(Image, Threshold, EdgePixels, EllipticityCutoff);
    elseif strcmpi(SpotMethod,'Centroid')
        Coords = PeakFinderCentroid(Image, Threshold, EdgePixels, CircularityCutoff);
    else
        error('Argument SpotMethod for findSpots() must be "Gaussian" or "Centroid".')
    end
end