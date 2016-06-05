function [ img_out ] = fnMaskTriangle( img_in, v2_points )
%fnMaskTriangle creates mask defined by 3 points in v2_points
%   Detailed explanation goes here
%   Taken from:
%       http://www.mathworks.com/help/images/ref/roipoly.html

    i_max = intmax(class(img_in));
    
    v2_points = round(v2_points);
    
    mat_BW = roipoly(img_in, v2_points(:,2), v2_points(:,1));
    mat_BW = repmat(mat_BW, [1,1,size(img_in, 3)]);
    mat_BW = uint8(mat_BW);
%     mat_BW = mat_BW*i_max*0+1;
    
    img_out = img_in.*mat_BW;

end

