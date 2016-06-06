function myui
% Create a figure and axes
    f = figure('Visible','off');
    clear all;
    close all;
    % f = uifigure();
    % sl = uislider();
    % val = sl.Value;
    % sl.Value=0;
    im_test = imread('./tsukuba/scene1.row3.col5.ppm');
    imshow(im_test);


    % Create slider
    sld = uicontrol('Style', 'slider', 'Min', 0, 'Max', 1, 'Value', 0);
    set(sld,'Units','normalized');
    set(sld,'Position', [0.1 0.1 .8 0.05],'Callback', @surfzlim);
    set(sld,'SliderStep', [0.1 0.1]);
    
    txt = uicontrol('Style', 'text')
    set(txt,'Units','normalized');
    set(txt,'Position',[0.1 0.00 .8 0.1], 'String','Interpolation Control');
    f.Visible = 'on';
    function surfzlim(source, callbackdata)
        val = source.Value;
        % For R2014a and earlier:
        % val = 51 - get(source,'Value');

    end
end