function [  ] = fnPark( img_one, img_two, vRC_blocks )
%fnPark implements algorithm Proposed in [Park2003]
%   Detailed explanation goes here

    if(~isequal(size(img_one),size(img_two)))
        error(' Images provided not of same size')
    else
        vRC_size = size(img_one);
    end
    
    vRC_block_size = uint8([1,1]);
    if(mod(vRC_size(1), vRC_blocks(1)) ~= 0)
        error(' Image Height not evenly dvisible by bumber of block rows ');
    else
        vRC_block_size(1) = round(vRC_size(1) / vRC_blocks(1));
    end
    if(mod(vRC_size(2), vRC_blocks(2)) ~= 0)
        error(' Image Width not evenly dvisible by bumber of block columns ');
    else
        vRC_block_size(2) = round(vRC_size(2) / vRC_blocks(2));
    end
    
        
    img_one_bw = rgb2gray(img_one);
    img_two_bw = rgb2gray(img_two);
    
    
    img1_mask = zeros([vRC_size(1), vRC_size(2), vRC_blocks(1), vRC_blocks(2)],'uint8');
    
    v_rows = ones(1, vRC_block_size(1),'uint64');
    v_cols = ones(1, vRC_block_size(2),'uint64');
    for i_inc = uint64(1:vRC_blocks(1))
        for j_inc = uint64(1:vRC_blocks(2))
            v_rows(:) = uint64(1:vRC_block_size(1)) + ((i_inc-1)*uint64(ones(1,vRC_block_size(1))*double(vRC_block_size(1))));
            v_cols(:) = uint64(1:vRC_block_size(2)) + ((j_inc-1)*uint64(ones(1,vRC_block_size(2))*double(vRC_block_size(2))));
            img1_mask(v_rows,v_cols,i_inc,j_inc) = true;
        end
    end
    
    clear('v_rows')
    clear('v_cols')
    
%     img3_mask = cat(5, img1_mask, img1_mask, img1_mask);
%     img3_mask = permute(img3_mask, [1, 2, 5, 3, 4]);

%     img_one_lab = rgb2lab(img_one);
%     img_two_lab = rgb2lab(img_two);
    



    
%     filter_sobel = fspecial('sobel');
%     im_vert = imfilter(img_one_bw,filter_sobel);
%     im_horz = imfilter(img_one_bw,filter_sobel');
%     im_comb = fnNormalize((double(im_vert).^2+double(im_horz).^2).^0.5);
% 
%     figure(5);
%     imshow(im_vert);
%     figure(6);
%     imshow(im_horz);
%     figure(7);
%     imshow(im_comb);
%     

    [img_one_bw_grad_mag, img_one_bw_grad_dir] = imgradient(img_one_bw);
    [img_two_bw_grad_mag, img_two_bw_grad_dir] = imgradient(img_two_bw);
    
    [img_one_grad_part] = repmat(img_one_bw_grad_mag, [1, 1, size(img1_mask,3), size(img1_mask,4)]).*double(img1_mask);
    [img_two_grad_part] = repmat(img_two_bw_grad_mag, [1, 1, size(img1_mask,3), size(img1_mask,4)]).*double(img1_mask);
    
    clear('img_one_bw_grad_dir');
    clear('img_two_bw_grad_dir');
    
    img_one_max_grad = max(max(img_one_grad_part,[],1),[],2);
    img_one_max_grad = repmat(img_one_max_grad, [vRC_size(1), vRC_size(2), 1, 1]);
    img_one_places = (img_one_grad_part==img_one_max_grad);

    img_two_max_grad = max(max(img_two_grad_part,[],1),[],2);
    img_two_max_grad = repmat(img_two_max_grad, [vRC_size(1), vRC_size(2), 1, 1]);
    img_two_places = (img_two_grad_part==img_one_max_grad);

    clear('img_one_max_grad');
    clear('img_two_max_grad');
    
    %% Get RC positions of max places
    img_one_place_RC = reshape(double(img_one_places), [vRC_size(1)*vRC_size(2),1,vRC_blocks]);
    img_two_place_RC = reshape(double(img_two_places), [vRC_size(1)*vRC_size(2),1,vRC_blocks]);
    
    img_one_place_RC = permute(img_one_place_RC, [1,3,4,2]);
    img_two_place_RC = permute(img_two_place_RC, [1,3,4,2]);
    
    mat_idx = double([1:vRC_size(1)*vRC_size(2)])';
    mat_idx = repmat(mat_idx, [1, vRC_blocks]);
    
    img_one_place_RC = sum(img_one_place_RC.*mat_idx,1);
    img_two_place_RC = sum(img_two_place_RC.*mat_idx,1);
    
    img_one_place_RC = permute(img_one_place_RC,[2,3,1]);
    img_two_place_RC = permute(img_two_place_RC,[2,3,1]);
    
    img_one_place_row = idivide(img_one_place_RC - 1, vRC_size(1))+1; 
    img_two_place_row = idivide(img_one_place_RC - 1, vRC_size(1))+1; 
    
    
    figure(1);
    imshow(img_one_bw);
%     figure(2);
%     imshow(img_two_bw);

    
    figure(3);
    imshow(fnNormalize(img_one_bw_grad_mag));
%     figure(4);
%     imshow(fnNormalize(img_two_bw_grad_mag));
end

