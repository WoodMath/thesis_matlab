function [F,res] = F_from_x_nonlin(F,m1,m2)

% [F,res] = F_from_x_nonlin(F,m1,m2)
%
% Compute F using non-linear method which minimizes Sampson's approx to
% geometric reprojection error (called 'Gradient criterion" in Luong,
% Faugeras 1996).
% Returns also the array of distances (non squared).
% An initial estimate of F is required.

% This is a wrapper around P. Torr's function for computing F by minimization
% of the Sampson error with the det(F)=0 constraint.
% The interface is the same as vgg_H_from_x_nonlin (see)


no_matches = length(m1);

% force det(F)=0 at input
[U,S,V] = svd(F);
S(3,3) = 0;
F = U*S*V';
f_init = reshape(F',9,1);

% this is from P. Torr
f = torr_nonlinf_mincon2x2(f_init,m1(1,:),m1(2,:),m2(1,:),m2(2,:), no_matches,1);
F = reshape(f, 3, 3); F = F';

% F_sampson_distance_sqr returns *squared distances
res = sqrt(F_sampson_distance_sqr(F,m1,m2));