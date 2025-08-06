function [Results, logText] = calculateError(SpotPairs,SpotPairsCorrected,Results)
    % Calculate mean error of colocalization between paired beads before and after correction
    Results.InitialError = calculateColocalizationError(SpotPairs);
    logText{1} = sprintf('%u bead pairs found.\n',height(SpotPairs.Coords1));
    logText{2} = sprintf('Before Correction:\nAvg X Error: %.2f pixels\nAvg Y Error: %.2f pixels\n',...
        Results.InitialError.X, Results.InitialError.Y);
    Results.FinalError = calculateColocalizationError(SpotPairsCorrected);
    logText{3} = sprintf('After Correction:\nAvg X Error: %.2f pixels\nAvg Y Error: %.2f pixels\n',...
        Results.FinalError.X, Results.FinalError.Y);
end