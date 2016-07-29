function [ mat_out ] = fnTravelBack( mat_in, mat_cost, mat_back, v2_pos )
%fnTravelBack utility function to visualize dynamic programming backtrack
%   Detailed explanation goes here

    mat_out = mat_in;

    disp([' mat_back[', num2str(v2_pos),'] = ', num2str(mat_back(v2_pos(1),v2_pos(2)))]);
    
    if(logical(isequal(v2_pos,[1,1])) || logical(mat_back(v2_pos(1),v2_pos(2))==0))
        mat_out(v2_pos(1),v2_pos(2)) = 1;
        return;
    end

    if(logical(mat_out(v2_pos(1),v2_pos(2))==1))
        return;
    else
        mat_out(v2_pos(1),v2_pos(2)) = 1;
    end
    
    %% Test diagonal
    if(logical(bitand(mat_back(v2_pos(1),v2_pos(2)),1)))
        mat_out = fnTravelBack(mat_out, mat_cost, mat_back, v2_pos - [1,1]);
    end
    %% Test left
    if(logical(bitand(mat_back(v2_pos(1),v2_pos(2)),2)))
        mat_out = fnTravelBack(mat_out, mat_cost, mat_back, v2_pos - [0,1]);
    end
    %% Test up
     if(logical(bitand(mat_back(v2_pos(1),v2_pos(2)),4)))
        mat_out = fnTravelBack(mat_out, mat_cost, mat_back, v2_pos - [1,0]);
    end


end

