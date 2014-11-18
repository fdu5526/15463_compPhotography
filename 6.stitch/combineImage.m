function [finalImage] = combineImage(im1,im2,offset)
	combinedSize = size(im1) + offset + size(im2);

	% get everything in combined image
	combinedImage = zeros(combinedSize(1), combinedSize(2), 3);
	for y = 1:combinedImage(1)
		for x = 1:combinedImage(2)


		end
	end

	finalImage = [];