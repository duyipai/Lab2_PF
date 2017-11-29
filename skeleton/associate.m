% function [outlier,Psi] = associate(S_bar,z,W,Lambda_psi,Q)
%           S_bar(t)            4XM
%           z(t)                2Xn
%           W                   2XN
%           Lambda_psi          1X1
%           Q                   2X2
% Outputs: 
%           outlier             1Xn
%           Psi(t)              1XnXM
function [outlier,Psi] = associate(S_bar,z,W,Lambda_psi,Q)
% FILL IN HERE

%BE SURE THAT YOUR innovation 'nu' has its second component in [-pi, pi]
    n = size(z, 2);
    M = size(S_bar, 2);
    N = size(W, 2);
    h = zeros(n, M, 2, N);
    z = z';
    z = repmat(reshape(z, n, 1, 2), 1, M, 1);
    z = repmat(z, 1, 1, 1, N);
    for i = 1:n % n
        for j = 1:N
            ht = observation_model(S_bar, W, j);
            ht = reshape(ht', 1, M, 2);
            h(i,:,:,j) = ht;
        end
    end
    nu = z - h;
    nu(:,:,2,:) = mod(nu(:,:,2,:)+pi, 2*pi)-pi;
    Psi = zeros(n, M, N);
    deno = 1/2/pi/det(Q)^(1/2);
    for i = 1:n 
        for j = 1:N
            nu_i = reshape(nu(i,:,:,j), M, 2)';
            Psi(i, :, j) = deno * exp(-1/2*sum(nu_i.*(Q\nu_i)));
        end
    end
    Psi = max(Psi, [], 3);
    outlier = (sum(Psi,2)/M) < Lambda_psi;
    Psi =reshape(Psi, 1, n, M);
end
