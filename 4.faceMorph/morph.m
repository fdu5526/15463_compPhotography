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

		affines1{i} = computeAffine(average_tri, im1_tri);
		affines2{i} = computeAffine(average_tri, im2_tri);
	end

	% apply inverse interpolation
	im1_2 = computeWarp(im1, average_pts, tri, affines1);
	im2_2 = computeWarp(im2, average_pts, tri, affines2);

	% cross correlate, return
	output = im1_2;
	%output = (1 - dissolve_frac) * im1_2 + dissolve_frac * im2_2;



function [output] = computeWarp(im, average_pts, tri, affines)

	% for each point in image, get which triangle it is in, affine transform
	% want to use average im points here
	% apply inverse affine transform, get that point

	pointPairs = meshgrid(1:size(im,1),1:size(im,2));
	triIndices = mytsearch(average_pts(:,1),average_pts(:,2),tri,pointPairs,pointPairs);
	

	imResult = zeros(size(im));
	for y = 1:size(im, 1)
		for x = 1:size(im, 2)


			% get the triangle's affine transformation
			affine = affines{triIndices(x,y)};
			affine = [[affine(1), affine(2), affine(3)],
								[affine(4), affine(5), affine(6)],
								0,0,1];
			
			p = [x,
					 y,
					 1];
			origp = affine * p;
			origp = origp / (origp(3));

			p
			origp
			% TODO want to interp2 here
			%ny = min(max(1, uint32(origp(2))), size(im,1));
			%nx = min(max(1, uint32(origp(1))), size(im,1));
			ny = uint32(origp(2));
			nx = uint32(origp(1));
			imResult(y,x,:) = im(ny, nx,:);

		end
	end

	output = imResult;

function [output] = computeAffine(tri1_pts,tri2_pts)
	x1 = tri1_pts(1);
	y1 = tri1_pts(2);
	x2 = tri1_pts(3);
	y2 = tri1_pts(4);
	x3 = tri1_pts(5);
	y3 = tri1_pts(6);

	A = [[x1,y1, 1, 0, 0, 0],
			 [0, 0, 0, x1,y1, 1],
			 [x2,y2, 1, 0, 0, 0],
			 [0, 0, 0, x2,y2, 1],
			 [x3,y3, 1, 0, 0, 0],
			 [0, 0, 0, x3,y3, 1]];
	output = inv(A) * tri2_pts;