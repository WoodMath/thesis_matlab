clear all;
close all;

%% Add Points
% st_out = fnMenuMain();

if(~exist('st_out'))
    load('tsukuba');
    st_out = data;
    clear('data')
end

if(~exist('fig_source') || ~exist('fig_dest'))
    [fig_source, fig_dest, st_out] = fnMenuDisplay(st_out);
end

vRC_source = reshape([st_out.Points.Source], [2, length(st_out.Points)])';
vRC_dest = reshape([st_out.Points.Destination], [2, length(st_out.Points)])';

if(~isequal(size(st_out.Source.ImageData), size(st_out.Destination.ImageData)))
    return
end

%% Info needed for borders
vRC_size = size(st_out.Source.ImageData);

v_append = [1, 1; vRC_size(1), 1; 1, vRC_size(2); vRC_size(1), vRC_size(2)];
vRC_source_use = [vRC_source; v_append];
vCR_source_use = [vRC_source_use(:,2), vRC_source_use(:,1)];

vIDX_source = delaunay(vCR_source_use);

sfigure(fig_source);
fnTriPlot(vIDX_source, vCR_source_use(:,1), vCR_source_use(:,2), 'blue');

vRC_dest_use = [vRC_dest; v_append];
vCR_dest_use = [vRC_dest_use(:,2), vRC_dest_use(:,1)];

sfigure(fig_dest);
fnTriPlot(vIDX_source, vCR_dest_use(:,1), vCR_dest_use(:,2), 'red');

im_disp = imread('./tsukuba/truedisp.row3.col3.pgm');
im_pixel = imread('./tsukuba/scene1.row3.col3.ppm');
figure(31);
imshow(im_disp);
figure(32);
imshow(im_pixel);
