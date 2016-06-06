function [ tf_out ] = fnTriangleTForm( v2_in, v2_out )
%fnTriangleTForm calculates tform to take points from v2_in to v2_out
%   Detailed explanation goes here

    if(size(v2_in,1) ~= 3 || size(v2_out,1) ~= 3)
        error(' supplied array of points must contain 3 rows ');
    end
    if(size(v2_in,2) ~= 2 || size(v2_out,2) ~= 2)
        error(' supplied array of points must contain 2 columns ');
    end
    
    v2_temp_in = v2_in;
    v2_temp_out = v2_out;
    
    v2_in = [v2_temp_in(:,2), v2_temp_in(:,1)]; 
    v2_out = [v2_temp_out(:,2), v2_temp_out(:,1)]; 

    v3_in = horzcat(v2_in, ones(size(v2_in,1),1));
    v3_out = horzcat(v2_out, ones(size(v3_in,1),1));
    
    v3_inv = ((v3_out')/(v3_in'))';
%     v3_inv(1:2,3) = round(v3_inv(1:2,3));
    v3_inv(:,3) = round(v3_inv(:,3));

%     display(' **** ');
%     display(v3_in);
%     display(v3_out);
%     display(v3_inv);
    tf_out = affine2d(v3_inv);

end

