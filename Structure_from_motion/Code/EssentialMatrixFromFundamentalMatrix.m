function E = EssentialMatrixFromFundamentalMatrix( F,K )
%ESSENTIALMATRIXFROMFUNDAMENTALMATRIX Summary of this function goes here
%   Detailed explanation goes here

[U,~,V] = svd(K.'*F*K);

% Enforcing essential matrix singular values
E = U*diag([1 1 0])*V.';


end

