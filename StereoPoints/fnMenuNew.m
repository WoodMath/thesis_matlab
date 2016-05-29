function [st_data] = fnMenuNew()
%fnMenuNew creates a new dataset
%   Detailed explanation goes here

    s_input = '';
    st_source = struct('FileName',[],'ImageData',[]);
    st_dest = struct('FileName',[],'ImageData',[]);
    st_points(1) = struct('Source', [], 'Destination', [], 'handleSource', [], 'handleDestination', []);
    
    while(~(strcmpi(s_input,'source') || strcmpi(s_input,'s') || strcmpi(s_input,'destination') || strcmpi(s_input,'d') || strcmpi(s_input,'main') || strcmpi(s_input,'m'))) 
        disp('   Select images for the new dataset :');
        disp('          (S)ource image select');
        disp('          (D)estination image select');
        disp('          (M)ain Menu');
        disp('            ');
        s_prompt = '    Please make selection : ';
        s_input = input(s_prompt,'s');
        
        switch s_input(1)
            case {'s', 'S'}
                disp('                                ');
                disp('   *** Selecting Source Image *** ');
                st_source = fnMenuNewImage();
                if(~isempty(st_dest.ImageData))
                    break;
                end
                s_input = '';
            case {'d', 'D'}
                disp('                                     ');
                disp('   *** Selecting Destination Image *** ');
                st_dest = fnMenuNewImage();
                if(~isempty(st_source.ImageData))
                    break;
                end
                s_input = '';
            case {'m', 'M'}
                if(length(st_source.ImageData) == 0 || length(st_dest.ImageData) == 0)
                    if(length(st_source.ImageData) == 0)
                        warning(' No source image selected ');
                    end
                    if(length(st_dest.ImageData) == 0)
                        warning(' No destination image selected ');
                    end
                    s_YN = input('   Are you SURE you wish to GO BACK? (y/n)', 's');
                    disp('                                     ');
                    if(strcmpi(s_YN, 'n'))
                        s_input = '';
                        continue;
                    end
                end
                break;
            otherwise
                warning('    *** Please make an appropriate selection *** ');
        end
        disp('            ');
        
    end

    st_data = struct('Source', st_source, 'Destination', st_dest, 'Points', st_points);
    
end


