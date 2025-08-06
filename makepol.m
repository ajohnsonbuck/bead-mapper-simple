function B =makepol(x,y,n)
B=[];
for m=1:length(x)
    if n==3
        A=[1 x(m) y(m) x(m)*y(m) x(m)^2 y(m)^2 x(m)^2*y(m) x(m)*y(m)^2 x(m)^3 y(m)^3];
    end
    if n==4
        A=[1 x(m) y(m) x(m)*y(m) x(m)^2 y(m)^2 x(m)^2*y(m) x(m)*y(m)^2 x(m)^3 y(m)^3 x(m)^3*y(m) x(m)^2*y(m)^2 x(m)*y(m)^3 x(m)^4 y(m)^4];
    end
    
    B=[B;A];
end