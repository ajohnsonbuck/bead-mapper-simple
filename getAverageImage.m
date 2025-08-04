function AvgImage = getAverageImage(MovieFile)
    MovieInfo = imfinfo(MovieFile);
    NFrames = length(MovieInfo);
    EndFrame = min([NFrames, 100]);
    I = single(zeros(MovieInfo(1).Height,MovieInfo(1).Width,EndFrame));
    for n = 1:size(I,3)
        I(:,:,n) = single(imread(MovieFile));
    end
    AvgImage = double(mean(I,3));
end