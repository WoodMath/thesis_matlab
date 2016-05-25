% Demo to have the user freehand draw an irregular shape over
% a gray scale image, have it convert that portion to a
% color RGB image defined by a colormap.

clc;	% Clear command window.
workspace;	% Make sure the workspace panel is showing.
fontSize = 16;

% Read in a standard MATLAB gray scale demo image.
folder = fileparts(which('cameraman.tif')); % Determine where demo folder is (works with all versions).
baseFileName = 'cameraman.tif';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
	% File doesn't exist -- didn't find it there.  Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
grayImage = imread(fullFileName);
imshow(grayImage, []);
axis on;
title('Original Grayscale Image', 'FontSize', fontSize);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
message = sprintf('Left click and hold to begin drawing.\nSimply lift the mouse button to finish');
uiwait(msgbox(message));
hFH = imfreehand();
% Create a binary image ("mask") from the ROI object.
binaryImage = hFH.createMask();
xy = hFH.getPosition;

% Now make it smaller so we can show more images.
subplot(2, 2, 1);
imshow(grayImage, []);
axis on;
drawnow;
title('Original Grayscale Image', 'FontSize', fontSize);

% Display the freehand mask.
subplot(2, 2, 2);
imshow(binaryImage);
axis on;
title('Binary mask of the region', 'FontSize', fontSize);

% Convert the grayscale image to RGB using the jet colormap.
rgbImage = ind2rgb(grayImage, jet(256));
% Scale and convert from double (in the 0-1 range) to uint8.
rgbImage = uint8(255*rgbImage);
% Display the RGB image.
subplot(2, 2, 3);
imshow(rgbImage);
axis on;
title('RGB Image from Jet Colormap', 'FontSize', fontSize);

% Extract the red, green, and blue channels from the color image.
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);

% Create a new color channel images for the output.
outputImageR = grayImage;
outputImageG = grayImage;
outputImageB = grayImage;

% Transfer the colored parts.
outputImageR(binaryImage) = redChannel(binaryImage);
outputImageG(binaryImage) = greenChannel(binaryImage);
outputImageB(binaryImage) = blueChannel(binaryImage);

% Convert into an RGB image
outputRGBImage = cat(3, outputImageR, outputImageG, outputImageB);
% Display the output RGB image.
subplot(2, 2, 4);
imshow(outputRGBImage);
axis on;
title('Output RGB Image', 'FontSize', fontSize);
