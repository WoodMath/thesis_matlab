function [  ] = fnPark( img_one, img_two, vRC_blocks )
%fnPark implements algorithm Proposed in [Park2003]
%   Detailed explanation goes here

    if(~isequal(size(img_one),size(img_two)))
        error(' Images provided not of same size')
    else
        vRC_size = size(img_one);
    end
    
    vRC_block_size = uint64([1,1]);
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

    %% Make grayscale if not already
    if(size(img_one,3) ~= 1)
        img_one_bw = rgb2gray(img_one);
    else
        img_one_bw = img_one;
    end
    if(size(img_two,3) ~= 1)
        img_two_bw = rgb2gray(img_two);
    else
        img_two_bw = img_two;
    end
    
    img_one_bw_grad = imgradient(img_one_bw);
    img_two_bw_grad = imgradient(img_two_bw);

%     %% Using Sobel method as described in articles
%     filter_sobel = fspecial('sobel');
%     im_vert = imfilter(img_one_bw,filter_sobel);
%     im_horz = imfilter(img_one_bw,filter_sobel');
%     % img_one_bw_grad = fnNormalize(double(im_vert)+double(im_horz));
%     img_one_bw_grad = double(im_vert)+double(im_horz);
%     im_vert = imfilter(img_two_bw,filter_sobel);
%     im_horz = imfilter(img_two_bw,filter_sobel');
%     % img_two_bw_grad = fnNormalize(double(im_vert)+double(im_horz));
%     img_two_bw_grad = double(im_vert)+double(im_horz);
%     clear('im_vert','im_horz');
    
    
    struct_mask = struct('Rows',[],'Columns',[],'Offset',[],'ImageOne',[],'ImageTwo',[]);

    img_grad_one = zeros([vRC_block_size, vRC_blocks]);
    img_grad_two = zeros([vRC_block_size, vRC_blocks]);
    
    v_rows = ones(1, vRC_block_size(1),'uint64');
    v_cols = ones(1, vRC_block_size(2),'uint64');
    
    for i_inc = uint64(1:vRC_blocks(1))
        for j_inc = uint64(1:vRC_blocks(2))
            v_rows(:) = uint64(1:vRC_block_size(1)) + ((i_inc-1)*uint64(ones(1,vRC_block_size(1))*double(vRC_block_size(1))));
            v_cols(:) = uint64(1:vRC_block_size(2)) + ((j_inc-1)*uint64(ones(1,vRC_block_size(2))*double(vRC_block_size(2))));
            struct_mask(i_inc, j_inc).Rows = v_rows;
            struct_mask(i_inc, j_inc).Columns = v_cols;
            struct_mask(i_inc, j_inc).Offset = [v_rows(1)-1, v_cols(1)-1]; 

            img_temp_one = img_one_bw_grad(v_rows,v_cols);
            img_temp_two = img_two_bw_grad(v_rows,v_cols);
            
            struct_one = struct('ImageData',img_one_bw(v_rows,v_cols),'GradientData',img_temp_one,'Points',[]);
            struct_two = struct('ImageData',img_two_bw(v_rows,v_cols),'GradientData',img_temp_two,'Points',[]);
            
            struct_mask(i_inc, j_inc).ImageOne = struct_one;
            struct_mask(i_inc, j_inc).ImageTwo = struct_two;
            
            img_grad_one(:,:,i_inc,j_inc) = img_temp_one;
            img_grad_two(:,:,i_inc,j_inc) = img_temp_two;
            
        end
    end
    
    clear('img_temp_one','img_temp_two');
    clear('v_rows','v_cols');
    clear('struct_one','struct_two');
    

    


    %% Extract points containing maximum gradient
    f_thresh = 100;
    img_one_max_grad = img_grad_one;
    img_one_max_grad = max(max(img_one_max_grad,[],1),[],2);
    img_one_max_grad = repmat(img_one_max_grad, [vRC_block_size, 1, 1]);
    img_one_places = uint8((img_grad_one==img_one_max_grad).*(img_grad_one>=f_thresh));
    img_one_count = sum(sum(uint8(img_one_places),1),2);
    img_one_count = permute(img_one_count, [3,4,1,2]);
    
    img_two_max_grad = img_grad_two;
    img_two_max_grad = max(max(img_two_max_grad,[],1),[],2);
    img_two_max_grad = repmat(img_two_max_grad, [vRC_block_size, 1, 1]);
    img_two_places = uint8((img_grad_two==img_two_max_grad).*(img_grad_two>=f_thresh));
    img_two_count = sum(sum(uint8(img_two_places),1),2);
    img_two_count = permute(img_two_count, [3,4,1,2]);

    clear('img_one_max_grad','img_two_max_grad');
    
    %% Get RC positions of max places
    img_one_place_RC = reshape(double(img_one_places), [vRC_block_size(1)*vRC_block_size(2),1,vRC_blocks]);
    img_two_place_RC = reshape(double(img_two_places), [vRC_block_size(1)*vRC_block_size(2),1,vRC_blocks]);
    
    img_one_place_RC = permute(img_one_place_RC, [1,3,4,2]);
    img_two_place_RC = permute(img_two_place_RC, [1,3,4,2]);
    
    mat_idx = double([1:(vRC_block_size(1)*vRC_block_size(2))])';
%     mat_idx = repmat(mat_idx, [1, vRC_blocks]);

    mat_count_one = zeros(vRC_blocks,'uint16');
    mat_count_two = zeros(vRC_blocks,'uint16');
    
    for i_inc = 1:vRC_blocks(1)
        for j_inc = 1:vRC_blocks(2)

            %% Filter out (make 0) non maximum indexes
            img_one_place = img_one_place_RC(:,i_inc,j_inc).*mat_idx;
            img_two_place = img_two_place_RC(:,i_inc,j_inc).*mat_idx;

            img_one_place = uint64(img_one_place);
            img_two_place = uint64(img_two_place);

            %% Only include that points where both images are greater than threshold
%             b_include = ((img_one_place>0) & (img_two_place>0));
%             img_one_place = img_one_place(b_include,:);
%             img_two_place = img_two_place(b_include,:);
            img_one_place = img_one_place((img_one_place>0),:);
            img_two_place = img_two_place((img_two_place>0),:);

            img_one_place_row = mod(img_one_place - 1, vRC_block_size(1))+1; 
            img_two_place_row = mod(img_two_place - 1, vRC_block_size(1))+1; 

            img_one_place_col = idivide(img_one_place - 1, vRC_block_size(1))+1; 
            img_two_place_col = idivide(img_two_place - 1, vRC_block_size(1))+1; 

            img_one_points = [img_one_place_row, img_one_place_col];
            img_two_points = [img_two_place_row, img_two_place_col];
            
            struct_mask(i_inc,j_inc).ImageOne.Points = img_one_points;
            struct_mask(i_inc,j_inc).ImageTwo.Points = img_two_points;

            mat_count_one(i_inc,j_inc) = size(img_one_points,1);
            mat_count_two(i_inc,j_inc) = size(img_two_points,1);
            
        end
    end

    clear('img_one_place_col','img_two_place_col','img_one_place_row','img_two_place_row');
    

    
    figure(1);
    imshow(img_one_bw);
    hold on;
    figure(2);
    imshow(img_two_bw);
    hold on;

    
    figure(3);
    imshow(fnNormalize(img_one_bw_grad));
    hold on;
    figure(4);
    imshow(fnNormalize(img_two_bw_grad));
    hold on;

    for i_inc = 1:vRC_blocks(1)
        for j_inc = 1:vRC_blocks(2)

            img_one_points = struct_mask(i_inc,j_inc).ImageOne.Points;
            v_offset = struct_mask(i_inc,j_inc).Offset;
            v_offset = repmat(v_offset, size(img_one_points,1));
            img_one_points = img_one_points + v_offset;
            
            figure(3);
            hold on;
            plot(img_one_points(:,2), img_one_points(:,1), '.r','MarkerSize',10);

            img_two_points = struct_mask(i_inc,j_inc).ImageTwo.Points;
            v_offset = struct_mask(i_inc,j_inc).Offset;
            v_offset = repmat(v_offset, size(img_two_points,1));
            img_two_points = img_two_points + v_offset;
            
            figure(4);
            hold on;
            plot(img_two_points(:,2), img_two_points(:,1), '.r','MarkerSize',10);
            
        end
    end
    

    clear('img_one_points','img_two_points');
    clear('v_offset');
    
end

