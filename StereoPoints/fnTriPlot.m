function [ ] = fnTriPlot( mat_index, v_x, v_y, varargin )
%fnTriPlot same as 'triplot' but does n current figur
%   Detailed explanation goes here

    if(~isequal(size(v_x),size(v_y)))
        error(' Size of ''x'' and ''y'' vectors are not equal ');
    end

    hold on;
    
    if(size(mat_index,2) ~= 3)
        error(' Index matrix needs to contain 3 columns');
    end
    
    
    for i_inc = 1:size(mat_index,1)
    
        idx_tri = mat_index(i_inc,:);
        if(max(idx_tri) > max([length(v_x),length(v_y)]))
            error([' Index of ', max(idx_tri), ' is greater than size of ''x'' and ''y'' vectors']);
        end
        mat_pts = [v_x(idx_tri'), v_y(idx_tri')];
        if(length(varargin) == 0)
            c = 'blue';
        else
            c = varargin{1};
        end
        line(mat_pts([1,2],1), mat_pts([1,2],2), 'color', c);
        line(mat_pts([2,3],1), mat_pts([2,3],2), 'color', c);
        line(mat_pts([3,1],1), mat_pts([3,1],2), 'color', c);

    end


end

