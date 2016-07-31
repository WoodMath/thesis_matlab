function [ mat_out ] = fnDistance( img_in, varargin )
%fnDistance returns Distance matrix of an image
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
        if(strcmpi(varargin{1},'column') || strcmpi(varargin{1},'col'))
            %% Column-major ie col-1, col-2, col-3
            mat_row = reshape(mat_row, [v1_size,1]);
        else
            if(strcmpi(varargin{1},'row'))
                %% Row-major ie col-1, col-2, col-3
                mat_row = reshape(mat_row', [v1_size,1]);
            else
                error('Invalid type of stride: Must be ''row'' or ''column''. ');
            end
        end
    end
    
    mat_row = repmat(mat_row, [1,v1_size]);
    mat_row_diff = abs(mat_row - mat_row');
    
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
    
    mat_col = repmat(mat_col, [1,v1_size]);
    mat_col_diff = abs(mat_col - mat_col');

    if(nargin==1 || length(varargin)==1)
        mat_dist = mat_row_diff.^2 + mat_col_diff.^2;
        mat_dist = mat_dist.^0.5;
    else
        if(strcmpi(varargin{2},'travel'))
            mat_dist = mat_row_diff + mat_col_diff;
        else
            if(strcmpi(varargin{2},'square'))
                mat_dist = mat_row_diff.^2 + mat_col_diff.^2;
            else
                if(strcmpi(varargin{2},'euclidean'))
                    mat_dist = mat_row_diff.^2 + mat_col_diff.^2;
                    mat_dist = mat_dist.^0.5;
                else

                    fSigma = 1;
                    if(strcmpi(varargin{2},'gaussian'))
                        if(length(varargin) == 2)
                            fSigma = 1;
                        else                            
                            if(isnumeric(varargin{3}))
                                fSigma = varargin{3};
                            else
                                error(' When using ''gaussian'' kernel 4th, supplied argument must be numeric.');
                            end
                        end
                        
                    else
                        if(isnumeric(varargin{2}))
                            fSigma = varargin{2};
                        else
                            error('Invalid type of distance: Must be ''travel'' (dX+dY), ''square'' (dX^2+dY^2), ''euclidean'' ([dX^2+dY^2]^0.5), ''gaussian'' (e^[-(dX^2+dY^2)/2/sigma^2]) or ommitted (default of ''gaussian''). ');
                        end
                    end
                    mat_dist = mat_row_diff.^2 + mat_col_diff.^2;
                    mat_dist = exp(-(mat_dist/2/fSigma^2));

                end
            end
        end
    end
    

    mat_out = mat_dist;
%     mat_out = gather(gmat_dist);
%     reset(g);

end

