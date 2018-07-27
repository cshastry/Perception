function [Mu, Mv, V, RGB] = ParseData(folder)
%% Parse raw data and encode them into proper data structure (e.g. a search table)
%% Author: Haoyuan Zhang

% [Input] folder
% - represents the directory of all stored data.

% [Output] Mu/Mv (N x num_frame):
%  - represents correspondences in all frames in u/v dimension.
%  e.g. Mu[i, :]: stores the ith feature position in all frames, if the jth frame doesn't be observed by 
%  the ith feature, Mu[i, j] = 0, otherwise, Mu[i ,j] stores the u coordinate of ith feature in jth camera frame. Same as Mv.

% [Output] V (N x num_frame): 
%  - represents the visible state of each observed feature in all frames.
%  e.g. V[i, :]: stores the visible state of the ith feature, V[i, j] = 1 means the ith feature can be seen in
%  the jth camera, otherwise, V[i, j] = 0.

% [Output] RGB (N x 3): 
%  - store RGB information for each observed feature.

%%
% the folder stores correspondences matching data
srcFiles = dir([folder '/matching*.txt']);  
nfiles = length(srcFiles);

% Mu and Mv store u and v coordinates respectfully
Mu = []; Mv = []; 

% V is the visibility matrix
V = []; RGB = [];
for i = 1 : nfiles
    filename = strcat('data/matching', int2str(i), '.txt');
    
    % store matching data into matrix form
    [mu, mv, v, rgb] = createMatrix(filename, i, 6);
    Mu = [Mu; mu];
    Mv = [Mv; mv];
    V = [V; v];
    RGB = [RGB; rgb];
end

end


%% encode data function
function [Mu, Mv, v, rgb] = createMatrix(filename, image_idx, nImages)

% Your Code Goes Here
filedata = dlmread(filename,'',1,0);

number_of_rows = size(filedata,1);
number_of_columns = size(filedata,2);

% Columns 2 to 4 contain RGB data of features
rgb = filedata(:,2:4); 

% Initializing Matrices
v = zeros(number_of_rows,nImages);  
Mu = zeros(number_of_rows,nImages); 
Mv = zeros(number_of_rows,nImages);

% Feature is always visible in current image
v(:,image_idx) = ones(number_of_rows,1); 
Mu(:,image_idx) = filedata(:,5);
Mv(:,image_idx) = filedata(:,6);



for i = 7:3:number_of_columns
    for j = (image_idx+1):nImages
        
        % Finding row indices of elements of ith column which are equal to
        % the current image index j
        a = find(filedata(:,i)==j);
        
        % If condition to ensure a is not a null matrix
        if ~isempty(a)
            v(a,j) = 1;
            Mu(a,j) = filedata(a,i+1);
            Mv(a,j) = filedata(a,i+2);
        end      
    end    
end


end



































