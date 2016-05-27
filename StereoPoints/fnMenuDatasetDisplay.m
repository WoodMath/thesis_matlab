function [  ] = fnMenuDatasetDisplay()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    s_input = '';
    while(~(strcmpi(s_input,'i') || strcmpi(s_input,'d') || strcmpi(s_input,'c') || strcmpi(s_input,'b') || strcmpi(s_input,'q'))) 
        disp(' What do you want to do with the dataset :');
        disp('      (I)nsert offset vector');
        disp('      (D)elete offset vector');
        disp('      (C)lear offset vectors');
        disp('      (B)ack to previous');
        disp('      (Q)uit');
 
        s_prompt = 'Please make selection : ';
        s_input = input(s_prompt,'s');
        
        switch s_input
            case {'i', 'I'}
                    s_input = '';           % Continue in loop
            case {'d', 'D'}
                    s_input = '';           % Continue in loop
            case {'c', 'C'}
                    s_input = '';           % Continue in loop

            case {'b', 'B'}
            case {'q', 'Q'}
                error(' Quitting ');
            otherwise
                warning(' ** Please make an appropriate selection ** ');
        end       
    end
    

end

