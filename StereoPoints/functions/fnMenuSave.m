function [  ] = fnMenuSave( data )
%fnMenuSave Summary of this function goes here
%   Detailed explanation goes here

    commandwindow;
    s_filename = input('   Type the path/name of the file to save : ', 's');
    save(s_filename, 'data');

    disp(['   *** Save file ''', s_filename, ''' completed *** ']);
    disp('   ');

end

