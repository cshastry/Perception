function skew = Vec2Skew( v )
%VEC2SKEW Summary of this function goes here
%  Converts given vector v to skew symmetric matrix

skew = [0 -v(3) v(2);v(3) 0 -v(1);-v(2) v(1) 0];

end

