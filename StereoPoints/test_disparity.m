clear all;
close all;

s_dir_functions = './functions';
if(isempty(regexp(path,s_dir_functions,'once')))
    addpath(s_dir_functions);
end

im_disp = imread('./tsukuba/truedisp.row3.col3.pgm');
figure(1);
imshow(im_disp);
set(gca, 'Visible', 'on');

im_mid = imread('./tsukuba/scene1.row3.col3.ppm');
sfigure(2);
imshow(im_mid);
set(gca, 'Visible', 'on');

%% fnVisualize(im_mid);

%%%%%%%%%%%%%%%%%%%%%%%%%%

v_idx=[1:256];
v_count=uint64(v_idx*0);
v_size = size(im_mid);

for i_inc = v_idx;
    mat_inc = repmat(i_inc-1,size(im_disp));
    v_count(i_inc) = sum(sum(double(im_disp)==mat_inc));
end

v_val = find(v_count);
mat_disp = zeros([size(im_disp),length(v_val)], 'uint8');
mat_mid = zeros([size(im_mid),length(v_val)],'uint8');

for i_inc = v_val;
    i_val = i_inc-1;
    i_idx = find(v_val==i_inc);
    mat_temp = uint8(im_disp==(i_val));
    mat_disp(:,:,i_idx) = mat_temp;
    if(length(v_size) == 2)
        %% Is monochromatics
        mat_temp = repmat(mat_temp,[1,1]);
        mat_mid(:,:,i_idx) = (im_mid(:,:).*mat_temp);
    end
    
    if(length(v_size) == 3)
        %% Has color data
        mat_temp = repmat(mat_temp,[1,1,length(v_size)]);
        mat_mid(:,:,:,i_idx) = (im_mid(:,:,:).*mat_temp);
    end
end

for i_inc = v_val;
    figure(i_inc);
    i_idx = find(v_val==i_inc);
    if(length(v_size) == 2)
        imshow(mat_mid(:,:,i_idx));
    end
    if(length(v_size) == 3)
        imshow(mat_mid(:,:,:,i_idx));
    end
end

return

%% Get information about borders excluded due to moving window blac_regions;
mat_padding=(im_disp~=0);
v_rows=sum(mat_padding,2);
v_cols=sum(mat_padding,1);
i_row_count=sum(v_rows==0)/2;
i_col_count=sum(v_cols==0)/2;
v_rows=logical(v_rows);
v_cols=logical(v_cols);


if(i_row_count == i_col_count)
    i_remove = uin8t(max(i_row_count,i_col_count));
else
    error(' Excluded regions are not same size');
end
v_sub_rows = (1+i_remove-1):(size(im_disp,1)-i_remove+1);
v_sub_cols = (1+i_remove-1):(size(im_disp,2)-i_remove+1);

return
% [img_t] = fnImageInterpolate(st_out,0.5);

