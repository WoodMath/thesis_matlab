function [ ] = fnTriPlot( mat_index, v_x, v_y )
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
        line(mat_pts([1,2],1), mat_pts([1,2],2));
        line(mat_pts([2,3],1), mat_pts([2,3],2));
        line(mat_pts([3,1],1), mat_pts([3,1],2));

    end


end

