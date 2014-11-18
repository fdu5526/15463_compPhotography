function [imwarped] = warpImage(im,H)
	
	invH = inv(H);

	sizeIm = size(im);
	imCoords = zeros(sizeIm(1), sizeIm(2), sizeIm(3));

	for y = 1:sizeIm(1)
		for x = 1:sizeIm(2)

			p = [x,
					 y,
					 1];
			origp = invH * p;
			origp = origp / origp(3);

			imCoords(y, x, :) = origp;
		end
	end


	r = interp2(1:sizeIm(2), 1:sizeIm(1), im(:,:,1), imCoords(:,:,1), imCoords(:,:,2));
	g = interp2(1:sizeIm(2), 1:sizeIm(1), im(:,:,2), imCoords(:,:,1), imCoords(:,:,2));
	b = interp2(1:sizeIm(2), 1:sizeIm(1), im(:,:,3), imCoords(:,:,1), imCoords(:,:,2));


	imwarped = cat(3, r, g, b);