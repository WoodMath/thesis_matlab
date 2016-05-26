function [s_source, s_dest] = fnMovePoint(fig_source, fig_dest)
%fnMovePoint used to create offset vectors
%   Creates a blue line on 'fig_source'
%   with a red dot on the corresponind position on 'fig

    %% Make figure handles global to handle between callbacks
    global h_source, global h_dest;
    h_source = fig_source;
    h_dest = fig_dest;
    
    global ax_source, global ax_dest;
    ax_source = findobj(fig_source,'type','axes');
    ax_dest = findobj(fig_source,'type','axes');

    s_source = struct('x',-1,'y',-1);
    s_dest = struct('x',-1,'y',-1);
    
    global arr_start, global arr_stop;
    global line_data, global h_line, global h_point;
    
    
    figure(h_source);
    hold on;

    %% Set callback functions
    set(gcf, 'WindowButtonDownFcn', @ImageClickDown);
    set(gcf, 'WindowButtonUpFcn', @ImageClickUp);
    set(gcf, 'WindowButtonMotionFcn', @ImageClickMove);

    
    global i_button_down; % 0 = pre-press ; 1 = in-press ; 2 = post-press
    
    i_button_down = 0; % State of Mouse Button
    
    %% Loop until mouse button has been clicked and released
    while(i_button_down<2)
        pause(2);
    end
    
    
    
    %% Mouse Down
    function ImageClickDown ( objectHandle , eventData )
        %% Image being clicked on is not source
        if(not(gcf == fig_source))
            return
        end
        
        if(i_button_down~=0)
            return
        end
%         axesHandle = findobj(objectHandle,'type','axes');
%         coordinates = get(axesHandle,'CurrentPoint');
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
        s_source = struct('x',coordinates(1),'y',coordinates(2));
        i_button_down = 1;        

    end


    %% Mouse Move
    function ImageClickMove ( objectHandle , eventData )
        %% Image being clicked on is not source
        if(not(gcf == fig_source))
            return
        end
        
        if(i_button_down == 1)
%             axesHandle = findobj(objectHandle,'type','axes');
%             coordinates = get(axesHandle,'CurrentPoint');
            coordinates = get(ax_source, 'CurrentPoint');
            coordinates = round(coordinates(1,1:2));
            
            arr_stop = coordinates;
            line_data = [arr_start; arr_stop];
            set(h_line, 'XData', line_data(:,1)', 'YData', line_data(:,2)');            
            set(h_point, 'XData', line_data(2,1)', 'YData', line_data(2,2)');            

%             disp([' WindowButtonMotionFcn = ', num2str(coordinates)])
            s_dest = struct('x',coordinates(1),'y',coordinates(2));
        end

    end


    %% Mouse Up
    function ImageClickUp ( objectHandle , eventData )
        %% Image being clicked on is not source
        if(not(gcf == fig_source))
            return
        end

        if(i_button_down == 1)        
%             axesHandle = findobj(objectHandle,'type','axes');
%             coordinates = get(axesHandle,'CurrentPoint');
            coordinates = get(ax_source, 'CurrentPoint');
            coordinates = round(coordinates(1,1:2));
        
            %% Store as final resting coordinates
            arr_stop = coordinates;
            line_data = [arr_start; arr_stop];
            set(h_line, 'XData', line_data(:,1)', 'YData', line_data(:,2)');
            set(h_point, 'XData', line_data(2,1)', 'YData', line_data(2,2)'); 

            % Exit out of state
            i_button_down = 2;

%             disp([' WindowButtonUpFcn = ', num2str(coordinates)])
            s_dest = struct('x',coordinates(1),'y',coordinates(2));

        end

    end

end