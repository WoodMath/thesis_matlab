function [ mat_out ] = fnSimilarity( img_in, varargin )
%fnSimilarity returns Similarity matrix of an image
%   Detailed explanation goes here

%     g=gpuDevice(1);

    v3_size = size(img_in);
    v2_size = [size(img_in,1), size(img_in,2)];
    v1_size = size(img_in,1)*size(img_in,2);

    %% Get row number of each pixel
    if(nargin==1)
        %% Column-major default ie col-1, col-2, col-3
        mat_img = img_in;
    else
        if(strcmpi(varargin{1},'column') || strcmpi(varargin{1},'col'))
            %% Column-major ie col-1, col-2, col-3
            mat_img = img_in;
        else
            if(strcmpi(varargin{1},'row'))
                %% Row-major ie col-1, col-2, col-3
                mat_img = permute(img_in, [2,1,3]);
            else
                error('Invalid type of stride: Must be ''row'' or ''column''. ');
            end
        end
    end
    mat_row = reshape(mat_img, [v1_size, 1, size(img_in,3)]);
    mat_row = repmat(mat_row, [1, v1_size, 1]);
    
    mat_col = permute(mat_row, [2, 1, 3]);
    
    mat_dist = abs(mat_row - mat_col);
    
    if(nargin==1 || length(varargin)==1)
        mat_dist = mat_dist.^2;
        mat_dist = sum(mat_dist,3);
        mat_dist = mat_dist.^0.5;
    else
        if(strcmpi(varargin{2},'travel'))
            mat_dist = sum(mat_dist,3);
        else
            if(strcmpi(varargin{2},'square'))
                mat_dist = mat_dist.^2;
                mat_dist = sum(mat_dist,3);
            else
                if(strcmpi(varargin{2},'euclidean'))
                    mat_dist = mat_dist.^2;
                    mat_dist = sum(mat_dist,3);
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
                            error('Invalid type of distance: Must be ''travel'' (dX+dY), ''square'' (dX^2+dY^2), ''euclidean'' ([dX^2+dY^2]^0.5), ''gaussian'' (e^[-(dX^2+dY^2)/2/sigma^2])or ommitted (default of ''euclidean''). ');
                        end
                    end
                    mat_dist = mat_dist.^2;
                    mat_dist = sum(mat_dist,3);
                    mat_dist = exp(-(mat_dist/2/fSigma^2));

                end
            end
        end
    end
    

    mat_out = mat_dist;
%     mat_out = gather(gmat_dist);
%     reset(g);

end

