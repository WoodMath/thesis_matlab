function g = gric(res, sigma, Nt, model)

% Compute GRIC for several models
% Nt is the **total** number of matches, including outliers

% "affine" is an affine fundamental matrix
% "affinity" is an afine transformation of the plane (special case of
% homography)

% Assume that res are the ** squared ** residuals (takes directly the
% output of vgg_H_sampson_distance_sqr and F_sampson_distance_sqr

switch lower(model)
    case {'general','fundamental'}

        K = 7; % number of parameters
        D = 3; % dimension of the manifold

    case 'affine'

        K = 4; % number of parameters
        D = 3; % dimension of the manifold


    case 'homography'
        
        K = 8; % number of parameters
        D = 2; % dimension of the manifold


    case 'affinity'

        K = 6; % number of parameters
        D = 2; % dimension of the manifold


    otherwise
        disp('Unknown model.')
end

R = 4; % dimension of the data (pairs of image points)


res = min(res/sigma^2, ones(size(res))*2*(R-D));

g = sum(res) + Nt*D*log(R) +  K*log(R*Nt);

% Nota: res viene da sampson, che  ritorna gia' i quadrati delle distanze

