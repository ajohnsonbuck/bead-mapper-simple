function Coords = findSpotsAllMovies(app, AvgImage, Options)
    arguments
        app
        AvgImage struct % Struct of average bead images; 
        Options struct % Struct of analysis options
    end

    FieldNames = fieldnames(AvgImage);

    for n = 1:numel(FieldNames)
        Coords.(FieldNames{n}) = findSpots(AvgImage.(FieldNames{n}),...
                                                    Options.EdgePixels,...
                                                    Options.Threshold,...
                                                    Options.CircularityCutoff,...
                                                    Options.EllipticityCutoff,...
                                                    Options.SpotMethod);
    end
end