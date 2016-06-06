function [ img_out, img_in ] = fnTriangleMove( img_in, v2_in, v2_out )
%fnTriangleMove Summary of this function goes here
%   Detailed explanation goes here


    if(size(v2_in,1) ~= 3 || size(v2_out,1) ~= 3)
        error(' supplied array of points must contain 3 rows ');
    end
    if(size(v2_in,2) ~= 2 || size(v2_out,2) ~= 2)
        error(' supplied array of points must contain 2 columns ');
    end
    
    i_max = intmax(class(img_in));    
    
    mat_in = fnPolygon(img_in, v2_in(:,1), v2_in(:,2));
    mat_out = fnPolygon(img_in, v2_out(:,1), v2_out(:,2));
    
    tform = fnTriangleTForm( v2_in, v2_out );
    
    xWorldLimits = [0, size(img_in,2)]+1;
    yWorldLimits = [0, size(img_in,1)]+1;

    imref2dObject = imref2d(size(img_in), xWorldLimits, yWorldLimits);
    
    
    [img_out, ref] = imwarp(img_in, tform, 'linear', 'OutputView', imref2dObject);
    
    img_in = img_in.*mat_in;
    img_out = img_out.*mat_out;

    
end

