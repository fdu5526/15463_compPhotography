function [output] = computeWarp(im, average_pts, tri, affines)

	% for each point in image, get which triangle it is in, affine transform
	% want to use average im points here
	% apply inverse affine transform, get that point

	[X,Y] = meshgrid(1:size(im,1),1:size(im,2));
	triIndices = mytsearch(average_pts(:,1),average_pts(:,2),tri,Y,X);
	

	% get coordinates to be mapped to for new image
	imCoords = zeros(size(im, 1), size(im, 2), 3);
	for y = 1:size(im, 1)
		for x = 1:size(im, 2)
			if(isnan(triIndices(x,y)))
				imCoords(y, x, :) = [x,
				 										 y,
					 									 1];
				continue
			end
			% get the triangle's affine transformation
			affine = affines{triIndices(x,y)};
			
			p = [x,
					 y,
					 1];
			origp = affine * p;
			origp = origp / origp(3);

			imCoords(y, x, :) = origp;
		end
	end

	r = interp2(1:size(im,2), 1:size(im,1), im(:,:,1), imCoords(:,:,1), imCoords(:,:,2));
	g = interp2(1:size(im,2), 1:size(im,1), im(:,:,2), imCoords(:,:,1), imCoords(:,:,2));
	b = interp2(1:size(im,2), 1:size(im,1), im(:,:,3), imCoords(:,:,1), imCoords(:,:,2));

	output = cat(3, r, g, b);