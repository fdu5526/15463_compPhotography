% allign the 1st image to fit the 2nd image
function [shift] = align(i1, i2)
	
	% get size of image
	h = size(i1,1);
	w = size(i1,2);
	bestShift = [0,0];

	if(w > 128)
		bestShift = align(imresize(i1, 0.5), imresize(i2, 0.5))*2;
		i1 = circshift(i1, bestShift);
	end

	% get images with edges shaved off
	cutoff = 15.0;
	hcut = round(h*10.0/100.0);
	wcut = round(w*10.0/100.0);
	i1p = i1(hcut:(h-hcut),wcut:(w - wcut));
	i2p = i2(hcut:(h-hcut),wcut:(w - wcut));

	% base case
	minDiff = Inf;
	bestCurrentShift = [0,0];

	% establish range
	for x = -5:5
		for y = -5:5

			% shift here
			i = circshift(i1p, [x,y]);

			d = findDifference(i, i2p);
			% found a better fit
			if(d < minDiff)
				minDiff = d;
				bestCurrentShift = [x,y];
			end
		end
	end

	shift = bestShift + bestCurrentShift;
	

% difference between images
function [diff] = findDifference(i1, i2)
	diff = sum(sum((i1 - i2).^2));
	%diff = sum(sum((norm(i1) - norm(i2)).^2));
	%diff = dot(norm(i1), norm(i2));