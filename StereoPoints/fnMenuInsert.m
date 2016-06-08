function [st_data] = fnMenuInsert(st_data, fig_source, fig_dest, b_verbose)
%fnMovePoint used to create offset vectors
%   Creates a blue line on 'fig_source'
%   with a red dot on the corresponind position on 'fig
%   returns are in [Row, Column] format


    global i_operation;     % Use i_operation=1 for insert, i_operation=2 for delete, i_operation=0 for quit

    if(i_operation ~= 1)
        return;
    end

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
    
    s_input = '';           % Continue in loop
    s_YN = 'n';


    i_insert = 1;
    while(strcmpi(s_YN,'n'))
        fnUpdate(h_source, h_dest);
        if(i_operation ~=1)
            i_insert = 0;
            return;
        end        
        figure(h_dest);
        hold on;
        
        figure(h_source);
        hold on;
        i_button_down = 0; % State of Mouse Button

        %% Loop until mouse button has been clicked and released
        disp('   *** Select point to Insert *** ');
        while(i_button_down<2)
            fnUpdate(h_source, h_dest);
            
            if(i_operation ~=1)
                i_insert = 0;
                return;
            end
            pause(1);
        end
        
        fnUpdate(h_source, h_dest);
        
        if(b_verbose)
            commandwindow;
            s_YN = input('   Accept offset vector? (y/n) ', 's');
            if(strcmpi(s_YN, 'n'))
                if(~isempty(h_line))
                    delete(h_line)
                end
                if(~isempty(h_point))
                    delete(h_point)
                end
            end
        else
            s_YN = 'y';
        end
    end
    i_insert = 0;
    
%     %% Mouse Down
%     function ImageClickDown ( objectHandle , eventData )
%         %% Image being clicked on is not source
%         if(not(gcf == fig_source))
%             return
%         end
%         
%         if(i_button_down~=0)
%             return
%         end
% %         axesHandle = findobj(objectHandle,'type','axes');
% %         coordinates = get(axesHandle,'CurrentPoint');
%         coordinates = get(ax_source, 'CurrentPoint');
%         coordinates = round(coordinates(1,1:2));
%         
%         arr_start = coordinates;
%         arr_stop = coordinates;
% 
%         line_data = [arr_start; arr_stop];
% 
%         %% Draw a red dot on destination
%         sfigure(h_dest);
%         hold on
%         h_point = plot(line_data(2,1), line_data(2,2), 'sr', 'MarkerSize', 5, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
%         hold off
% 
%         %% Draw a blue line on source
%         sfigure(h_source);
%         hold on
%         h_line = line(line_data(:,1)', line_data(:,2)','Color', 'b', 'LineWidth', 2);
%         hold off
%         
% %         disp([' WindowButtonDownFcn = ', num2str(coordinates)])
%         st_source = struct('x',coordinates(1),'y',coordinates(2));
%         v_source = [st_source.y, st_source.x]; 
%         i_button_down = 1;        
% 
%     end
% 
%     %% Mouse Move
%     function ImageClickMove ( objectHandle , eventData )
%         %% Image being clicked on is not source
%         if(not(gcf == fig_source))
%             return
%         end
%         
%         if(i_button_down == 1)
% %             axesHandle = findobj(objectHandle,'type','axes');
% %             coordinates = get(axesHandle,'CurrentPoint');
%             coordinates = get(ax_source, 'CurrentPoint');
%             coordinates = round(coordinates(1,1:2));
%             
%             arr_stop = coordinates;
%             line_data = [arr_start; arr_stop];
%             set(h_line, 'XData', line_data(:,1)', 'YData', line_data(:,2)');            
%             set(h_point, 'XData', line_data(2,1)', 'YData', line_data(2,2)');            
% 
% %             disp([' WindowButtonMotionFcn = ', num2str(coordinates)])
%             st_dest = struct('x',coordinates(1),'y',coordinates(2));
%             v_dest = [st_dest.y, st_dest.x]; 
% 
%         end
% 
%     end
% 
%     %% Mouse Up
%     function ImageClickUp ( objectHandle , eventData )
%         %% Image being clicked on is not source
%         if(not(gcf == fig_source))
%             return
%         end
% 
%         if(i_button_down == 1)        
% %             axesHandle = findobj(objectHandle,'type','axes');
% %             coordinates = get(axesHandle,'CurrentPoint');
%             coordinates = get(ax_source, 'CurrentPoint');
%             coordinates = round(coordinates(1,1:2));
%         
%             %% Store as final resting coordinates
%             arr_stop = coordinates;
%             line_data = [arr_start; arr_stop];
%             set(h_line, 'XData', line_data(:,1)', 'YData', line_data(:,2)');
%             set(h_point, 'XData', line_data(2,1)', 'YData', line_data(2,2)'); 
% 
% %             disp([' WindowButtonUpFcn = ', num2str(coordinates)])
%             st_dest = struct('x',coordinates(1),'y',coordinates(2));
%             v_dest = [st_dest.y, st_dest.x];
% 
%             % Exit out of state
%             i_button_down = 2;
% 
%         end
% 
%     end



    if(~isempty(h_line))
        delete(h_line)
    end
    if(~isempty(h_point))
        delete(h_point)
    end
    
    sfigure(fig_source);
    hold on
    %% Draw a blue dot on source
    h_point_source = plot(v_source(1,2), v_source(1,1), 'sb', 'MarkerSize', 5, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');
    hold off

    sfigure(fig_dest);
    hold on
    %% Draw a red dot on destination
    h_point_dest = plot(v_dest(1,2), v_dest(1,1), 'sr', 'MarkerSize', 5, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
    hold off
            
    if(isempty(st_data.Points(1).Source) && isempty(st_data.Points(1).Destination))
        st_data.Points(1).Source = v_source;
        st_data.Points(1).Destination = v_dest;
        st_data.Points(1).handleSource = h_point_source;
        st_data.Points(1).handleDest = h_point_dest;
    else
        i_count = length(st_data.Points);
        st_data.Points(i_count+1) = struct('Source', v_source, 'Destination', v_dest, 'handleSource', h_point_source, 'handleDestination', h_point_dest);
    end
end