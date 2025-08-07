function [Results, logText] = calculateError(SpotPairs,SpotPairsCorrected,Results)
    arguments
        SpotPairs struct    % Struct of spot pairs from original images (w/ translation only)
        SpotPairsCorrected struct % Struct of registered spot pairs
        Results struct % Results from analysis
    end
    % Calculate mean error of colocalization between paired beads before and after correction
    Results.InitialError = calculateColocalizationError(SpotPairs);
    logText{1} = sprintf('%u bead pairs found.\n',height(SpotPairs.Coords1));
    logText{2} = sprintf('Before Correction:\nAvg X Error: %.2f pixels\nAvg Y Error: %.2f pixels\n',...
        Results.InitialError.X, Results.InitialError.Y);
    Results.FinalError = calculateColocalizationError(SpotPairsCorrected);
    logText{3} = sprintf('After Correction:\nAvg X Error: %.2f pixels\nAvg Y Error: %.2f pixels\n',...
        Results.FinalError.X, Results.FinalError.Y);

    QCresult = doQC(SpotPairs,Results);
    logText = [logText, QCresult'];
end

function logText = doQC(SpotPairs,Results)
    warnings = {'Warning:'};
    if height(SpotPairs.Coords1) < 50
        warnings = [warnings; {'Fewer than 50 spot pairs found.  Please use caution in applying this map, as mapping may not be uniform or accurate.'}];
    end
    if Results.FinalError.X > 1 || Results.FinalError.Y > 1
        warnings = [warnings; {'Final error > 1 pixel.  Mapping may not be accurate.'}];
    end
    if numel(warnings)>1
        msgbox(warnings);
        logText = warnings{2:end};
    else
        logText = 'Mapping successful!';
    end
end