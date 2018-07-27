function [ y1,y2,idx ] = GetInliersRANSAC( l_points,r_points )
%GETINLIERSRANSAC Summary of this function goes here
% Computes inliers in points using RANSAC with geometric error function
% Fundamental Matrix Estimation by Ming Zhang
% https://www.researchgate.net/publication/284030965_Fast_and_Robust_Algorithm_for_Fundamental_Matrix_Estimation

n = 0;
epsilon = 6;

% Normalizing points to for use in geometric error function
[x1,x2,~,~] = normalize_points(l_points(:,1),l_points(:,2),r_points(:,1),r_points(:,2));




for i = 1:2000
    
    % Pick 8 indices randomly without replacement
    star = randperm(length(l_points),8); 
    
    % Estimate fundamental matrices with points corresponding to randomly
    % picked indices
    F = EstimateFundamentalMatrix(x1(star,:),x2(star,:)); 
    
    % Preallocate error vector
    E = zeros(length(l_points),1);
    
    % Computing geometric error    
    for j = 1:length(l_points)
        
        E(j) = (1/2)*sum((norm((x1(j,:).' - F*x1(j,:).'),'fro'))^2 + (norm((x2(j,:).' - F'*x2(j,:).'),'fro'))^2);
        
    end
    
    
    % Compare norm of each value in E to epsilon
    E = abs(E) < epsilon;
    
    % Find indices of elements having non-zero values
    S = find(E);
    
    % Take indices such that maximum number of inliers are available
    if n < length(S)
        n = length(S);
        idx = E;
    end
    
end

% Output inliers corresponding to indices in S
y1 = l_points(S,:);
y2 = r_points(S,:);



end

