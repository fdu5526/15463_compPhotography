function [output] = morph(im1, im2, im1_pts, im2_pts, tri, warp_frac, dissolve_frac)
	
	im1_2 = im1;
	im2_2 = im2;

	for i = 1:(size(tri,1))
		im1_tri = [im1_pts(tri(i,1), 1), 
							 im1_pts(tri(i,1), 2),
							 im1_pts(tri(i,2), 1), 
							 im1_pts(tri(i,2), 2),
							 im1_pts(tri(i,3), 1), 
							 im1_pts(tri(i,3), 2)];
		im2_tri = [im2_pts(tri(i,1), 1), 
							 im2_pts(tri(i,1), 2),
							 im2_pts(tri(i,2), 1), 
							 im2_pts(tri(i,2), 2),
							 im2_pts(tri(i,3), 1), 
							 im2_pts(tri(i,3), 2)];

		average_tri = (1 - dissolve_frac) * im1_tri + dissolve_frac * im2_tri;

		affine1 = computeAffine(im1_tri, average_tri);
		affine2 = computeAffine(im2_tri, average_tri);
		
		
		% mytsearch, interp2

	end


	output = (1 - dissolve_frac) * im1_2 + dissolve_frac * im2_2;



function [output] = computeAffine(tri1_pts,tri2_pts)
	A = [[tri1_pts(1),tri1_pts(2), 1, 0, 0, 0],
			 [0, 0, 0, tri1_pts(1),tri1_pts(2), 1],
			 [tri1_pts(3),tri1_pts(4), 1, 0, 0, 0],
			 [0, 0, 0, tri1_pts(3),tri1_pts(4), 1],
			 [tri1_pts(5),tri1_pts(6), 1, 0, 0, 0],
			 [0, 0, 0, tri1_pts(5),tri1_pts(6), 1]];
	output = inv(A) * tri2_pts;