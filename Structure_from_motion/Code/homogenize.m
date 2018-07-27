function  homogeneous_points  = homogenize( x )
%HOMOGENIZE Summary of this function goes here
%   Homogenizes given points x by adding column of zeros

homogeneous_points = [x, ones(length(x),1)];

end

