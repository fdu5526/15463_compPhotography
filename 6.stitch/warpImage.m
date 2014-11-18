function [imwarped] = warpImage(im,H)
	
	invH = inv(H);

	sizeIm = size(im);
	%newSize = computeNewSize(sizeIm, invH);
	newSize = sizeIm;
	imCoords = ones(newSize(1), newSize(2), 3);

	

	for y = 1:newSize(1)
		for x = 1:newSize(2)

			p = [x; y; 1];
			origp = invH * p;
			origp = origp / origp(3);

			%if(sizeIm(1) >= origp(2) & origp(2) >= 1 & sizeIm(2) >= origp(1) & origp(1) >= 1)
				imCoords(y, x, :) = origp;
			%end
		end
	end


	r = interp2(1:newSize(2), 1:newSize(1), im(:,:,1), imCoords(:,:,1), imCoords(:,:,2));
	g = interp2(1:newSize(2), 1:newSize(1), im(:,:,2), imCoords(:,:,1), imCoords(:,:,2));
	b = interp2(1:newSize(2), 1:newSize(1), im(:,:,3), imCoords(:,:,1), imCoords(:,:,2));


	imwarped = cat(3, r, g, b);
end



function [newSize] = computeNewSize(sizeIm,invH)
	topLeft = invH * [1; 1; 1];
	topLeft = topLeft / topLeft(3);
	topRight = invH * [1; sizeIm(2); 1];
	topRight = topRight / topRight(3);
	botLeft = invH * [sizeIm(1); 1; 1];
	botLeft = botLeft / botLeft(3);
	botRight = invH * [sizeIm(1); sizeIm(2); 1];
	botRight = botRight / botRight(3);

	maxHeight = max(topLeft(2), topRight(2)) - min(botLeft(2), botRight(2));
	maxwidth = max(topRight(1), botRight(1)) - min(botLeft(1), topLeft(1));


	newSize = [maxwidth, maxHeight];
end
