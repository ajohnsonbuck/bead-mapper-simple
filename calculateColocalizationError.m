function Error = calculateColocalizationError(SpotPairs)
    Dist = SpotPairs.Coords2 - SpotPairs.Coords1;
    Dist = mean(abs(Dist),1);
    Error.X = Dist(1);
    Error.Y = Dist(2);
end