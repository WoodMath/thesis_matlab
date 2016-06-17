function [ mat_out ] = fnDist( img_in, varargin )
%fnDist Summary of this function goes here
%   Detailed explanation goes here

%     g=gpuDevice(1);

    v2_size = [size(img_in,1), size(img_in,2)];
    v1_size = size(img_in,1)*size(img_in,2);

    %% Get row number of each pixel
    mat_row = repmat((1:size(img_in,1))', [1,size(img_in,2)]);
    if(nargin==1)
        %% Column-major default ie col-1, col-2, col-3
        mat_row = reshape(mat_row, [v1_size,1]);
    else
        if(strcmpi(varargin{1},'column') || strcmpi(varargin{1},'cols'))
            %% Column-major ie col-1, col-2, col-3
            mat_row = reshape(mat_row, [v1_size,1]);
        else
            if(strcmpi(varargin{1},'row'))
                %% Row-major ie col-1, col-2, col-3
                mat_row = reshape(mat_row', [v1_size,1]);
            else
                error('Invalid type of stride');
            end
        end
    end
    gmat_row = mat_row;
%     gmat_row = gpuArray(mat_row);
    gmat_row = repmat(gmat_row, [1,v1_size]);
    gmat_row_diff = abs(gmat_row - gmat_row');
    
    mat_col = repmat(1:size(img_in,2), [size(img_in,1),1]);
    if(nargin==1)
        %% Column-major default ie col-1, col-2, col-3
        mat_col = reshape(mat_col, [v1_size,1]);
    else
        if(strcmpi(varargin{1},'column') || strcmpi(varargin{1},'col'))
            %% Column-major ie col-1, col-2, col-3
            mat_col = reshape(mat_col, [v1_size,1]);
        else
            if(strcmpi(varargin{1},'row'))
                %% Row-major ie col-1, col-2, col-3
                mat_col = reshape(mat_col', [v1_size,1]);
            else
                error('Invalid type of stride: Must be ''row'' or ''column''. ');
            end
        end
    end
    gmat_col = mat_col;
%     gmat_col = gpuArray(mat_col);
    gmat_col = repmat(gmat_col, [1,v1_size]);
    gmat_col_diff = abs(gmat_col - gmat_col');

    
    if(nargin==1 || length(varargin)==1)
        gmat_dist = gmat_row_diff.^2 + gmat_col_diff.^2;
        gmat_dist = gmat_dist.^0.5;
    else
        if(strcmpi(varargin{2},'travel'))
            gmat_dist = gmat_row_diff + gmat_col_diff;
        else
            if(strcmpi(varargin{2},'square'))
                gmat_dist = gmat_row_diff.^2 + gmat_col_diff.^2;
            else
                if(strcmpi(varargin{2},'euclidean'))
                    gmat_dist = gmat_row_diff.^2 + gmat_col_diff.^2;
                    gmat_dist = gmat_dist.^0.5;
                else
                    error('Invalid type of distance: Must be ''travel'' (dX+dY), ''square'' (dX^2+dY^2), ''euclidean'' ([dX^2+dY^2]^0.5), or ommitted (default of ''euclidean''). ');
                end
            end
        end
    end
    

    mat_out = gmat_dist;
%     mat_out = gather(gmat_dist);
%     reset(g);

end

