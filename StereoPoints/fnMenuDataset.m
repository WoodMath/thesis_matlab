function [ st_data ] = fnMenuDataset(st_data, fig_source, fig_dest)
%fnMenuDataset edits the loaded dataset
%   Detailed explanation goes here

   global i_operation;     % Use i_operation=1 for insert, i_operation=2 for delete, i_operation=0 for quit

    s_input = '';
    
    
    while(~(strcmpi(s_input,'edit') || strcmpi(s_input,'e') || strcmpi(s_input,'insert') || strcmpi(s_input,'i') || strcmpi(s_input,'delete') || strcmpi(s_input,'d') || strcmpi(s_input,'clear') || strcmpi(s_input,'c') || strcmpi(s_input,'refresh') || strcmpi(s_input,'r') || strcmpi(s_input,'main') || strcmpi(s_input,'m'))) 
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
        commandwindow;
        s_input = input(s_prompt,'s');

        %% Update image size
        fnUpdate(fig_source, fig_dest);

        if(isempty(s_input))
            continue
        end
        switch s_input(1)
            case {'e', 'E'}
                i_operation = 0;
                [st_data] = fnMenuEdit(st_data, fig_source, fig_dest);
                s_input = '';           % Continue in loop
                i_operation = 0;
            case {'i', 'I'}
                i_operation = 1;
                [st_data] = fnMenuInsert(st_data, fig_source, fig_dest, true);
                s_input = '';           % Continue in loop
                i_operation = 1;
            case {'d', 'D'}
                i_operation = 2;
                [st_data] = fnMenuDelete(st_data, fig_source, fig_dest, true)
                s_input = '';           % Continue in loop
                i_operation = 2;
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

