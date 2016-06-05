    clear all;
    close all;
    
    im_pixel = ones([800,600,3],'uint8')*255;

%     img_out = fnMaskTriangle(im_pixel, [100,100; 300,100; 100, 300]);
%     figure(100);
%     imshow(img_out);
%     [mat_out] = fnAAline(uint8(0), [10,400], [10,400]);
%     
%     figure(1);
%     imshow(mat_out(:,:,4));
    v1 = [100,100];
    v2 = [100,300];
    v3 = [300,300];
    v4 = [300,100];
    
    v_one = [v1;v2;v4];
    v_two = [v2;v3;v4];
    
%     mat_one = roipoly(im_pixel, v_one(:,2), v_one(:,1));
%     mat_two = roipoly(im_pixel, v_two(:,2), v_two(:,1));
    
    
    v2_in = v_one;
    v2_out = v_two;
    
    v3_in = horzcat(v2_in, ones(size(v2_in,1),1));
    v3_out = horzcat(v3_in, ones(size(v3_in,1),1));
    
    
    
    