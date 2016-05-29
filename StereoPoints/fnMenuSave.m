function [  ] = fnMenuSave( s_filename, data )
%fnMenuSave Summary of this function goes here
%   Detailed explanation goes here
    save(s_filename, 'data');

    disp(['   *** Save file ''', s_filename, ''' completed *** ']);
    disp('   ');

end

