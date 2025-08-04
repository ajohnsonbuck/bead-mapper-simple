function ChannelOffset = findTranslationalOffset(AvgImage)
    output = dftregistration(fft2(AvgImage.Movie2),fft2(AvgImage.Movie1),100);
    ChannelOffset.X = output(1,4);
    ChannelOffset.Y = output(1,3);
end