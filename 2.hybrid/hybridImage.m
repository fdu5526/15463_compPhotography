function [img] = hybridImage(im1, im2, cutoff_low, cutoff_high)
	g = fspecial('gaussian', [10, 10], 10)
	img = imfilter(im1, g,'same');
	



