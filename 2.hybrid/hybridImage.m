function [img] = hybridImage(im1, im2, cutoff_low, cutoff_high)
	filterSize = round(size(im1, 1) / 20);
	filterSigma = round(size(im1, 1) / 150);

	g = fspecial('gaussian', [filterSize, filterSize], filterSigma);
	
	img1 = imfilter(im1, g,'same');
	img2 = im2 - imfilter(im2, g,'same');

	for i = 1:size(img1, 1)
    for j = 1:size(img1, 2)
    	for k = 1:size(img1, 3)
      	img(i,j,k) = (img1(i,j,k) + img2(i,j,1));
    	end
    end
  end