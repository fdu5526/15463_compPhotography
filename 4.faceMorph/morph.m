function [output] = morph(im1, im2, im1_pts, im2_pts, tri, warp_frac, dissolve_frac)
	computeAffine([],[]);
	output = [];




function [output] = computeAffine(tri1_pts,tri2_pts)
	output = [];