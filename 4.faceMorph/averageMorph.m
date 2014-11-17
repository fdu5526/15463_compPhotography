function [output] = averageMorph(imgs, img_pts, average_pts, tri)
	
	finalImage = zeros(size(imgs{1}));

	for u = 1:size(imgs, 2)

		im1 = imgs{u};
		im1_pts = img_pts{u};

		% get cells of affine matrices
		affines1 = cell(1,size(tri,1));

		for i = 1:(size(tri,1))
			im1_tri = [im1_pts(tri(i,1), 1), 
								 im1_pts(tri(i,1), 2),
								 im1_pts(tri(i,2), 1), 
								 im1_pts(tri(i,2), 2),
								 im1_pts(tri(i,3), 1), 
								 im1_pts(tri(i,3), 2)];
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
		end

		% apply inverse interpolation
		finalImage = finalImage + (1/size(imgs, 2)) * computeWarp(im1, average_pts, tri, affines1);
	end

	output = finalImage;