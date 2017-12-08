
% function h = observation_model(S,W,j)
% This function is the implementation of the observation model
% The bearing should lie in the interval [-pi,pi)
% Inputs:
%           S           4XM
%           W           2XN
%           j           1X1
% Outputs:  
%           h           2XM
function h = observation_model(S,W,j)
% FILL IN HERE
    x = W(1,j);
    y = W(2, j);
    M = size(S, 2);
    h1x = [x - S(1,:); zeros(1, M)];
    h1y = [y - S(2, :); zeros(1, M)];
    h1 = h1x.^2 + h1y.^2;
    h1 = sqrt(h1);
    h2 =[zeros(1, M); atan2(h1y(1, :), h1x(1, :))- S(3, :)];
    h2 = mod(h2 + pi, 6.283185307179586) - pi;
    h = h1 + h2;
end