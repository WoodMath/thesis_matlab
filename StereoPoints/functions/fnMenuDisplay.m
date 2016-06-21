function [ fig_source, fig_dest, st_data ] = fnMenuDisplay(st_data)
%fnMenuDesiplay Loads data into figures
%   returns handles of figures

%   Taken from:
%       http://stackoverflow.com/questions/16613252/how-to-use-keypressfcn-in-matlab-with-a-function-already-create
%       http://www.mathworks.com/help/matlab/ref/figure-properties.html#zmw57dd0e240226
    close all;

    if(length(st_data.Source.ImageData) > 0)
        fig_source = sfigure(1);
%         set(gcf, 'SizeChangedFcn', @Update);
%         set(gcf, 'ResizeFcn', @Update);

        imshow(st_data.Source.ImageData);
        set(fig_source, 'Name', 'Source Image');
        axis ij;
    else
        warning(' No source data to display ');
        fig_source = -1;
    end
    if(length(st_data.Destination.ImageData) > 0)
        fig_dest = sfigure(2);
%         set(gcf, 'SizeChangedFcn', @Update);
%         set(gcf, 'ResizeFcn', @Update);
        
        imshow(st_data.Destination.ImageData);
        set(fig_dest, 'Name', 'Destination Image');
        axis ij;
    else
        warning(' No destination data to display ');
        fig_dest = -1;
    end

    if(not (isempty(st_data.Points(1).Source) || isempty(st_data.Points(1).Destination)))
        i_count = length(st_data.Points());
        mat_source = reshape([st_data.Points().Source], 2, i_count)';
        mat_dest = reshape([st_data.Points().Destination], 2, i_count)';

        sfigure(fig_source);
        hold on
        for i_inc = 1:i_count
            %% Draw a blue dot on source
            h_point = plot(mat_source(i_inc,2), mat_source(i_inc,1), 'sb', 'MarkerSize', 5, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');
            st_data.Points(i_inc).handleSource = h_point;
        end
        hold off

        sfigure(fig_dest);
        hold on
        for i_inc = 1:i_count
            %% Draw a red dot on destination
            h_point = plot(mat_dest(i_inc,2), mat_dest(i_inc,1), 'sr', 'MarkerSize', 5, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
            st_data.Points(i_inc).handleDestination = h_point;
        end
        hold off

%         sfigure(fig_source);
%         hold on
%         h_scat_source = scatter(mat_source(:,2)', mat_source(:,1)', 15, 'b', 'filled');
%         hold off
% 
%         sfigure(fig_dest);
%         hold on
%         h_scat_dest = scatter(mat_dest(:,2)', mat_dest(:,1)', 15, 'r', 'filled');
%         hold off

    end

    if(length(st_data.Destination.ImageData) > 0)
        figure(fig_dest)
        %% Set callback functions
        set(gcf, 'WindowKeyPressFcn', @fnImageKeyDown);
        set(gcf, 'WindowKeyReleaseFcn', @fnImageKeyUp);
%         set(gcf, 'KeyPressFcn', @fnImageKeyDown);
%         set(gcf, 'KeyReleaseFcn', @fnImageKeyUp);        
    end
    
    if(length(st_data.Source.ImageData) > 0)
        figure(fig_source);
        %% Set callback functions
        set(gcf, 'WindowKeyPressFcn', @fnImageKeyDown);
        set(gcf, 'WindowKeyReleaseFcn', @fnImageKeyUp);
%         set(gcf, 'KeyPressFcn', @fnImageKeyDown);
%         set(gcf, 'KeyReleaseFcn', @fnImageKeyUp);        

        set(gcf, 'WindowButtonDownFcn', @fnImageClickDown);
        set(gcf, 'WindowButtonUpFcn', @fnImageClickUp);
        set(gcf, 'WindowButtonMotionFcn', @fnImageClickMove);
        
    end
    
end

