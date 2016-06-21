function [ st_out ] = fnMenuNewImage()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    s_prompt = 'Relative path of image : ';
    commandwindow;
    s_filename = input(s_prompt,'s');
    try
        im_data = imread(s_filename);  
    catch
        warning(['Could not load the file ''', s_filename, '''']);
        im_data = [];
    end
    st_out = struct('FileName',s_filename,'ImageData',im_data);

end

