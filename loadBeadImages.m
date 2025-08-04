function AvgImage = loadBeadImages(MovieFile1,MovieFile2)
    if ~isempty(MovieFile1)
        AvgImage.Movie1 = getAverageImage(MovieFile1);
    end
    if ~isempty(MovieFile2)
        AvgImage.Movie2 = getAverageImage(MovieFile2);
    else
        AvgImage.Movie2 = [];
    end
    
    if isempty(AvgImage.Movie2) % If second movie file not provided, assume first movie should be split into left and right halves
        AvgImage.Movie2 = AvgImage.Movie1(:,width(AvgImage.Movie1)/2+1:end);
        AvgImage.Movie1 = AvgImage.Movie1(:,1:width(AvgImage.Movie1)/2);
    end
end