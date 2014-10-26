user_name1 = 'syan';
user_name2 = 'tesker';

im1 = im2double(imread([ 'pictures\' user_name1 '.JPG' ]));
im2 = im2double(imread([ 'pictures\' user_name2 '.JPG' ]));
im1_pts = importdata([ 'data\' user_name1 '.txt' ]);
im2_pts = importdata([ 'data\' user_name2 '.txt' ]);


im1_pts = [im1_pts, 
					 [0.0 0.0],
					 [0.0 960.0],
 					 [1280.0 0.0],
					 [1280.0 960.0]];
im2_pts = [im2_pts, 
					 [0.0 0.0],
					 [0.0 960.0],
 					 [1280.0 0.0],
					 [1280.0 960.0]];
%%%%%%%%%%%%%%%%%% end initial loading %%%%%%%%%%%%%%%%%%


% delauney points for triangles
average_pts = 0.5*(im1_pts + im2_pts);
triangles = delaunay(average_pts(:, 1), average_pts(:, 2));

frameCount = 2;
for i = 1:frameCount
	morphed_im = morph(im1, im2, im1_pts, im2_pts, triangles, i/frameCount, i/frameCount);
	imwrite(morphed_im, [ 'blah' int2str(i) '.JPG' ]);
	i
end


%imshow(morphed_im)
