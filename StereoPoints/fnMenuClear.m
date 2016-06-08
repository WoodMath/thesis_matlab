function [st_data] = fnMenuClear(st_data)
%fnMenuClear clears out all paired points
%   Detailed explanation goes here

    commandwindow;
    s_input = input('   Are you sure you wish to clear? (y/n) ', 's');
    if(~strcmpi(s_input,'y'))
        return
    end

    st_points(1) = struct('Source', [], 'Destination', [], 'handleSource', [], 'handleDestination', []);
    st_source = st_data.Source;
    st_dest = st_data.Destination;
    
    if(~isempty(st_data.Points(1).Source) && ~isempty(st_data.Points(1).Destination))
        i_count = length(st_data.Points);
        for i_inc = 1:i_count
            if(~isempty(st_data.Points(i_inc).handleSource))
                delete(st_data.Points(i_inc).handleSource);
            end
            if(~isempty(st_data.Points(i_inc).handleDestination))
                delete(st_data.Points(i_inc).handleDestination);
            end
            
        end
        
    end

        
    st_data = struct('Source', st_source, 'Destination', st_dest, 'Points', st_points);

end


