function [ h ] = fnVisualize( mat_img )
%fnVisualize Summary of this function goes here
%   Detailed explanation goes here

    v3_size = size(mat_img);
    v2_size = v3_size(1:2);
    v1_size = v2_size(1)*v2_size(2);

    v_img = reshape(mat_img, [v1_size, 1, size(mat_img,3)]);    
    %% If grayscal make color
    if(size(mat_img,3)==1)
        v_img = repmat(v_img, [1,1,3]);
    end
    v_img = uint32(permute(v_img, [1,3,2]));
    
    v_img_value = v_img(:,1)+bitshift(v_img(:,2),8)+bitshift(v_img(:,3),16);
    
    v_img_value_unique = sort(unique(v_img_value));
    v_img_value_count = v_img_value_unique*0;

    for i_inc = 1:length(v_img_value_unique)
        i_val = v_img_value_unique(i_inc);
        v_img_value_count(i_inc) = sum(v_img_value==i_val);
        
    end

    v_Red = uint8(bitand(v_img_value_unique, 255));
    v_Green = uint8(bitand(bitshift(v_img_value_unique, -8), 255));
    v_Blue = uint8(bitand(bitshift(v_img_value_unique, -16), 255));
    
    c_Red = double(v_Red)/255;
    c_Green = double(v_Green)/255;
    c_Blue = double(v_Blue)/255;
    
    v_Size = double(v_img_value_count)*0.05;
    v_Color = [c_Red, c_Green, c_Blue];
    
    h = figure();
    
    scatter3(v_Red,v_Green,v_Blue,v_Size,v_Color,'.');
%     mat_img_value_unique = repmat(v_img_value_unique', [length(v_img_value), 1]);
%     mat_img_value = repmat(v_image_value, [1, length(v_image_value_unique)]);
%     
%     v_image_value_count = sum(uint32(mat_img_value == mat_img_value_unique));
end

