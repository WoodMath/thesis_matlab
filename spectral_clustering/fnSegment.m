function [ img_out ] = fnSegment( img_in, varargin )
%fnSegment segments an image
%   img_in img to segement

    v3_size = size(img_in);
    v2_size = [size(img_in,1), size(img_in,2)];
    v1_size = size(img_in,1)*size(img_in,2);

    %% Get row number of each pixel
    if(nargin==1)
        %% Column-major default ie col-1, col-2, col-3
        s_type = 'column';
    else
        if(strcmpi(varargin{1},'column') || strcmpi(varargin{1},'col'))
            %% Column-major ie col-1, col-2, col-3
            s_type = 'column';
        else
            if(strcmpi(varargin{1},'row'))
                %% Row-major ie col-1, col-2, col-3
                s_type = 'row';
            else
                error('Invalid type of stride: Must be ''row'' or ''column''. ');
            end
        end
    end
    
    mat_dist = fnDistance(img_in,s_type,'gaussian',10);
    mat_sim = fnSimilarity(img_in,s_type,'gaussian',10);

    f_sim_weight = 0.8;
    mat_use = mat_dist.^(1-f_sim_weight).*mat_sim.^(f_sim_weight);
    
    [mat_eigv, mat_eigs] = eig(mat_use);
    
    v_eigs = diag(mat_eigs);
    i_len = length(v_eigs);
    v_eigs = v_eigs(i_len:-1:1);
    v_eign = [v_eigs(2:i_len);0];
    
    v_diff = v_eigs-v_eign;
    i_grab = max(find(v_diff>=0.001));
    
    
    [mat_eigv, mat_eigs] = eigs(mat_use, i_grab);
    
    v_idx = kmeans(mat_eigv, i_grab);
    
    figure(1);
    plot([1:i_len]', v_eigs);
    figure(2);
    plot([1:i_len]', v_diff);
    
    if(strcmpi(s_type,'column') || strcmpi(s_type,'col'))
        %% Column-major ie col-1, col-2, col-3
        mat_idx = reshape(mat_idx, v2_size);
    end
    if(strcmpi(s_type,'row'))
        %% Row-major ie col-1, col-2, col-3
        mat_idx = reshape(mat_idx, [v2_size(2), v2_size(1)])';
    end
    
    img_out = mat_idx;
  

end

