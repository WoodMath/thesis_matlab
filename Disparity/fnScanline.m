function [  ] = fnScanline( img_left, img_right, i_window_size )
%fnScanline does scanline analysis of two rectified images
%   Detailed explanation goes here

    if(rem(i_window_size,2) == 0)
        error(' Window size must be an odd number ');
    end

    if(length(size(img_left)) > 2)
        img_left = integralImage( im2double(rgb2gray(img_left))/255);
    end

    if(length(size(img_right)) > 2)
        img_right = integralImage( im2double(rgb2gray(img_right))/255);
    end

end

