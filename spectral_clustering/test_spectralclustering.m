
img = imread('colorapp_pep.png');

v3_size = size(img);

mat_image = magic(100);

sqr = fnDist(mat_image,'column','travel');

imshow(uint8(sqr));

img = reshape(img, [v3_size(1)*v3_size(2),1,v3_size(3)]);
img = permute(img, [1,3,2]);