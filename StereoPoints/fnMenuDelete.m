function [st_data] = fnMenuDelete(st_data, fig_source, fig_dest, b_verbose)
%fnMenuDelete deletes a selected point from st_data
%   Detailed explanation goes here
    global i_insert;
    global i_operation;     % Use i_operation=1 for insert, i_operation=2 for delete, i_operation=0 for quit

    if(i_operation ~= 2)
        return;
    end

    if(isempty(st_data.Points))
        return;
    end    
    
    if(isempty(st_data.Points(1).Source) || isempty(st_data.Points(1).Destination))
        return;
    end
    
    fnUpdate(fig_source, fig_dest);
    st_source = st_data.Source;
    st_dest = st_data.Destination;
    st_points = st_data.Points;
    
    disp('   *** Select point to Delete *** ');
    
    i_insert = 0;
    while(~(strcmpi(get(gco,'type'),'line')))
        fnUpdate(fig_source, fig_dest);
        if(i_operation ~=2)
            return;
        end
        pause(1);
    end

    if(b_verbose)
        commandwindow;
        s_input = input('   Are you sure you wish to delete? (y/n) ', 's');
        if(strcmpi(s_input,'n'))
            return
        end
    end
    
    ax_source = findobj(fig_source,'type','axes');
    ax_dest = findobj(fig_dest,'type','axes');

    i_count = length(st_data.Points());
    mat_source = reshape([st_data.Points().Source], 2, i_count)';
    mat_dest = reshape([st_data.Points().Destination], 2, i_count)';

    v_point = [get(gco,'YData'), get(gco,'XData')];
    mat_point = repmat(v_point, i_count, 1);
   
    %% Finds index of matching element
    h_parent = get(gco,'parent');
    if(get(gco,'parent') == ax_source || get(gco,'parent') == fig_source)
        b_index = uint8(prod(uint8(mat_point == mat_source), 2));
        i_index = find(b_index);
    end
    
    if(get(gco,'parent') == ax_dest || get(gco,'parent') == fig_dest)
        b_index = uint8(prod(uint8(mat_point == mat_dest), 2));
        i_index = find(b_index);
    end
    %% Set back to parent so their is no loop
    gco(h_parent);
    
    v_indices = zeros(i_count, 1, 'uint64');
    v_indices(i_index) = 1;
    b_indices = logical(v_indices);
    
    %% Go over all matching points
    for i_inc = i_index
 
        if(~isempty(st_data.Points(i_inc).handleSource))
            delete(st_data.Points(i_inc).handleSource);
        end
        if(~isempty(st_data.Points(i_inc).handleDestination))
            delete(st_data.Points(i_inc).handleDestination);
        end

    end
    
    st_points = st_points(~b_indices);
    st_data = struct('Source', st_source, 'Destination', st_dest, 'Points', st_points);

end