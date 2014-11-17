function [output] = computeAffine(tri1_pts,tri2_pts)
	x1 = tri1_pts(1);
	y1 = tri1_pts(2);
	x2 = tri1_pts(3);
	y2 = tri1_pts(4);
	x3 = tri1_pts(5);
	y3 = tri1_pts(6);

	A = [[x1,y1, 1, 0, 0, 0],
			 [0, 0, 0, x1,y1, 1],
			 [x2,y2, 1, 0, 0, 0],
			 [0, 0, 0, x2,y2, 1],
			 [x3,y3, 1, 0, 0, 0],
			 [0, 0, 0, x3,y3, 1]];
	output = inv(A) * tri2_pts;