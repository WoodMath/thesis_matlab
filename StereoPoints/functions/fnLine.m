function [ mat_out ] = fnLine( mat_in, v_x, v_y )
%fnLine draws line in mat_in;
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

    v_x = reshape(v_x, [1, length(v_x)]);
    v_y = reshape(v_y, [1, length(v_y)]);
    
    
    if(i_count > 2)
        v_x(i_count+1) = v_x(1);
        v_y(i_count+1) = v_y(1);
        
        for i_inc = 1:i_count
            v_x_new = v_x(i_inc: i_inc+1);
            v_y_new = v_y(i_inc: i_inc+1);
            [ x, y ] = fnLineCoordinates( v_x_new, v_y_new );
            mat_line = fnAssign(mat_in, x, y);
            mat_out = max(mat_out, mat_line);
        end
    else
        [ x, y ] = fnLineCoordinates( v_x, v_y );
        mat_line = fnAssign(mat_in, x, y);
    end
    

    

    
end

