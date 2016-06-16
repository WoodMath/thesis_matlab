
img = imread('colorapp_pep.png');

v3_size = size(img);

fnDist([0],'method');

img = reshape(img, [v3_size(1)*v3_size(2),1,v3_size(3)]);
img = permute(img, [1,3,2]);