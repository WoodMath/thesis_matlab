function [  ] = fnMenuMainDisplay( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    s_input = '';
    while(~(strcmpi(s_input,'n') || strcmpi(s_input,'l') || strcmpi(s_input,'s') || strcmpi(s_input,'q')))  
        disp(' What do you want to do with the dataset :');
        disp('      (N)ew image dataset');
        disp('      (L)oad image dataset');
        disp('      (S)ave current image dataset');
        disp('      (Q)uit');
        
        s_prompt = 'Please make selection : ';
        s_input = input(s_prompt,'s');
        
        switch s_input
            case {'n', 'N'}
                [st_source, st_dest] = fnMenuNewDisplay();
            case {'l', 'L'}
            case {'s', 'S'}
            case {'q', 'Q'}
            otherwise
                warning(' ** Please make an appropriate selection ** ');
        end
        
    end

    
end

