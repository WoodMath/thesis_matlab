    clear all;
    close all;

    im_test = imread('perspective_1.png');
%     im_test = imread('Povray_logo_sphere.png');
%     k=uint8(im_test==0)*255;
%     im_test = im_test+k;

%     img_out = fnMaskTriangle(im_pixel, [100,100; 300,100; 100, 300]);
%     figure(100);
%     imshow(img_out);
%     [mat_out] = fnAAline(uint8(0), [10,400], [10,400]);
%     
%     figure(1);
%     imshow(mat_out(:,:,4));
    v1 = [10,10];
    v2 = [10,30];
    v3 = [37,37];
    v4 = [30,10];
    
    v2_in = [v1;v2;v3];
    v2_out = [v1;v3;v4];
    
%     mat_one = roipoly(im_pixel, v_one(:,2), v_one(:,1));
%     mat_two = roipoly(im_pixel, v_two(:,2), v_two(:,1));
    
    v2_in = [1,1; 90,1; 1, 20];
    v2_out = [1, 0.5; 0.5, 1]*v2_in';
    v2_out = (v2_out + repmat([20;60],[1,3]))';

    
    [img_out, img_in] = fnMoveTriangle(im_test, v2_in, v2_out);
    
    figure(1);
    imshow(img_in);
    
    figure(2);
    imshow(img_out);
    
    v2_in = v2_in;
    v2_out = v2_out;
    
    v2_in = v2_in;
    v2_out = v2_out;
    
    v3_in = horzcat(v2_in, ones(size(v2_in,1),1));
    v3_out = horzcat(v2_out, ones(size(v2_out,1),1));
    
%     mat_one = fnLine(im_pixel, v_one(:,2), v_one(:,1));
%     mat_two = fnLine(im_pixel, v_two(:,2), v_two(:,1));
    
    mat_one = fnPolygon(im_test, v2_in(:,1), v2_in(:,2));
    mat_two = fnPolygon(im_test, v2_out(:,1), v2_out(:,2));
    
    k=mat_two(:,:,1);

    figure(1);
    imshow(mat_one*255);
    
    figure(2);
    imshow(mat_two*255);
    
    tform = fnTriangleTForm( v2_in, v2_out );
    
    xWorldLimits = [0, size(im_test,2)]+1;
    yWorldLimits = [0, size(im_test,1)]+1;

    imref2dObject = imref2d(size(im_test), xWorldLimits, yWorldLimits);
    
    
    [im_new, ref] = imwarp(im_test, tform, 'cubic', 'OutputView', imref2dObject);


%     [im_new, ref] = imwarp(im_test, tform, 'cubic');
%     [im_new, ref] = imwarp(im_test, tform, 'cubic', 'OutputView', ref);

    
    figure(1);
    imshow(im_test);
    set(gca, 'Visible', 'on');
    
    figure(2);
    imshow(im_new);
    set(gca, 'Visible', 'on');

    figure(3);
    imshow(im_test.*mat_one);
    set(gca, 'Visible', 'on');
    
    figure(4);
    imshow(im_new.*mat_two);
    set(gca, 'Visible', 'on');
    
    %     set(gca,'Visible','On');

     
    