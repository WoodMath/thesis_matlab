function [ img_out ] = fnMask( img_in, v2_center, v2_size)
%fnMask Summary of this function goes here
%   Detailed explanation goes here

    mat_mask = ones(2*v2_size(1) + 1, 2*v2_size(2) +1);
    
    img_out = mat_mask;
    img_out = repmat(img_out, [1,1,size(img_in,3)]);
    return;
    
    u_padd = v2_center(1) - v2_size(1) - 1;
    d_padd = size(img_in,1) - (v2_center(1) + v2_size(1));
    l_padd = v2_center(2) - v2_size(2) - 1;
    r_padd = size(img_in,2) - (v2_center(2) + v2_size(2));
    
    img_out = vertcat(zeros(u_padd,size(img_out,2)), img_out, zeros(d_padd,size(img_out,2)));
    img_out = horzcat(zeros(size(img_in,1),l_padd), img_out, zeros(size(img_in,1),r_padd));
    
    img_out = repmat(img_out, [1,1,size(img_in,3)]);
    img_out = img_out.*double(img_in);
    img_out = uint8(img_out);

end

