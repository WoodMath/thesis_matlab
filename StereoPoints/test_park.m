

    warning('off','images:initSize:adjustingMag');
    im_im0 = imread('./StereoImages/im0.png');
    im_im1 = imread('./StereoImages/im1.png');
    
%     fnPark(im_im0, im_im1, [16,12]);

    im_im0 = imresize(im_im0, 0.5);
    im_im1 = imresize(im_im1, 0.5);
    fnPark(im_im0, im_im1, [4,3]);
    