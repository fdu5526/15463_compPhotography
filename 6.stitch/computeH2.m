function[output] = computeH2(x1, y1, d1, x2, y2, d2)

	% set up me some parameters
	threshold = 0.4;
	ransacCount = 3;

	% get info, make data structure
	numPoints = size(x1,1);
	d1Tod2Match = zeros(numPoints, 1);

	% for finding maches
	d2Selected = zeros(numPoints,1);
	numSelected = 0;

	i = 1;
	% loop through d1, find matching
	while(i <= numPoints & numSelected < numPoints)

		% keep track 2 of the best
		bestd = 2000000; bestj = 0;
		best2d = 2000000; best2j = 0;	

		% loop through d2
		for j = 1:numPoints

			% already matched, skip
			if(d2Selected(j) == 1)
				continue;
			end

			% compute distance
			dd1 = d1{i}(:)';
			dd2 = d2{j}(:)';
			dist = dist2(dd1, dd2);

			% found a better best matching
			if(dist < bestd)
				best2d = bestd;
				best2j = bestj;
				bestd = dist;
				bestj = j;
			end
		end

		% good enough
		if(best2d ~= 2000000 & (bestd/best2d) < threshold)
			d2Selected(bestj) = 1;
			numSelected = numSelected + 1;
			d1Tod2Match(i) = bestj;
		end

		i = i + 1;
	end

	% remove zeros
	d1Tod2Match(d1Tod2Match == 0) = [];
	numMatch = size(d1Tod2Match, 1);

	% ransac, find homography
	i = 1;
	while(i <= ransacCount)
		index = randperm(numMatch);
		matches = d1Tod2Match(index(1:4));


		i = i + 1;
	end
	

	output = [];
end