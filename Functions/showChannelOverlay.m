function showChannelOverlay(Image1,Image2,Args)
    arguments
        Image1
        Image2
        Args.Title {mustBeTextScalar}
    end
    I = zeros(height(Image1),width(Image1),3);
    I(:,:,1) = double((Image2 - median(Image2(:)))/(quantile(Image2(:),0.998)-median(Image2(:)))); % Acceptor channel
    I(:,:,2) = double((Image1 - median(Image1(:)))/(quantile(Image1(:),0.998)-median(Image1(:)))); % Donor channel
    imshow(I,[min(I(:)),max(I(:))/10]);
    title(Args.Title)
end