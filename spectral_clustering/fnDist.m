function [ mat_out ] = fnDist( img_in, varargin )
%fnDist Summary of this function goes here
%   Detailed explanation goes here

    g=gpuDevice(1);

    v2_size = [size(img_in,1), size(img_in,2)];
    v1_size = size(img_in,1)*size(img_in,2);

    %% Get row number of each pixel
    mat_row = repmat((1:size(img_in,1))', [1,size(img_in,2)]);
    mat_row = reshape(mat_row, [v1_size,1]);
    gmat_row = gpuArray(mat_row);
    gmat_row = repmat(gmat_row, [1,v1_size]);
    gmat_row_diff = abs(gmat_row - gmat_row');
    
    mat_col = repmat(1:size(img_in,2), [size(img_in,1),1]);
    mat_col = reshape(mat_col, [v1_size,1]);
    gmat_col = gpuArray(mat_col);
    gmat_col = repmat(gmat_col, [1,v1_size]);
    gmat_col_diff = abs(gmat_col - gmat_col');

    
    if(nargin==1)
        gmat_dist = gmat_row_diff.^2 + gmat_col_diff.^2;
        gmat_dist = gmat_dist.^0.5;
    else
        if(strcmpi(varargin{1},'square'))
            gmat_dist = gmat_row_diff.^2 + gmat_col_diff.^2;
            gmat_dist = gmat_dist.^0.5;
        else
            if(strcmpi(varargin{1},'travel'))
                gmat_dist = gmat_row_diff + gmat_col_diff;
            else
                error('Invalid type of distance');
            end
        end
    end
    

    mat_out = gather(gmat_dist);
    reset(g);

end

