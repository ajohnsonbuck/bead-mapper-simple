function Coords = findSpots(Image, Threshold, EdgePixels, CircularityCutoff, SpotMethod)
    arguments
        Image {mustBeNumeric} % spot image
        Threshold double = 8;
        EdgePixels double = 10;
        CircularityCutoff double = 0.95;
        SpotMethod {mustBeTextScalar} = 'Centroid'; % Gaussian or Centroid
    end
    
    if strcmpi(SpotMethod,'Gaussian')
        Coords = PeakFinderLSGaussian(Image, Threshold, EdgePixels);
    elseif strcmpi(SpotMethod,'Centroid')
        Coords = PeakFinderCentroid(Image, Threshold, EdgePixels, CircularityCutoff);
    else
        error('Argument SpotMethod for findSpots() must be "Gaussian" or "Centroid".')
    end
end