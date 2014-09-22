function [img] = hybridImage(im1, im2, cutoff_low, cutoff_high)
	g = fspecial('gaussian', [10, 10], 10)
	
	img1 = imfilter(im1, g,'same');
	img2 = im2 - imfilter(im2, g,'same');

	for i = 1:size(img1, 1)
    for j = 1:size(img1, 2)
      img(i,j) = img1(i,j) + img2(i,j);
    end
  end