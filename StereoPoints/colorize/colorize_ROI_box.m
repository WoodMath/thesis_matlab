clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures.
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
fontSize = 20;

% Read in a standard MATLAB gray scale demo image.
folder = fileparts(which('cameraman.tif')); % Determine where demo folder is (works with all versions).
baseFileName = 'cameraman.tif';
fullFileName = fullfile(folder, baseFileName);
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
	% Didn't find it there.  Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
grayImage = imread(fullFileName);
% Get the dimensions of the image.  numberOfColorBands should be = 1.
[rows columns numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
subplot(2, 2, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
set(gcf,'name','Image Analysis Demo','numbertitle','off') 

message = sprintf('Draw a box');
uiwait(msgbox(message));
k = waitforbuttonpress;
point1 = get(gca,'CurrentPoint');    % button down detected
finalRect = rbbox;                   % return figure units
point2 = get(gca,'CurrentPoint');    % button up detected
point1 = point1(1,1:2);              % extract x and y
point2 = point2(1,1:2);
p1 = min(point1,point2);             % calculate locations
offset = abs(point1-point2);         % and dimensions
x = round([p1(1) p1(1)+offset(1) p1(1)+offset(1) p1(1) p1(1)])
y = round([p1(2) p1(2) p1(2)+offset(2) p1(2)+offset(2) p1(2)]);
hold on
axis manual
plot(x,y)   
croppedImage = grayImage(y(1):y(3), x(1):x(2));
% Display the cropped gray scale image.
subplot(2, 2, 2);
imshow(croppedImage, []);
title('Cropped Image', 'FontSize', fontSize);

% Make them color images.
% Use the jet colormap
rgbCroppedImage =uint8(255 * ind2rgb(croppedImage, jet));
% Display the colorized cropped gray scale image.
subplot(2, 2, 3);
imshow(rgbCroppedImage, []);
title('Colorized Cropped Image', 'FontSize', fontSize);

% Make the original image color.
rgbImage = cat(3, grayImage, grayImage, grayImage);
% Insert the colored portion:
rgbImage(y(1):y(3), x(1):x(2), :) = rgbCroppedImage;
% Display the colored gray scale image.
subplot(2, 2, 4);
imshow(rgbImage, []);
title('Colorized Cropped Image Inserted', 'FontSize', fontSize);
