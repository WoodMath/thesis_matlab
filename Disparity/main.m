
close all
%% Call fnRectify

%% Call fnScanline

% [a,b]=fnFindPath([0 0 1 0 0 1],[0 1 0 0 1 0],0.01);

% im_left = imread('./cones/im0.ppm');
% im_right = imread('./cones/im8.ppm');

im_left = imread('./tsukuba/scene1.row3.col1.ppm');
im_right = imread('./tsukuba/scene1.row3.col5.ppm');

% [mat_cost, mat_back] = fnFindPath([0 0 1 0 0 1], [0 1 0 0 1 0], 0.01);

% return



[img_out_left, img_out_right] = fnScanline(im_left, im_right, 3, 0.00001);

figure;
imagesc(img_out_left);

figure;
imagesc(img_out_right);
