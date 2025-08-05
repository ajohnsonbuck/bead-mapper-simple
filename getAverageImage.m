function AvgImage = getAverageImage(MovieFile)
    MovieInfo = imfinfo(MovieFile);
    NFrames = length(MovieInfo);
    EndFrame = min([NFrames, 100]);
    % I = single(zeros(MovieInfo(1).Height,MovieInfo(1).Width,EndFrame));
    I = single(tiffreadVolume(MovieFile, 'PixelRegion', {[1 MovieInfo(1).Height], [1 MovieInfo(1).Width], [1 EndFrame]}));
    AvgImage = double(mean(I,3));
end