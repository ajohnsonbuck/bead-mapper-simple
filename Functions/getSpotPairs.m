function SpotPairs = getSpotPairs(Coords1,Coords2,Cutoff)
    Distances = pdist2(Coords1,Coords2);
    [MinDistance, MinInd] = min(Distances,[],2);
    SpotPairs.Coords1 = zeros(size(Coords1));
    SpotPairs.Coords2 = SpotPairs.Coords1;
    for n = 1:size(SpotPairs.Coords1,1)
        if MinDistance(n) <= Cutoff
           SpotPairs.Coords1(n,:) = Coords1(n,:);
           SpotPairs.Coords2(n,:) = Coords2(MinInd(n),:);
        end
    end
    SpotPairs.Coords1(all(SpotPairs.Coords1==0,2),:) = [];
    SpotPairs.Coords2(all(SpotPairs.Coords2==0,2),:) = [];
end