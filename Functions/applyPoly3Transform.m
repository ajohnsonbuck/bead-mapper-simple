function CoordsOut = applyPoly3Transform(Tform,Coords,Direction)
% Apply 3rd-order polynomial transformation from one set of x,y coordinates
% to another
arguments
    Tform % Struct with fields M21x, M21y, M12x, M12y, Fullmodel
    Coords double % m x 2 array of coordinates where col 1 = x, col 2 = y
    Direction {mustBeTextScalar} % 'Forward' = Channel1-->Channel2, 'Reverse' = Channel2-->Channel1
end

% Determine whether transformation is ch1-->2 or ch2-->1
if strcmpi(Direction,'Forward')
    Mx = Tform.M12x;
    My = Tform.M12y;
elseif strcmpi(Direction,'Reverse')
    Mx = Tform.M21x;
    My = Tform.M21y;
else
    error('Direction must be "Forward" or "Reverse"');
end

B = makepol(Coords(:,1),Coords(:,2),3); % Make 3rd-order polynomials from coordinates

Xcorr = Mx*B'; % Multiply polynomials by coefficient vectors to convert
Ycorr = My*B';

CoordsOut = [Xcorr', Ycorr'];

end