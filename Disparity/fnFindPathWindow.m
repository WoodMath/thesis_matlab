function [ mat_cost, mat_back ] = fnFindPathWindow( mat_arr_one, mat_arr_two, f_cost )
%fnFindPath uses dynamic programmin to find mathches in v_arr_one and
%v_arr_two
%   Detailed explanation goes here

    mat_arr_one = double(mat_arr_one);
    mat_arr_two = double(mat_arr_two);
    f_cost = double(f_cost);
    f_small = 0.00000001;

        
    
    mat_cost = zeros(size(mat_arr_one,3)+1, size(mat_arr_two,3)+1, 'double')-1;
    mat_back = zeros(size(mat_arr_one,3)+1, size(mat_arr_two,3)+1, 'uint8');
    
    for i_inc = 1:size(mat_cost,1)
        for j_inc = 1:size(mat_cost,2)
            
            i_i = i_inc - 1;
            i_j = j_inc - 1;

            %% Track source
            i_source = uint8(0);
            
            %% Assign cost
            if(i_inc == 1)
                mat_cost(1, j_inc) = f_cost*double(j_inc - 1);
                i_source = 2;
            end
            
            if(j_inc == 1)
                mat_cost(i_inc, 1) = f_cost*double(i_inc - 1);
                i_source = 4;
            end
            
            %% Special case for (0,0)
            if(i_inc == 1 && j_inc == 1)
                i_source = 0;
            end
            
            if((i_inc > 1) && (j_inc > 1))
                f_diff = sum(sum((mat_arr_one(:,:,i_inc-1) - mat_arr_two(:,:,j_inc-1)).^2));
                f_num_1 = mat_cost(i_inc-1, j_inc-1) + f_diff;
                f_num_2 = mat_cost(i_inc, j_inc-1)+f_cost;
                f_num_4 = mat_cost(i_inc-1, j_inc)+f_cost;
                f_min = min(f_num_1, min(f_num_2, f_num_4));
                
                mat_cost(i_inc, j_inc) = f_min;                
                
                %% Backtrack cost
                if(abs(f_min-f_num_1) <= f_small)
                    i_source = i_source + 1;
                end

                if(abs(f_min-f_num_2) <= f_small)
                    i_source = i_source + 2;
                end

                if(abs(f_min-f_num_4) <= f_small)
                    i_source = i_source + 4;
                end

            end

%             %% Came from diagonal
%             if((i_inc > 1) && (j_inc > 1))
%                 f_diff = sum(sum((mat_arr_one(i_inc-1) - mat_arr_two(j_inc-1)).^2));
%                 if(abs(mat_cost(i_inc, j_inc) - (mat_cost(i_inc-1, j_inc-1) + f_diff)) <= f_small)
%                     i_source = i_source + 1;
%                 end
%             end
%             
%             %% Came from above
%             if(i_inc > 1)                
%                 if(abs(mat_cost(i_inc, j_inc) - (mat_cost(i_inc-1, j_inc)+f_cost)) <= f_small)
%                     i_source = i_source + 2;
%                 end
%             end
%             
%             %% Came from left
%             if(j_inc > 1)
%                 if(abs(mat_cost(i_inc, j_inc) - (mat_cost(i_inc, j_inc-1)+f_cost)) <= f_small)
%                     i_source = i_source + 4;
%                 end
%             end
            
            mat_back(i_inc, j_inc) = i_source;
                            
        end
    end
end

