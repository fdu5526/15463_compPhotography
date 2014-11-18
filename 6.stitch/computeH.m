function [H] = computeH(im1_pts,im2_pts)
	%https://stackoverflow.com/questions/16345656/homography-matrix-for-image-stitching-in-matlab

	n = size(im1_pts, 1); 
  A = zeros(n*2,8); 
  b = zeros(n*2,1); 
  j=1;
  for i=1:n
      A(j,:)=[im2_pts(i,1), im2_pts(i,2), 1, 0, 0, 0, -im1_pts(i,1)*im2_pts(i,1), -im1_pts(i,1)*im2_pts(i,2)];
      b(j,1)=im1_pts(i,1);
      j=j+1;
      A(j,:)=[0, 0, 0, im2_pts(i,1), im2_pts(i,2), 1, -im1_pts(i,2)*im2_pts(i,1), -im1_pts(i,2)*im2_pts(i,2)];
      b(j,1)=im1_pts(i,2);
      j=j+1;
  end

  x = (A\b);
  H = [x(1,1), x(2,1), x(3,1);
       x(4,1), x(5,1), x(6,1);
       x(7,1), x(8,1), 1];
 