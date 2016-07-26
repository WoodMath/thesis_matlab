

%% Call fnRectify

%% Call fnScanline

% [a,b]=fnFindPath([0 0 1 0 0 1],[0 1 0 0 1 0],0.01);

im_left = imread('./cones/im0.ppm');
im_right = imread('./cones/im8.ppm');


fnScanline(im_left, im_right, 5);