% function [outlier,Psi] = associate_known(S_bar,z,W,Lambda_psi,Q,known_associations)
%           S_bar(t)            4XM
%           z(t)                2Xn
%           W                   2XN
%           Lambda_psi          1X1
%           Q                   2X2
%           known_associations  1Xn
% Outputs: 
%           outlier             1Xn
%           Psi(t)              1XnXM
function [outlier,Psi] = associate_known(S_bar,z,W,Lambda_psi,Q,known_associations)
% FILL IN HERE

%BE SURE THAT YOUR innovation 'nu' has its second component in [-pi, pi]

% also notice that you have to do something here even if you do not have to maximize the likelihood.
    n = size(z, 2);
    M = size(S_bar, 2);
    h = zeros(n, M, 2);
    z = z';
    z = repmat(reshape(z, n, 1, 2), 1, M, 1);
    for i = 1:n % n
        ht = observation_model(S_bar, W, known_associations(i));
        ht = reshape(ht', 1, M, 2);
        h(i,:,:) = ht;
    end
    nu = z - h;
    nu(:,:,2) = mod(nu(:,:,2)+pi, 6.283185307179586)-pi;
    Psi = zeros(n, M);
    deno = 0.159154943091895/det(Q)^(1/2);
    for i = 1:n % n
        nu_i = reshape(nu(i,:,:), M, 2)';
        Psi(i, :) = deno * exp(-0.5*sum(nu_i.*(Q\nu_i)));
    end
    outlier = ((sum(Psi, 2)/M) < Lambda_psi)';
    Psi =reshape(Psi, 1, n, M);
end
