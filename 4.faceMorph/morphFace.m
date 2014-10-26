user_name1 = 'syan';
user_name2 = 'tesker';

im1 = im2double(imread([ 'pictures\' user_name1 '.JPG' ]));
im2 = im2double(imread([ 'pictures\' user_name2 '.JPG' ]));
im1_pts = importdata([ 'data\' user_name1 '.txt' ]);
im2_pts = importdata([ 'data\' user_name2 '.txt' ]);

%%%%%%%%%%%%%%%%%% end initial loading %%%%%%%%%%%%%%%%%%

% delauney points for triangles
average_pts = 0.5*(im1_pts + im2_pts);
triangles = delaunay(average_pts(:, 1), average_pts(:, 2));

frameCount = 0;
for i = 0:frameCount
	morphed_im = morph(im1, im2, im1_pts, im2_pts, triangles, i/frameCount, i/frameCount);
end


%imshow(morphed_im)
