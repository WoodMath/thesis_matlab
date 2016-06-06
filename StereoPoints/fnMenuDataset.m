function [ st_data ] = fnMenuDataset(st_data, fig_source, fig_dest)
%fnMenuDataset edits the loaded dataset
%   Detailed explanation goes here

    s_input = '';
    
    while(~(strcmpi(s_input,'insert') || strcmpi(s_input,'i') || strcmpi(s_input,'insert') || strcmpi(s_input,'i') || strcmpi(s_input,'delete') || strcmpi(s_input,'d') || strcmpi(s_input,'clear') || strcmpi(s_input,'c') || strcmpi(s_input,'refresh') || strcmpi(s_input,'r') || strcmpi(s_input,'main') || strcmpi(s_input,'m'))) 
        disp('   What do you want to do with the dataset :');
        disp('          (E)dit by speed');
        disp('          (I)nsert offset vector');
        disp('          (D)elete offset vector');
        disp('          (C)lear offset vectors');
        disp('          (R)efresh view');
        disp('          (M)ain Menu');
        disp('                ');
        

        %% Update image size
        fnUpdate(fig_source, fig_dest);
        
        s_prompt = '   Please make selection : ';
        s_input = input(s_prompt,'s');

        %% Update image size
        fnUpdate(fig_source, fig_dest);

        if(isempty(s_input))
            continue
        end
        switch s_input(1)
            case {'i', 'I'}
                %% Get poiint
                [v_source, v_dest, h_point_source, h_point_dest] = fnMenuInsert(fig_source, fig_dest);
                %% Append point
                if(isempty(st_data.Points(1).Source) && isempty(st_data.Points(1).Destination))
                    st_data.Points(1).Source = v_source;
                    st_data.Points(1).Destination = v_dest;
                    st_data.Points(1).handleSource = h_point_source;
                    st_data.Points(1).handleDest = h_point_dest;
                else
                    i_count = length(st_data.Points);
                    st_data.Points(i_count+1) = struct('Source', v_source, 'Destination', v_dest, 'handleSource', h_point_source, 'handleDestination', h_point_dest);
                end
                s_input = '';           % Continue in loop
            case {'d', 'D'}
                [st_data] = fnMenuDelete(st_data, fig_source, fig_dest)
                s_input = '';           % Continue in loop
            case {'c', 'C'}
                [st_data] = fnMenuClear(st_data);
%                 [fig_source, fig_dest, st_data] = fnMenuDisplay(st_data);
                s_input = '';           % Continue in loop
            case {'r', 'R'}
                fnUpdate(fig_source, fig_dest);
                s_input = '';           % Continue in loop
            case {'m', 'M'}
                break;
            otherwise
                warning('   *** Please make an appropriate selection *** ');
        end
        disp('            ');
    end
    

end

