function [st_data] = fnMenuEdit(st_data, fig_source, fig_dest)
%fnMenuEdit Summary of this function goes here
%   Detailed explanation goes here



    %% Make figure handles global to handle between callbacks
    global h_source, global h_dest;
    h_source = fig_source;
    h_dest = fig_dest;
    
    global ax_source, global ax_dest;
    ax_source = findobj(fig_source,'type','axes');
    ax_dest = findobj(fig_source,'type','axes');

    global st_source, global st_dest;
    global v_source, global v_dest;
    
    st_source = struct('x',-1,'y',-1);
    st_dest = struct('x',-1,'y',-1);
    
    global arr_start, global arr_stop;
    global line_data, global h_line, global h_point;
        
    global i_button_down;       % 0 = pre-press ; 1 = in-press ; 2 = post-press
    global i_insert;            % 0 = non-insert ; 1 = insert
    global i_delete;
    global b_edit;
    global b_wait;
    global b_state_change;
    global i_operation;     % Use i_operation=1 for insert, i_operation=2 for delete, i_operation=0 for quit
    global i_key_state;     % Us i_key_state=0 for null, i_key_state=1 for press, i_key_state=2 for release

    i_operation = 1;
    b_edit = true;          % Used for key listening
    b_state_change = true;
    i_key_state = 0;
    while(logical(i_operation))
        if(b_state_change)
            disp('   Type :');
            disp('          (I)nsert offset vector');
            disp('          (D)elete offset vector');
            disp('          (B)ack');
            disp('                ');
            b_state_change = false;
        end

        while(~b_state_change)
            %% Wait for inputs
            pause(1);
            
            if(i_operation == 1)
                [st_data] = fnMenuInsert(st_data, fig_source, fig_dest, false);
                if(i_operation ~= 1 || i_operation == 0)
                    b_state_change = true;
                    break;
                else
                    b_state_change = false;
                end
            end
            if(i_operation == 2)
                [st_data] = fnMenuDelete(st_data, fig_source, fig_dest, false);
                if(i_operation ~= 2 || i_operation == 0)
                    b_state_change = true;
                    break;
                else
                    b_state_change = false;
                end
            end
            
            %% Reset key state aftr press
            if(i_key_state == 2);
                i_key_state = 0;
            end
            if(i_operation == 0)
                b_edit = false;
                return;
            end
        end
        %% Reset key state aftr press
        if(i_key_state == 2);
            i_key_state = 0;
        end
        if(i_operation == 0)
            b_edit = false;
            return;
        end
        
    end
    b_edit = false;


end

