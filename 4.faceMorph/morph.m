function [output] = morph(im1, im2, im1_pts, im2_pts, tri, warp_frac, dissolve_frac)
	
	% get cells of affine matrices
	average_pts = (1 - dissolve_frac) * im1_pts + dissolve_frac * im2_pts;

	affines1 = cell(1,size(tri,1));
	affines2 = cell(1,size(tri,1));
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
	 	average_tri = [average_pts(tri(i,1), 1), 
								 	 average_pts(tri(i,1), 2),
								   average_pts(tri(i,2), 1), 
								   average_pts(tri(i,2), 2),
								   average_pts(tri(i,3), 1), 
								   average_pts(tri(i,3), 2)];


	 	affine = computeAffine(average_tri, im1_tri);
		affine = [[affine(1), affine(2), affine(3)],
							[affine(4), affine(5), affine(6)],
								0,0,1];
		affines1{i} = affine;


	 	affine = computeAffine(average_tri, im2_tri);
		affine = [[affine(1), affine(2), affine(3)],
							[affine(4), affine(5), affine(6)],
								0,0,1];
		affines2{i} = affine;
	end

	% apply inverse interpolation
	im1_2 = computeWarp(im1, average_pts, tri, affines1);
	im2_2 = computeWarp(im2, average_pts, tri, affines2);

	% cross correlate, return
	output = (1 - dissolve_frac) * im1_2 + dissolve_frac * im2_2;