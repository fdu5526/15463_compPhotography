user_name1 = 'syan';
user_name2 = 'tesker';
im1 = imread([ 'pictures\' user_name1 '.JPG' ]);
im2 = imread([ 'pictures\' user_name2 '.JPG' ]);

%imshow(im2)



morphed_im = morph(im1, im2, [], [], [], 0.5, 0.5);


