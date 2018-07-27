function [ C ,R, X0 ] = DisambiguateCameraPose( Cset,Rset,Xset )
%DISAMBIGUATECAMERAPOSE Summary of this function goes here
%   Detailed explanation goes here
n = 0;


for i = 1:length(Cset)
    
    % Check cheirality condition for camera i
    E = ((Rset{i}(3,:)*(Xset{i} - Cset{i}.').').' > 0) & (Xset{i}(:,3) > 0);
    
    if length(find(E)) > n
        n = length(find(E));
        R = Rset{i};
        C = Cset{i};
        X0 = Xset{i};
    end
    
end


end

