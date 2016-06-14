function [ img_out ] = fnNormalize( img_in )
%fnNormalize converts image to range (0,255)
%   Detailed explanation goes here
   
    img_temp = img_in;

%     img_out = im2uint8(uint16(img_temp));
%     return;    
    
    img_temp = img_temp - repmat(min(min(img_temp)), [size(img_temp,1), size(img_temp,2), 1]);
    img_temp = img_temp./repmat(max(max(img_temp)), [size(img_temp,1), size(img_temp,2), 1]);
    img_out = uint8(img_temp*255);


end

