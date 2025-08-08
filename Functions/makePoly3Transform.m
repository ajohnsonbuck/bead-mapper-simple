function Tform = makePoly3Transform(Coords1,Coords2)
    % Make forward and reverse 3rd-order polynomial transformation from one
    % set of XY coordinates (Coords1) to another (Coords2)
    arguments
        % Coords = m x 2 array of coordinates where col 1 = x, col 2 = y
        Coords1 double % Channel 1 (e.g., donor)
        Coords2 double % Channel 2 (e.g., acceptor)
    end

    % 3rd-order polynomial terms for each 
    B1 = makepol(Coords1(:,1),Coords1(:,2),3);
    B2 = makepol(Coords2(:,1),Coords2(:,2),3);
    
    % Vectors of coefficients by which to multiply polynomials to convert from Coords 2 to Coords 1 and vice-versa
    Tform.M21x=Coords1(:,1)'/B2';
    Tform.M21y=Coords1(:,2)'/B2';
    Tform.M12x=Coords2(:,1)'/B1';
    Tform.M12y=Coords2(:,2)'/B1';

    Tform.Fullmodel = [Tform.M21x' Tform.M21y' Tform.M12x' Tform.M12y'];
end