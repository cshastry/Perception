function inhomogenous_points = dehomogenize( x )
%DEHOMOGENIZE Summary of this function goes here
%  dehomogenize points by dividing with last row elements

inhomogenous_points = x(:,1:2)./x(:,3);

end

