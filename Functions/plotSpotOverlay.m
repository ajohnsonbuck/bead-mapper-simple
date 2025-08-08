function plotSpotOverlay(Coords1,Coords2,FigureHandle)
    arguments
        Coords1 double
        Coords2 double
        FigureHandle
    end
    figure(FigureHandle);
    hold on
    plot(Coords1(:,1),Coords1(:,2),'gs');
    plot(Coords2(:,1),Coords2(:,2),'ro');
    hold off
end