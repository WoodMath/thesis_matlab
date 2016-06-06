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
    global i_edit;
    b_loop = true;
    
    while(b_loop)
        disp('   Type :');
        disp('          (I)nsert offset vector');
        disp('          (D)elete offset vector');
        disp('          (B)ack');
        disp('                ');
        
        w = waitforbuttonpress;
        
        
    end


end

