function F = EstimateFundamentalMatrix( l_points,r_points )
%ESTIMATEFUNDAMENTALMATRIX Summary of this function goes here
% Takes points from left image and right to compute Fundamental Matrix

n = length(l_points);

xl = l_points(:,1);
yl = l_points(:,2);

xr = r_points(:,1);
yr = r_points(:,2);


%% Creating matrix A such that  Af = 0

A = [xl.*xr, yl.*xr, xr, xl.*yr, yl.*yr, yr, xl, yl, ones(n,1)];       
[~,~,V] = svd(A);
x = V(:,9);

% Fundamental Matrix
F = [x(1) x(2) x(3);x(4) x(5) x(6);x(7) x(8) x(9)]; 

[U,S,V] = svd(F);

% Enforcing rank(F) = 2 and Reconstituting F
S(end,end) = 0; 
F = U*S*V.';  



end

