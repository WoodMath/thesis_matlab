function [ data ] = fnMenuLoad( s_filename )
%fnMenuLoad loads data
%   Detailed explanation goes here
    data = [];

    try
        load(s_filename, 'data'); 
    catch
        warning(['Could not load the file ''', s_filename, '''']);
        data = [];
    end
    
    disp(['   *** Load file ''', s_filename, ''' completed *** ']);
    disp('   ');

end

