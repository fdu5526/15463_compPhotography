% 15-463: Assignment 1, starter Matlab code

% name of the input file
imname = 'D:\15463_data\1.data\00029u.tif';

% read in the image
fullim = imread(imname);

% convert to double matrix (might want to do this later on to same memory)
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);
% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);

% Align the imagess
G = circshift(G, align(G,B));
R = circshift(R, align(R,B));


% create a color image (3D array)
% ... use the "cat" command
colorim = cat(3, R, G, B);

% show the resulting image
% ... use the "imshow" command
imshow(colorim);

% save result image
%imwrite(colorim,['output.jpg']);





