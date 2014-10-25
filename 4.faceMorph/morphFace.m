user_name1 = 'syan';
user_name2 = 'tesker';

im1 = imread([ 'pictures\' user_name1 '.JPG' ]);
im2 = imread([ 'pictures\' user_name2 '.JPG' ]);
im1_pts = importdata([ 'data\' user_name1 '.txt' ]);
im2_pts = importdata([ 'data\' user_name2 '.txt' ]);

%%%%%%%%%%%%%%%%%% end initial loading %%%%%%%%%%%%%%%%%%

% delauney points, get middle, compute

average_pts = 0.5*(im1_pts + im2_pts)
computeDelaunay(average_pts)

morphed_im = morph(im1, im2, im1_pts, im2_pts, [], 0.5, 0.5);

size(im1_pts)
%imshow(morphed_im)
