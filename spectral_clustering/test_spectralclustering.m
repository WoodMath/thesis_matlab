close all;
clear all;
img = imread('colorapp_pep.png');

v3_size = size(img);

mat_image = magic(10);

mat_sqr = fnDistance(mat_image,'column','travel');
mat_sqr = mat_sqr/max(max(mat_sqr));
mat_sqr = uint8(mat_sqr*255);
figure;
imshow(mat_sqr);

mat_sim = fnSimilarity(repmat(mat_image, [1,1,3]),'column','gaussian',10);
mat_sim = mat_sim/max(max(max(mat_sim)));
mat_sim = uint8(mat_sim*255);
figure;
imshow(mat_sim);


imshow(uint8(sim*255));

img = reshape(img, [v3_size(1)*v3_size(2),1,v3_size(3)]);
img = permute(img, [1,3,2]);