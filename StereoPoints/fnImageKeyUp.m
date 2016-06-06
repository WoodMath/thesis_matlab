function fnImageClickUp ( objectHandle , eventData )

    global i_button_down;
    global line_data, global h_line, global h_point;
    global st_source, global st_dest;
    global v_source, global v_dest;
    global arr_start, global arr_stop;
    global h_source, global h_dest;
    global ax_source, global ax_dest;
    global i_insert;
    
    %% If not on insert, exit out
    if(i_insert == 0)
        return
    end

    %% Image being clicked on is not source
    if(not(gcf == h_source))
        return
    end

    if(i_button_down == 1)        
%             axesHandle = findobj(objectHandle,'type','axes');
%             coordinates = get(axesHandle,'CurrentPoint');
        ax_source = findobj(h_source,'type','axes');
        ax_dest = findobj(h_dest,'type','axes');
    
        coordinates = get(ax_source, 'CurrentPoint');
        coordinates = round(coordinates(1,1:2));

        %% Store as final resting coordinates
        arr_stop = coordinates;
        line_data = [arr_start; arr_stop];
        set(h_line, 'XData', line_data(:,1)', 'YData', line_data(:,2)');
        set(h_point, 'XData', line_data(2,1)', 'YData', line_data(2,2)'); 

%             disp([' WindowButtonUpFcn = ', num2str(coordinates)])
        st_dest = struct('x',coordinates(1),'y',coordinates(2));
        v_dest = [st_dest.y, st_dest.x];

        % Exit out of state
        i_button_down = 2;

    end

end