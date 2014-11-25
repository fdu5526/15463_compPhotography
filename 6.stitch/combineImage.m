function [finalImage] = combineImage(im1,im2, nLeft)
	sizeIm1 = size(im1);
	sizeIm2 = size(im2);
	midrange = sizeIm1(2) - nLeft;

	% get everything in combined image
	combinedImage = zeros(sizeIm2(1), sizeIm2(2), 3);

	for y = 1:sizeIm2(1)
		for x = 1:sizeIm2(2)
				
			if(y <= sizeIm1(1) & x <= nLeft)
				combinedImage(y,x,:) = im1(y,x,:);

			elseif(y <= sizeIm1(1) & x <= sizeIm1(2))
				if(im2(y,x,1) == 0 & im2(y,x,2) == 0 & im2(y,x,3) == 0)
					combinedImage(y,x,:) = im1(y,x,:);
				else
					ratio = (x - nLeft)/midrange;
					combinedImage(y,x,:) = (1 - ratio)*im1(y,x,:) + ratio*im2(y,x,:);
				end

			else
				combinedImage(y,x,:) = im2(y,x,:);
			end
		end
	end

	finalImage = combinedImage;