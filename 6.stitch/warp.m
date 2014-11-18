im1 = im2double(imread('images/lib1.JPG'));
im2 = im2double(imread('images/lib2.JPG'));

im1_pts = [528,166;
					 317,135;
					 295,580;
					 724,485;
					 848,404
					];

im2_pts = [318,132;
					 151,76;
					 99,551;
					 554,463;
					 672,391
					];

H = computeH(im1_pts,im2_pts);
imwarped = warpImage(im2,H);

imshow(imwarped);


% how large overall image should be
%offset = [im1_pts(1,:) - im2_pts(1,:), 0];
%combinedImage = combineImage(im1, im2, offset);

%imshow(combinedImage);