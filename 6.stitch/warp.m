function [done] = warp()

	data = loadOut();
	im1 = data{1};
	im2 = data{2};
	im1_pts = data{3};
	im2_pts = data{4};

	H = computeH(im1_pts,im2_pts);
	warpOut = warpImage(im2,H);
	imwarped = warpOut{1};

	combinedImage = combineImage(im1, imwarped);

	imwrite(combinedImage, 'output/out.JPG');
	done = 0;
end

% for library
function [data] = loadLibrary()
	im1 = im2double(imread('images/lib1.JPG'));
	im2 = im2double(imread('images/lib2.JPG'));
	im1_pts = [528,166;
						 317,135;
						 295,580;
						 724,485;
						 880,123;
						 992,120];

	im2_pts = [381,132;
						 151,76;
						 99,551;
						 554,463;
						 481,137;
						 568,133];
	data = {im1, im2, im1_pts, im2_pts};
end



% for room
function [data] = loadRoom()
	im1 = im2double(imread('images/room1.JPG'));
	im2 = im2double(imread('images/room2.JPG'));
	im1_pts = [553,408;
						 566,221;
						 724,206;
						 768,493];

	im2_pts = [138,423;
						 150,218;
						 337,205;
						 380,485;];



	data = {im1, im2, im1_pts, im2_pts};
end




% for outdoors
function [data] = loadOut()
	im1 = im2double(imread('images/out1.JPG'));
	im2 = im2double(imread('images/out2.JPG'));
	im1_pts = [498,193;
						 515,310;
						 651,321;
						 600,238];

	im2_pts = [237,183;
						 266,312;
						 408,315;
						 352,233];
	data = {im1, im2, im1_pts, im2_pts};
end