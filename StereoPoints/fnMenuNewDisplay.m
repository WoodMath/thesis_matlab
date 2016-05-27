function [st_out] = fnMenuNewDisplay()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    s_input = '';
    st_source = struct('FileName',[],'ImageData',[]);
    st_dest = struct('FileName',[],'ImageData',[]);
    
    while(~(strcmpi(s_input,'s') || strcmpi(s_input,'d') || strcmpi(s_input,'b') || strcmpi(s_input,'q'))) 
        disp(' Select images for the new dataset :');
        disp('      (S)ource image select');
        disp('      (D)estination image select');
        disp('      (B)ack to previous');
        disp('      (Q)uit');
        
        s_prompt = 'Please make selection : ';
        s_input = input(s_prompt,'s');
        
        switch s_input
            case {'s', 'S'}
                disp(' Selecting Source Image');
                st_source = fnMenuNewImage();
            case {'d', 'D'}
                disp(' Selecting Destination Image');
                st_dest = fnMenuNewImage();
            case {'b', 'B'}
                break;
            case {'q', 'Q'}
                error(' Quitting ');
            otherwise
                warning(' ** Please make an appropriate selection ** ');
        end
        
        
    end

    st_out = struct('Source', st_source, 'Destination', st_dest);
    
end


