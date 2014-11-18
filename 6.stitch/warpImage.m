function [imwarped] = warpImage(im,H)
	
	sizeIm = size(im);
	imNew = zeros(sizeIm(1), sizeIm(2), sizeIm(3));

	for y = 1:sizeIm(1)
		for x = 1:sizeIm(2)
			p = [x,
					 y,
					 1];
			newP = p;
			newP = newP / newP(3);

			nx = round(newP(1));
			ny = round(newP(2));

			% TODO make this real
			%if (sizeIm(2) >= nx & nx >= 1 & sizeIm(1) >= nx & nx >= 1)
				imNew(ny, nx, :) = im(y ,x ,:);
			%end

		end
	end


	imwarped = 1/256 * imNew;