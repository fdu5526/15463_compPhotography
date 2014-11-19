function [finalImage] = combineImage(im1,im2,offset, Xoff, yOff)
	sizeIm1 = size(im1);
	sizeIm2 = size(im2);

	combinedXSize = sizeIm1(2) + offset(1) + sizeIm2(2);
	combinedYSize = max(sizeIm1(1), sizeIm2(1));


	% get everything in combined image
	combinedImage = zeros(combinedYSize, combinedXSize, 3);
	

	for y = 1:combinedYSize
		for x = 1:combinedXSize
			
			if(x <= sizeIm1(2) & y <= sizeIm1(1) & y <= sizeIm1(1))
				combinedImage(y,x,:) = im1(y,x,:);
			elseif(x - sizeIm1(2) <= sizeIm2(2) & y <= sizeIm2(1))
				combinedImage(y,x,:) = im2(y,x - sizeIm1(2),:);
			end

		end
	end

	finalImage = combinedImage;