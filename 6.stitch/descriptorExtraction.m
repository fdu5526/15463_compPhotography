function[output] = descriptorExtraction(x, y, im)

	% set up gaussian filter
	filterSize = round(size(im, 1) / 20);
	filterSigma = round(size(im, 1) / 180);
	g = fspecial('gaussian', [filterSize, filterSize], filterSigma);

	descriptors = cell(size(x,1));
	
	% loop through coordinates
	for i = 1:size(x,1)
		xi = x(i);
		yi = y(i);

		% get 40x40, blur
		patch = im((yi-17):(yi+17), (xi-17):(xi+17));
		patch2 = imfilter(patch, g, 'same');

		% rescale to 8x8
		patch3 = imresize(patch2, 0.2);
		
		% normalize
		m = mean2(patch3);
		s = std2(patch3);
		patch4 = (patch3 - m)/s;

		% add it
		descriptors{i} = patch4;
	end

	output = descriptors;

end