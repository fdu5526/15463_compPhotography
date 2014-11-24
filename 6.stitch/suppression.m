function[fx, fy] = suppression(x, y, v)

	numOfData = size(x, 1);

	% sort data
	[vSorted, sortIndex] = sort(v, 'descend');
	xSorted = x(sortIndex);
	ySorted = y(sortIndex);


	% set number of points left over
	N = 100; R = 50;
	nx = zeros(N, 1);
	ny = zeros(N, 1);


	% find the top 10 points
	n = 1; i = 1;
	while(n <= N & i <= numOfData)

		xi = xSorted(i);
		yi = ySorted(i);

		isLocalMax = true;
		% loop through larger points, see if they are close
		for j = 1:(i-1)
			xj = xSorted(j);
			yj = ySorted(j);			

			dx = xi - xj;
			dy = yi - yj;

			% not local max
			if(dx*dx + dy*dy < R)
					isLocalMax = false;
				break;
			end
		end
		
		% this point is local max, add it
		if(isLocalMax)
			nx(n) = xi;
			ny(n) = yi;
			n = n + 1;
		end

		i = i + 1;
	end


	fx = nx;
	fy = ny;
end