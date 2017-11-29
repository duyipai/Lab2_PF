
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
sz = size(S, 2);
h = zeros(2, sz);
for i = 1:sz
    tx = S(1, i);
    ty = S(2, i);
    ttheta = S(3, i);
    h(:,i) = [sqrt((x-tx)^2+(y-ty)^2);mod(atan2(y-ty, x-tx)-ttheta+pi, 2*pi)-pi];
end
end