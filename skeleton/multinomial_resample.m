
% function S = multinomial_resample(S_bar)
% This function performs systematic re-sampling
% Inputs:   
%           S_bar(t):       4XM
% Outputs:
%           S(t):           4XM
function S = multinomial_resample(S_bar)
% FILL IN HERE
    c = cumsum(S_bar(4,:));
    S = zeros(size(S_bar));
    m = size(S_bar, 2);
    S_bar(4, :) = 1/m;
    t =rand(1, m);
    idxs = arrayfun(@(x)find(c > x, 1), t);
    i =1:m;
    S(:,i) = S_bar(:,idxs);
end
