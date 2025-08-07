function AvgImage = getAverageImage(MovieFile)
    MovieInfo = imfinfo(MovieFile);
    NFrames = length(MovieInfo);
    EndFrame = min([NFrames, 100]);
    [~,FileName] = fileparts(MovieFile);
    waitstr = sprintf('Loading bead movie "%s"...',FileName);
    wb1 = waitbar(0,waitstr);
    setTIFFWarnings('off');
    Movie = Tiff(MovieFile,"r");
    I = single(zeros(MovieInfo(1).Height,MovieInfo(1).Width,EndFrame));
    for n = 1:EndFrame
        Movie.setDirectory(n);
        I(:,:,n) = Movie.read();
        waitbar(n/EndFrame,wb1);
    end
    setTIFFWarnings('on');
    delete(wb1);
    AvgImage = double(mean(I,3));
end

function setTIFFWarnings(State)
arguments
    State {mustBeTextScalar} % 'on' or 'off'
end
    % warning(State,'MATLAB:imagesci:tiffmexutils:libtiffWarning');
    % warning(State,'imageio:tiffmexutils:libtiffWarning');
    warning(State,'imageio:tiffutils:libtiffWarning');
end