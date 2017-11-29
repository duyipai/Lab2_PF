% function [S_bar] = predict(S,u,R)
% This function should perform the prediction step of MCL
% Inputs:
%           S(t-1)              4XM
%           v(t)                1X1
%           omega(t)            1X1
%           R                   3X3
%           delta_t             1X1
% Outputs:
%           S_bar(t)            4XM
function [S_bar] = predict(S,v,omega,R,delta_t)
% FILL IN HERE
length = size(S, 2);
noise = mvnrnd([0,0,0], R, length);
noise = [noise';zeros(1,length)];
theta = [0,0,1,0]*S;
u = repmat([v*delta_t;v*delta_t;omega*delta_t;0],1,length).*[cos(theta);sin(theta);ones(size(theta));zeros(size(theta))];
S_bar = S +u + noise;
end