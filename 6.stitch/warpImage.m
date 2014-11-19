function [imwarped] = warpImage(im,H)
	
	invH = inv(H);

	sizeIm = size(im);
	newSize = computeNewSize(sizeIm, H);
	imCoords = zeros(newSize(1), newSize(2), 3);


	for y = 1:newSize(1)
		for x = 1:newSize(2)

			p = [x; y; 1];
			origp = invH * p;
			origp = origp / origp(3);

			origp(2) = origp(2) + newSize(4);
			origp(1) = origp(1) + newSize(3);

			%if(sizeIm(1) >= origp(2) & origp(2) >= 1 & sizeIm(2) >= origp(1) & origp(1) >= 1)
				imCoords(y, x, :) = origp;
			%end
		end
	end


	r = interp2(1:sizeIm(2), 1:sizeIm(1), im(:,:,1), imCoords(:,:,1), imCoords(:,:,2));
	g = interp2(1:sizeIm(2), 1:sizeIm(1), im(:,:,2), imCoords(:,:,1), imCoords(:,:,2));
	b = interp2(1:sizeIm(2), 1:sizeIm(1), im(:,:,3), imCoords(:,:,1), imCoords(:,:,2));

	imwarped = cat(3, r, g, b);
end



function [newSize] = computeNewSize(sizeIm,H)
	topLeft = H * [1; 1; 1];
	topRight = H * [sizeIm(2); 1; 1];
	botLeft = H * [1; sizeIm(1); 1];
	botRight = H * [sizeIm(2); sizeIm(1); 1];
	
	topLeft = topLeft / topLeft(3);
	topRight = topRight / topRight(3);
	botLeft = botLeft / botLeft(3);
	botRight = botRight / botRight(3);

	cornersY = [topLeft(2), topRight(2), botLeft(2), botRight(2)]
	cornersX = [topLeft(1), topRight(1), botLeft(1), botRight(1)]

	maxHeight = round(max(cornersY) - min(cornersY))
	maxwidth = round(max(cornersX) - min(cornersX))

	newSize = [maxHeight, maxwidth, min(cornersX), min(cornersY)];
end
