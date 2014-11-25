function[output] = computeH2(X1, Y1, D1, X2, Y2, D2)

	rng(1);
	% set up me some parameters
	threshold = 0.4;
	ransacCount = 10000;

	% get info, make data structure
	numPoints = size(X1,1);
	d1Tod2Match = zeros(numPoints, 1);

	% for finding maches
	d2Selected = zeros(numPoints,1);
	numSelected = 0;

	i = 1;
	% loop through D1, find matching
	while(i <= numPoints & numSelected < numPoints)

		% keep track 2 of the best
		bestd = 2000000; bestj = 0;
		best2d = 2000000; best2j = 0;	

		% loop through D2
		for j = 1:numPoints

			% already matched, skip
			if(d2Selected(j) == 1)
				continue;
			end

			% compute distance
			d1 = D1{i}(:)';
			d2 = D2{j}(:)';
			dist = dist2(d1, d2);

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
	bestH = 0;
	bestMatchDist = 9000000000;

	bestPoints = cell(2);

	while(i <= ransacCount)

		% get matches
		index = randperm(numMatch);
		matches = d1Tod2Match(index(1:4));

		% get homography
		p1 = [X1(index(1)),Y1(index(1));
					X1(index(2)),Y1(index(2));
					X1(index(3)),Y1(index(3));
					X1(index(4)),Y1(index(4));
				];
		p2 = [X2(matches(1)),Y2(matches(1));
					X2(matches(2)),Y2(matches(2));
					X2(matches(3)),Y2(matches(3));
					X2(matches(4)),Y2(matches(4));
				];
		H = computeH(p1,p2);

		% compute how this homography does with all other points
		dist = 0;
		for j = 1:numMatch
			x1 = X1(j); y1 = Y1(j);
			x2 = X2(d1Tod2Match(j)); y2 = Y2(d1Tod2Match(j));

			% calculate homographied point
			pp1 = [x1;y1;1];
			pp2h = H * pp1;
			pp2h = pp2h / pp2h(3);

			% actual point
			pp2 = [x2;y2;1];

			dist = dist + dist2(pp2h', pp2');

		end

		% found better match
		if(dist < bestMatchDist)
			bestH = H;
			bestMatchDist = dist;


			bestPoints{1} = p1;
			bestPoints{2} = p2;
		end

		i = i + 1;
	end
	

	output = bestPoints;
end