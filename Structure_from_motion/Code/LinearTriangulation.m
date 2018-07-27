function X = LinearTriangulation( K,C1,R1,C2,R2,x1,x2 )
%LINEARTRIANGULATION Summary of this function goes here
%   Detailed explanation goes here

P1 = K*R1*[eye(3) -C1];
P2 = K*R2*[eye(3) -C2];

X = zeros(length(x1),4);

for i = 1:length(x1)
    
    skew1 = Vec2Skew([x1(i,:) 1]);
    skew2 = Vec2Skew([x2(i,:) 1]);
    
    A = [skew1*P1;skew2*P2];
    [~,~,V] = svd(A);
    X(i,:) = (V(:,end)./V(end,end)).';
    
end

% % % Noisy system
% X = zeros(length(x1),3);
% R = R2.'*R1;
% C = 
% 
% for i = 1:length(x1)
%     
%     pl = K\[x1(i,:) 1].';
%     pr = K\[x2(i,:) 1].';
%     
%     A = [pl -R.'*pr cross(pl,R.'*pr)];
%     B = -R.'*C;
%     
%     sol = A\B;
%     
% %     X(i,:) = ((sol(1)*A(:,1) - sol(2)*A(:,2))/2).';
%     X(i,:) = ((sol(1)*pl +(-R.'*C)+sol(2)*R.'*pr)/2).';
%     
% end
% 
X = X(:,1:3);


end

