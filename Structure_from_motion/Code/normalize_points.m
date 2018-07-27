function [ l_points,r_points,H_l,H_r ] = normalize_points( xl,yl,xr,yr )
%NORMALIZE_POINTS Summary of this function goes here
%   normalizes left image and right image points and returns normalizing matrices

n = length(xl);

% Normalizing is done about mean and sigma using Hartley Normalization Algorithm 
l_mean = [sum(xl) sum(yl)]/n;
l_sigma = sum(sqrt(sum(([xl yl]-l_mean).^2,2)))/n;
H_l = [(1/l_sigma)*[eye(2) -l_mean.'];0 0 1]; 
l_points = (H_l * ([xl yl ones(n,1)].')).';


r_mean = [sum(xr) sum(yr)]/n;
r_sigma = sum(sqrt(sum(([xr yr]-r_mean).^2,2)))/n;
H_r = [(1/r_sigma)*[eye(2) -r_mean.'];0 0 1]; 
r_points = (H_r * ([xr yr ones(n,1)].')).';

end

