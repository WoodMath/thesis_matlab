function [ mat_out ] = fnPolygon( mat_in, v_x, v_y )
%fnPolygon creates closed polygon
%   Detailed explanation goes here

    if(~isequal(size(v_x), size(v_y)))
        error(' ''x'' and ''y'' vectors are not the same size');
    end
    if(length(v_x) == 1 || length(v_y) == 1)
        error(' cannot have vector lengths of 1')
    end
    
    i_max = intmax(class(mat_in));    
    i_count = max(length(v_x), length(v_y));
    
    v_center = round([mean(v_x), mean(v_y)]);
    
    [ mat_out ] = fnLine( mat_in, v_x, v_y );
    mat_bin = mat_out(:,:,1);
    
    
    
    mat_bin = imfill(mat_bin, 'holes');
    mat_out = repmat(mat_bin, [1, 1, size(mat_in,3)]);
    mat_out = mat_out/max(max(max(mat_out)));
    return;
    
    %% fill interiors
    mat_bin = ~(mat_out>0);
    mat_label = uint8(bwlabel(mat_bin(:,:), 4));
    i_label = mat_label(v_center(1), v_center(2));
    mat_int = (mat_label==i_label);
    mat_bin = ~mat_bin;
    mat_bin = mat_bin | mat_int;
    
    %% Get rid of stragglers
    mat_bin = ~mat_bin;
    [mat_label,n] = uint8(bwlabel(mat_bin(:,:), 4));
    % Unfinished when 'imfill' discovered
    
    
    
end

