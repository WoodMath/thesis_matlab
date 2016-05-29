function [ data ] = fnMenuLoad()
%fnMenuLoad loads data
%   Detailed explanation goes here
    data = [];

    s_filename = input('   Type the path/name of the file to load : ', 's');
    
    try
        load(s_filename, 'data'); 
    catch
        warning(['Could not load the file ''', s_filename, '''']);
        data = [];
    end
    
    disp(['   *** Load file ''', s_filename, ''' completed *** ']);
    disp('   ');

end

