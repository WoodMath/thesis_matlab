function fnImageClickDown ( objectHandle , eventData )

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

    if(i_button_down~=0)
        return
    end
%         axesHandle = findobj(objectHandle,'type','axes');
%         coordinates = get(axesHandle,'CurrentPoint');
    ax_source = findobj(h_source,'type','axes');
    ax_dest = findobj(h_dest,'type','axes');
    
    coordinates = get(ax_source, 'CurrentPoint');
    coordinates = round(coordinates(1,1:2));

    arr_start = coordinates;
    arr_stop = coordinates;

    line_data = [arr_start; arr_stop];

    %% Draw a red dot on destination
    sfigure(h_dest);
    hold on
    h_point = plot(line_data(2,1), line_data(2,2), 'sr', 'MarkerSize', 5, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
    hold off

    %% Draw a blue line on source
    sfigure(h_source);
    hold on
    h_line = line(line_data(:,1)', line_data(:,2)','Color', 'b', 'LineWidth', 2);
    hold off

%         disp([' WindowButtonDownFcn = ', num2str(coordinates)])
    st_source = struct('x',coordinates(1),'y',coordinates(2));
    v_source = [st_source.y, st_source.x]; 
    i_button_down = 1;        

end