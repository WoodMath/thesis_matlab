% clear all;
% close all;

if ~logical(exist('im_fl'))
    disp(' Loading... ');
    im_fl = imread('MyNameIsFlorida.jpg');
end
    
v3_size = size(im_fl);

if(length(v3_size) == 3)
    i_dim3 = 3;
else
    i_dim3 = 1;
end

i_square_size = 64;
v2_partition_numbers = [v3_size(1)/i_square_size, v3_size(2)/i_square_size];

v5_partitions = zeros([i_square_size, i_square_size, i_dim3, v2_partition_numbers(1), v2_partition_numbers(2)], 'uint8');

%% Warning:
% loops assume that image size is a perfect multiple of 'i_sqaure_size' and
% 'v2_partition_numbers'

% i_row_start = 1;
% for i_inc = 1:v2_partition_numbers(1)
%     v2_rows = uint64([i_row_start:(i_row_start+i_square_size-1)]);
% 
%     i_col_start = 1;
%     for j_inc = 1:v2_partition_numbers(2)
%         v2_cols = uint64([i_col_start:(i_col_start+i_square_size-1)]);
%         
%         
%         %% Where the magic happens
%         v5_partitions(:,:,:,i_inc,j_inc) = im_fl(v2_rows, v2_cols, :);
%         
% 
%         
%         
%         i_col_start = i_col_start + i_square_size;
%     end
%     i_row_start = i_row_start + i_square_size;
% end


%% Do reduced size image
i_reduce = 16;
v3_size_reduce = v3_size./[i_reduce,i_reduce,1];

if ~logical(exist('im_fl_re'))
    disp(' Reducing... ');
    im_fl_reduce = imresize(im_fl, 1/i_reduce);
end



%% Warning:
% again, loops assume that image size is a perfect multiple of 'i_sqaure_size' and
% 'v2_partition_numbers'