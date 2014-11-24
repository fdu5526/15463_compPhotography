function[output] = descriptorExtraction(x, y, im)

	% set up gaussian filter
	filterSize = round(size(im, 1) / 20);
	filterSigma = round(size(im, 1) / 150);
	g = fspecial('gaussian', [filterSize, filterSize], filterSigma);

	descriptors = cell(size(x,1));
	
	% loop through coordinates
	for i = 1:size(x,1)
		xi = x(i);
		yi = y(i);

		% get 40x40, blur
		patch = im((yi-19):(yi+20), (xi-19):(xi+20));
		patch2 = imfilter(patch, g, 'same');

		% rescale to 8x8
		patch3 = imresize(patch2, 0.2);

		descriptors{i} = patch3;

	end

	output = descriptors;

end