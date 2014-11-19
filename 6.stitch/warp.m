im1 = im2double(imread('images/lib1.JPG'));
im2 = im2double(imread('images/lib2.JPG'));

im1_pts = [528,166;
					 317,135;
					 295,580;
					 724,485;
					 848,404];

im2_pts = [381,132;
					 151,76;
					 99,551;
					 554,463;
					 672,391];

%H = computeH(im1_pts,im2_pts);
%warpOut = warpImage(im2,H);

%imwarped = warpOut{1};
%xOff = warpOut(2);
%yOff = warpOut(3);


imwarped = im2double(imread('temp.PNG'));


% how large overall image should be
xOff = 0;
yOff = 0;
offset = [im1_pts(1,:) - im2_pts(1,:), 0];
combinedImage = combineImage(im1, imwarped, offset, xOff, yOff);

imshow(combinedImage);