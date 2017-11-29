% function S_bar = weight(S_bar,Psi,outlier)
%           S_bar(t)            4XM
%           outlier             1Xn
%           Psi(t)              1XnXM
% Outputs: 
%           S_bar(t)            4XM
function S_bar = weight(S_bar,Psi,outlier)
% FILL IN HERE

%BE CAREFUL TO NORMALIZE THE FINAL WEIGHTS
if (prod(outlier) == 1)
    return;
end
M= size(Psi, 3);
outlier = repmat(outlier, 1, 1, M);
Psi = Psi+outlier.*(ones(size(Psi))-Psi);
product = prod(Psi, 2);
S_bar(4,:) = product;
S_bar(4, :) = S_bar(4, :) / sum(S_bar(4, :));
end
