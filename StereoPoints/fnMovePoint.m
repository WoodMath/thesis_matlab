function [s_source, s_dest] = fnMovePoint(fig_source, fig_dest)

%     hAllAxes = findobj(gcf,'type','axes');
    ax_source = findobj(fig_source,'type','axes');
    ax_dest = findobj(fig_source,'type','axes');

    s_source = struct('x',-1,'y',-1);
    s_dest = struct('x',-1,'y',-1);

    imageHandle = fig_source;
    figure(imageHandle);
%     set(imageHandle,'ButtonDownFcn',@ImageClickDown);

    %set(h,'KeyReleaseFcn',@ImageClickUp);
    set(gcf, 'WindowButtonDownFcn',@ImageClickDown);
    set(gcf, 'WindowButtonUpFcn',@ImageClickUp);
    set(gcf, 'WindowButtonMotionFcn',@ImageClickMove);

    function ImageClickDown ( objectHandle , eventData )
        axesHandles  = get(objectHandle,'Parent');
        coordinates = get(gca,'CurrentPoint'); 
        coordinates = coordinates(1,1:2);
        setappdata(gcf,'down', coordinates);
        disp([' WindowButtonDownFcn = ', num2str(coordinates)])
        s_source = struct('x',coordinates(1),'y',coordinates(2));
    end
    function ImageClickUp ( objectHandle , eventData )
        axesHandle = findobj(objectHandle,'type','axes');
        coordinates = get(axesHandle,'CurrentPoint'); 
        coordinates = coordinates(1,1:2);
        down=getappdata(gcf,'down');
        up=coordinates;
        %do stuff with up and down
        disp([' WindowButtonUpFcn = ', num2str(coordinates)])
        s_dest = struct('x',coordinates(1),'y',coordinates(2));
    end
    function ImageClickMove ( objectHandle , eventData )
        %axesHandle  = get(objectHandle,'Parent');
        axesHandle = findobj(objectHandle,'type','axes');
        coordinates = get(axesHandle,'CurrentPoint'); 
        coordinates = coordinates(1,1:2);
        down=getappdata(gcf,'down');
        up=coordinates;
        %do stuff with up and down
        disp([' WindowButtonMotionFcn = ', num2str(coordinates)])
        s_dest = struct('x',coordinates(1),'y',coordinates(2));
    end

end