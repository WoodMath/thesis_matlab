function [ img_out_left, img_out_right ] = fnScanline( img_left, img_right, i_window_size, f_cost )
%fnScanline does scanline analysis of two rectified images
%   Detailed explanation goes here

    i_window_padding = (i_window_size-1)/2;

    if(rem(i_window_size,2) == 0)
        error(' Window size must be an odd number ');
    end

    if(length(size(img_left)) > 2)
        img_left = rgb2gray(img_left);
    end

    if(length(size(img_right)) > 2)
        img_right = rgb2gray(img_right);
    end

    %% Get dimensions
    i_img_left_rows = size(img_left,1);
    i_img_left_cols = size(img_left,2);
    i_img_right_rows = size(img_right,1);
    i_img_right_cols = size(img_right,2);
    
    if(i_img_left_rows ~= i_img_right_rows)
        error(' Left image and Right image are not of the same height ');
    else
        i_rows = i_img_left_rows;
    end
    

    
    %% Preallocate output
    img_out_left = zeros(size(img_left),'uint8');
    img_out_right = zeros(size(img_right),'uint8');

    %% Convert to double format
    img_left = im2double(img_left)/255;
    img_right = im2double(img_right)/255;
    
    %% Convert to integral images
%     img_left = integralImage(img_left);
%     img_right = integralImage(img_right);


            
    parfor i_inc = 1:i_rows
        disp([' i_inc = ', num2str(i_inc)]);
        if(i_window_padding < i_inc && i_inc <= (i_rows - i_window_padding))
%             i_window_center_row = i_inc + i_window_padding;
            i_window_center_row = i_inc;

            i_window_left_cols = i_img_left_cols - 2*i_window_padding;
            i_window_right_cols = i_img_right_cols - 2*i_window_padding;

            mat_window_left = zeros(i_window_size,i_window_size,i_window_left_cols);
            mat_window_right = zeros(i_window_size,i_window_size,i_window_right_cols);

            %% Fill left
            for j_inc = 1:i_window_left_cols
                i_window_left_center_col = j_inc + i_window_padding;
                
                i_window_row_min = i_window_center_row - i_window_padding;
                i_window_row_max = i_window_center_row + i_window_padding;
                i_window_col_min = i_window_left_center_col - i_window_padding;
                i_window_col_max = i_window_left_center_col + i_window_padding;
                
                mat_window_left(:,:,j_inc) = img_left(i_window_row_min:i_window_row_max, i_window_col_min:i_window_col_max);                
                
            end
            
            %% Fill right
            for j_inc = 1:i_window_right_cols
                i_window_right_center_col = j_inc + i_window_padding;
                
                i_window_row_min = i_window_center_row - i_window_padding;
                i_window_row_max = i_window_center_row + i_window_padding;
                i_window_col_min = i_window_right_center_col - i_window_padding;
                i_window_col_max = i_window_right_center_col + i_window_padding;
                
                mat_window_right(:,:,j_inc) = img_right(i_window_row_min:i_window_row_max, i_window_col_min:i_window_col_max);                
                
            end
            [mat_cost, mat_back] = fnFindPathWindow(mat_window_left, mat_window_right, f_cost);
%             mat_path = zeros(size(mat_cost),'uint8');
%             mat_path = fnTravelBack(mat_path, mat_cost, mat_back, size(mat_cost));
%             figure;
%             imshow(mat_path*255);
            
            [v_left, v_right] = fnDisparity(mat_cost, mat_back, size(mat_cost),1);

            v_padding = zeros(1, i_window_padding, 'uint8');
            v_left = [v_padding, v_left, v_padding];
            v_right = [v_padding, v_right, v_padding];

            img_out_left(i_inc,:) = v_left;
            img_out_right(i_inc,:) = v_right;
            
        end
        
        
    end

    poolobj = gcp('nocreate');
    delete(poolobj);    

end

