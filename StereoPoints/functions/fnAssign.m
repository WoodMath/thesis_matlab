function [ mat_out ] = fnAssign( mat_in, v_x, v_y )
%fnAssign assigns maximum value to pixel pair in v_x, v_y
%   Detailed explanation goes here

    if(~isequal(size(v_x), size(v_y)))
        error(' ''x'' and ''y'' vectors are not the same size');
    end
    if(length(v_x) == 1 || length(v_y) == 1)
        error(' cannot have vector lengths of 1')
    end
    
    i_max = intmax(class(mat_in));    
    i_count = max(length(v_x), length(v_y));
    
    %% Initialize outgoing matrix as same type
    mat_out = zeros(size(mat_in), class(mat_in));
    
    
%     mat_out = zeros([size(mat_in,1), size(mat_in,2)], class(mat_in));
%     mat_out(v_x, v_y) = i_max;
%     mat_out = repmat(mat_out, [1, 1, size(mat_in,3)]);
%     return
    
    
    for i_inc = 1:i_count
        mat_out(v_x(i_inc), v_y(i_inc), :) = i_max;
    end

end

