function [ v_left, v_right ] = fnDisparity(mat_cost, mat_back, v2_pos, i_last )
%fnDisparity assigns disparities to v_left and v_right
%   Detailed explanation goes here


%     disp([' mat_back[', num2str(v2_pos),'] = ', num2str(mat_back(v2_pos(1),v2_pos(2)))]);

    v_left = zeros(1, size(mat_cost,1)-1,'uint8');
    v_right = zeros(1, size(mat_cost,2)-1,'uint8');
            
    if(logical(isequal(v2_pos,[1,1])) || logical(mat_back(v2_pos(1),v2_pos(2))==0))
        return;
    end

    %% Reached top
    if(v2_pos(1)==1)
        return;
    end
    
    %% Reached left
    if(v2_pos(2)==1)
        return;
    end        
    
    i_new_last = mat_back(v2_pos(1),v2_pos(2));
    %% Test diagonal
    if(logical(bitand(mat_back(v2_pos(1),v2_pos(2)),1)))
        [ v_left, v_right ] = fnDisparity(mat_cost, mat_back, v2_pos - [1,1], i_new_last);
        if(logical(bitand(i_last,1)))
            i_pixel_left = v2_pos(1) - 1;
            i_pixel_right = v2_pos(2) - 1;
            i_disp = abs(i_pixel_left - i_pixel_right);
            v_left(i_pixel_left) = i_disp;
            v_right(i_pixel_right) = i_disp;
        end
        return;
    end
    %% Test left
    if(logical(bitand(mat_back(v2_pos(1),v2_pos(2)),2)))
        [ v_left, v_right ] = fnDisparity(mat_cost, mat_back, v2_pos - [0,1], i_new_last);
        if(logical(bitand(i_last,1)))
            i_pixel_left = v2_pos(1) - 1;
            i_pixel_right = v2_pos(2) - 1;
            i_disp = abs(i_pixel_left - i_pixel_right);
            v_left(i_pixel_left) = i_disp;
            v_right(i_pixel_right) = i_disp;
        end
        return;
    end
    %% Test up
     if(logical(bitand(mat_back(v2_pos(1),v2_pos(2)),4)))
        [ v_left, v_right ] = fnDisparity(mat_cost, mat_back, v2_pos - [1,0], i_new_last);
        if(logical(bitand(i_last,1)))
            i_pixel_left = v2_pos(1) - 1;
            i_pixel_right = v2_pos(2) - 1;
            i_disp = abs(i_pixel_left - i_pixel_right);
            v_left(i_pixel_left) = i_disp;
            v_right(i_pixel_right) = i_disp;
        end
        return;
    end


end

