function [ img_t ] = fnTriangleInterpolate( img_source, img_dest, v2_source, v2_dest, f_t )
%fnTriangleInterpolate interpolates regions defined by v2_source and
%v2_dest
%   Detailed explanation goes here

    if(size(v2_source,1) ~= 3 || size(v2_dest,1) ~= 3)
        error(' supplied array of points must contain 3 rows ');
    end
    if(size(v2_source,2) ~= 2 || size(v2_dest,2) ~= 2)
        error(' supplied array of points must contain 2 columns ');
    end
    if(~isequal(size(img_source), size(img_dest)))
        error(' images must be same size and color depth ');
    end

    v2_t = v2_source*(1-f_t) + v2_dest*f_t;

    img_source = img_source;
    img_dest = img_dest;
    
    i_max = intmax(class(img_source));    
    
    mat_source = fnPolygon(img_source, v2_source(:,1), v2_source(:,2));
    mat_dest = fnPolygon(img_dest, v2_dest(:,1), v2_dest(:,2));
    mat_t = fnPolygon(img_source, v2_t(:,1), v2_t(:,2));
    
    tform_source_t = fnTriangleTForm( v2_source, v2_t );
    tform_dest_t = fnTriangleTForm( v2_dest, v2_t );
    
    xWorldLimits = [0, size(img_source,2)]+1;
    yWorldLimits = [0, size(img_source,1)]+1;

    imref2dObject = imref2d(size(img_source), xWorldLimits, yWorldLimits);
    
    
    [img_source_t] = imwarp(img_source, tform_source_t, 'linear', 'OutputView', imref2dObject);
    [img_dest_t] = imwarp(img_dest, tform_dest_t, 'linear', 'OutputView', imref2dObject);
    
    img_source_t = img_source_t.*mat_t;
    img_dest_t = img_dest_t.*mat_t;

%     sfigure(1);
% %     imshow(img_source_t);
%     imshow(mat_source.*img_source);
%     set(gca, 'Visible', 'on');
%     sfigure(2);
% %     imshow(img_dest_t);
%     imshow(mat_dest.*img_dest);
%     set(gca, 'Visible', 'on');
    
    img_source_temp = reshape(img_source_t, [prod(size(img_source_t)),1,1]);
    img_dest_temp = reshape(img_dest_t, [prod(size(img_dest_t)),1,1]);
%     img_t = uint8(mean([img_source_temp, img_dest_temp], 2));
    
%     img_t2 = max([img_source_temp, img_dest_temp]')';
%     img_t = uint8(mean([img_source_temp, img_dest_temp, img_t2], 2));
    img_t_temp = img_source_temp*(1-f_t)+img_dest_temp*(f_t);

    img_t = reshape(img_t_temp, size(img_source_t));
%     sfigure(3);
%     imshow(img_t);
%     set(gca, 'Visible', 'on');
    
    
end

