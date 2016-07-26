function [ mat_cost, mat_match ] = fnFindPath( v_arr_one, v_arr_two, f_cost )
%fnFindPath uses dynamic programmin to find mathches in v_arr_one and
%v_arr_two
%   Detailed explanation goes here

    v_arr_one = double(v_arr_one);
    v_arr_two = double(v_arr_two);
    f_cost = double(f_cost);
    f_small = 0.00001;
    
    mat_cost = zeros(length(v_arr_one)+1, length(v_arr_two)+1, 'double')-1;
    mat_match = zeros(length(v_arr_one)+1, length(v_arr_two)+1, 'uint8');
    
    for i_inc = 1:size(mat_cost,1)
        for j_inc = 1:size(mat_cost,2)
            
            i_i = i_inc - 1;
            i_j = j_inc - 1;


            %% Assign cost
            if(i_inc == 1)
                mat_cost(1, j_inc) = f_cost*double(j_inc - 1);
            end
            
            if(j_inc == 1)
                mat_cost(i_inc, 1) = f_cost*double(i_inc - 1);
            end
            
            if((i_inc > 1) && (j_inc > 1))
                f_diff = (v_arr_one(i_inc-1) - v_arr_two(j_inc-1))^2;
                mat_cost(i_inc, j_inc) = min(mat_cost(i_inc-1, j_inc-1) + f_diff, min(mat_cost(i_inc, j_inc-1)+f_cost, mat_cost(i_inc-1, j_inc)+f_cost));
            end

            %% Track source
            i_source = uint8(0);

            %% Came from diagonal
            if((i_inc > 1) && (j_inc > 1))
                f_diff = (v_arr_one(i_inc-1) - v_arr_two(j_inc-1))^2;
                if(abs(mat_cost(i_inc, j_inc) - (mat_cost(i_inc, j_inc) + f_diff)) <= f_small)
                    i_source = i_source + 1;
                end
            end
            
            %% Came from above
            if(i_inc > 1)                
                if(abs(mat_cost(i_inc, j_inc) - (mat_cost(i_inc-1, j_inc)+f_cost)) <= f_small)
                    i_source = i_source + 2;
                end
            end
            
            %% Came from left
            if(j_inc > 1)
                if(abs(mat_cost(i_inc, j_inc) - (mat_cost(i_inc, j_inc-1)+f_cost)) <= f_small)
                    i_source = i_source + 4;
                end
            end
            
            mat_match(i_inc, j_inc) = i_source;
                            
        end
    end
end

