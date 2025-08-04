function Tform = makeBeadMap(Args)
arguments
    Args.MovieFile1 {mustBeText} = '';
    Args.MovieFile2 {mustBeText} = '';
    Args.Threshold double = 8; % Threshold for spot finding, in multiples of the standard deviation of the background
    Args.DistanceCutoff double = 2; % Distance cutoff for finding paired beads in translationally registered image
    Args.TranslationDebug logical = false;
    Args.TranslationDebugOffset {mustBeNumeric} = [5, 10];
    Args.CircularityCutoff double = 0.95;
    Args.SpotMethod {mustBeTextScalar} = 'Gaussian';
end

% Load movies from file and generate temporally averaged images
fprintf('Loading movies...\n');
AvgImage = loadBeadImages(Args.MovieFile1,Args.MovieFile2);

if Args.TranslationDebug % Shift X and Y of Acceptor channel according to TranslationDebugOffset
    Movie2Shifted = 0*AvgImage.Movie2;
    dX = Args.TranslationDebugOffset(1);
    dY = Args.TranslationDebugOffset(2);
    Movie2Shifted(1+dY:end,1+dX:end) = AvgImage.Movie2(1:end-dY,1:end-dX);
    AvgImage.Movie2 = Movie2Shifted;
end

f1 = figure(1);
showChannelOverlay(AvgImage.Movie1,AvgImage.Movie2,'Title','Donor + Original Acceptor'); % Unmodified images

fprintf('Getting initial translational offset...\n');
TranslationalOffset = findTranslationalOffset(AvgImage);
AvgImage.Movie2Translated = applyTranslationalOffset(AvgImage.Movie2,TranslationalOffset);

fprintf('Finding bead pairs...\n');
% Find beads in both images
Coords.Movie1 =           findSpots(AvgImage.Movie1,Args.Threshold,10,Args.CircularityCutoff,Args.SpotMethod);
Coords.Movie2Translated = findSpots(AvgImage.Movie2Translated,Args.Threshold,10,Args.CircularityCutoff,Args.SpotMethod);

% Get pairs of bead locations and remove translational offset to match
% original acceptor channel
SpotPairs = getSpotPairs(Coords.Movie1,Coords.Movie2Translated,Args.DistanceCutoff);
SpotPairs.Coords2 = cat(2,SpotPairs.Coords2(:,1)+TranslationalOffset.X,SpotPairs.Coords2(:,2)+TranslationalOffset.Y);
Error = calculateColocalizationError(SpotPairs);
fprintf('%u bead pairs found.\n',height(SpotPairs.Coords1));
fprintf('Before Correction:\n')
fprintf('Avg X Error: %.2f pixels\n',Error.X);
fprintf('Avg Y Error: %.2f pixels\n',Error.Y);

% Plot paired bead locations
plotSpotOverlay(SpotPairs.Coords1,SpotPairs.Coords2,f1);

% Construct and apply transformation to acceptor channel image
Tform = fitgeotrans(SpotPairs.Coords2,SpotPairs.Coords1,'polynomial',3);
ra = imref2d(size(AvgImage.Movie1));
AvgImage.Movie2Corrected = imwarp(AvgImage.Movie2,Tform,'OutputView',ra);

% Plot donor + registered acceptor
f2 = figure(2);
showChannelOverlay(AvgImage.Movie1,AvgImage.Movie2Corrected,'Title','Donor + Registered Acceptor'); % Polynomial-registered acceptor

% Get bead coordinates in registered acceptor, find pairs, and plot overlay with donor bead coordinates
Coords.Movie2Corrected = findSpots(AvgImage.Movie2Corrected,Args.Threshold,10,Args.CircularityCutoff,Args.SpotMethod);
SpotPairsCorrected = getSpotPairs(Coords.Movie1,Coords.Movie2Corrected,Args.DistanceCutoff);
plotSpotOverlay(SpotPairsCorrected.Coords1,SpotPairsCorrected.Coords2,f2);

Error = calculateColocalizationError(SpotPairsCorrected);
fprintf('After Correction:\n')
fprintf('Avg X Error: %.2f pixels\n',Error.X);
fprintf('Avg Y Error: %.2f pixels\n',Error.Y);

end