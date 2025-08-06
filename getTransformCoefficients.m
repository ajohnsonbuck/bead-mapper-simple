function Coeffs = getTransformCoefficients(tform,tformInv)
% Get polynomial coefficients 

% Acceptor --> Donor
Coeffs.M21x = tformInv.A;  % X coefficients
Coeffs.M21y = tformInv.B;  % Y coefficients
% Donor --> Acceptor
Coeffs.M12x = tform.A; % X coefficients
Coeffs.M12y = tform.B; % Y coefficients

Coeffs.FullModel = [Coeffs.M21x' Coeffs.M21y' Coeffs.M12x' Coeffs.M12y'];

end