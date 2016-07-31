close all;
clear all;

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;

if(isOctave)
    mat_img = loadimage('colorapp_pep.png');
else
    mat_img = imread('fruit-basket.png');
end

mat_seg = fnSegment(mat_img);
% v3_size = size(img);


% mat_image = magic(10);
% mat_image = repmat(mat_image, [1,1,3]);
% 
% mat_dist = fnDistance(mat_image,'column','gaussian',10);
% mat_sim = fnSimilarity(mat_image,'column','gaussian',10);
% 
% f_sim_weight = 0.8;
% mat_use = mat_dist.^(1-f_sim_weight).*mat_sim.^(f_sim_weight);
