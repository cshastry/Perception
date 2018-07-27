clear
clc
close all

% Parsing Correspondency data
[Mu,Mv,v,RGB] = ParseData('data');

% Camera Calibration Matrix
K = [568.996140852, 0, 643.21055941;

     0, 568.988362396, 477.982801038;

     0, 0, 1];

% Finding correspondences between image 1 and 2
[x1,x2,feature_RGB,feature_idx] = correspondences(Mu,Mv,v,RGB,1,2);
 
% RANSAC applied on  images to get inliers y1 and y2 along with their
% indices idx
[y1, y2, idx] = GetInliersRANSAC(x1, x2);
 
% Estimating Fundamental Matrix using inlier points
F = EstimateFundamentalMatrix(y1, y2);

% Extracting Essential Matrix from 
E = EssentialMatrixFromFundamentalMatrix(F, K);

% Extracting possible sets of Camera poses
[Cset, Rset] = ExtractCameraPose(E);



% Setting First Camera Pose to Global origin
C1 = zeros(3,1);
R1 = eye(3); 

% Preallocating cell array for Storing possible Triangulations(3D points)
Xset = cell(4,1); 

% Triangulating X's for Different camera poses
for i = 1:4    
    
    Xset{i} =  LinearTriangulation(K, C1, R1, Cset{i}, Rset{i}, y1, y2); 

end 

% Computing true Camera Pose and True values for X  
[Ctrue, Rtrue, Xtrue] = DisambiguateCameraPose(Cset, Rset, Xset);

% %% 3D POINT CLOUD GENERATION
% 
% % Trimming Xtrue points for Generating point cloud
 trim_condition = Xtrue(:,3) > 0;
 trimmed_indices = find(trim_condition);
 trimmedX = Xtrue(trimmed_indices,:);
% 
 PC3Dshow(trimmedX, {Ctrue,C1}, {Rtrue,R1}, feature_RGB(trimmed_indices,:));

%% CAMERA AND POINT GENERATION

 scale = 5;

 PlotCamerasAndPoints({Ctrue,C1}, {Rtrue,R1}, Xtrue, scale);

 

%% REPROJECTION
Image1 = imread('data/image0000001.bmp');
Image2 = imread('data/image0000002.bmp');
plot_reprojection(Image2, Rtrue, Ctrue, K, Xtrue, y2); 

%% FEATURE MATCHING

showMatchedFeatures(Image1,Image2,y1,y2,'montage','Parent',gca);

