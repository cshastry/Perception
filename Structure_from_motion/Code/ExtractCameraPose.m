function [ Cset,Rset ] = ExtractCameraPose( E )
%EXTRACTCAMERAPOSE Summary of this function goes here
% Given Essential Matrix E compute the possible camera poses of the system

[U,~,V] = svd(E);
W = [0 -1 0;1 0 0;0 0 1];

Rset = {U*W*V.',U*W*V.',U*W.'*V.',U*W.'*V.'};
tset = {U(:,3),-U(:,3),U(:,3),-U(:,3)}

for i=1:4
    Cset{i} = -(Rset{i}.')*tset{i};
    
    % Enforcing positive determinant condition for Rset{i}
    if det(Rset{i})<0
        Rset{i} = -Rset{i};
        Cset{i} = -Cset{i};
    end
end

end

