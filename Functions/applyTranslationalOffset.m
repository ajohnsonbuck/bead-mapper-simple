function Image = applyTranslationalOffset(Image,TranslationalOffset)
    tform = fitgeotrans([0, 0; 1, 1; -1, 1], [-TranslationalOffset.X, -TranslationalOffset.Y; 1-TranslationalOffset.X, 1-TranslationalOffset.Y; -1-TranslationalOffset.X, 1-TranslationalOffset.Y],'affine');
    ra = imref2d(size(Image));
    Image = imwarp(Image,tform,'OutputView',ra);
end