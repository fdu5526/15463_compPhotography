user_name1 = 'syan';
user_name2 = 'tesker';

im1 = imread([ 'pictures\' user_name1 '.JPG' ]);
im2 = imread([ 'pictures\' user_name2 '.JPG' ]);
im1_pts = importdata([ 'data\' user_name1 '.txt' ]);
im2_pts = importdata([ 'data\' user_name2 '.txt' ]);

%%%%%%%%%%%%%%%%%% end initial loading %%%%%%%%%%%%%%%%%%



morphed_im = morph(im1, im2, im1_pts, im2_pts, [], 0.5, 0.5);


%imshow(morphed_im)
