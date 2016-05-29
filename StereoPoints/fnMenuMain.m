function [ st_data ] = fnMenuMain( )
%fnMenuMain main menu for the program
%   Detailed explanation goes here

    s_input = '';
    st_data = [];
   
    while(~(strcmpi(s_input,'new') || strcmpi(s_input,'n') || strcmpi(s_input,'load') || strcmpi(s_input,'l') || strcmpi(s_input,'save') || strcmpi(s_input,'s') || strcmpi(s_input,'quit') || strcmpi(s_input,'q')))  
        disp('   What do you want to do with the dataset :');
        disp('          (N)ew image dataset');
        disp('          (L)oad image dataset');
        disp('          (S)ave current image dataset');
        disp('          (Q)uit');
        disp('            ');
        s_prompt = '   Please make selection : ';
        s_input = input(s_prompt,'s');
        
        switch s_input(1)
            case {'n', 'N'}
                [st_data] = fnMenuNew();
                [fig_source, fig_dest, st_data] = fnMenuDisplay(st_data);
                [st_data] = fnMenuDataset(st_data, fig_source, fig_dest);
                s_input='';
            case {'l', 'L'}
                [st_data] = fnMenuLoad();
                [fig_source, fig_dest, st_data] = fnMenuDisplay(st_data);
                [st_data] = fnMenuDataset(st_data, fig_source, fig_dest);
                s_input='';
            case {'s', 'S'}
                fnMenuSave(st_data);
                [st_data] = fnMenuDataset(st_data, fig_source, fig_dest);
                s_input='';
            case {'q', 'Q'}
                close all;
                return;
            otherwise
                warning('    *** Please make an appropriate selection *** ');
        end
        disp('            ');
    end

    
end

