function [output] = morph(im1, im2, im1_pts, im2_pts, tri, warp_frac, dissolve_frac)
	computeAffine([],[]);
	output = 0.5 * im1 + 0.5 * im2;



function [output] = computeAffine(tri1_pts,tri2_pts)
	% mytsearch, interp2
	output = [];