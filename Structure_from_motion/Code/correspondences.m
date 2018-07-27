function [ x1,x2,RGB,correspondence_idx ] = correspondences( Mu,Mv,v,RGB,imageIndex1,imageIndex2 )
%CORRESPONDENCES Summary of this function goes here
%   This function takes in Visibility matrix and coordinate matrices to
%   gives feature correspondences between imageIndex1 and imageIndex2 

% Finding correspondence indices between Image1 and Image 2
correspondence_idx = find((v(:,imageIndex1) + v(:,imageIndex2)) == 2);
x1 = [Mu(correspondence_idx,imageIndex1) Mv(correspondence_idx,imageIndex1)];
x2 = [Mu(correspondence_idx,imageIndex2) Mv(correspondence_idx,imageIndex2)];
RGB = RGB(correspondence_idx,1:3);

end

