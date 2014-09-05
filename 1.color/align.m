function [finalImage] = align(i1, i2)
	% Functions that might be useful to you for aligning the images include: 
	% "circshift", "sum", and "imresize" (for multiscale)
	minDiff = Inf;
	fi = i1;

	for x = -15:15
		for y = -15:15

			% TODO shift here
			i1p = circshift(i1, [x,y]);

			d = findDifference(i1p, i2);
			% found a better fit
			if(d < minDiff)
				minDiff = d;
				fi = i1p;
			end

		end
	end


	finalImage = fi;
	


function [diff] = findDifference(i1, i2)
	diff = sum(sum((i1 - i2).^2));