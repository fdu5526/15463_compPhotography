usernames = {'abueno','apenugon','awdavis','bengyenc','caddiego','caryy','changshl','coryc','jsandfor','kaidiy','kku','mchoquet','namhoonl','nhrubin','njacob','pauldavi','raiginin','stkwan','syan','tesker','yuyangg','zhizhonl'};


images = {};
points = {};

for i = 1:size(usernames,2)
	images{i} = im2double(imread([ 'pictures\' usernames{i} '.JPG' ]));
	points{i} = [importdata([ 'data\' usernames{i} '.txt' ]), 
					 			[1.0 1.0],
					 			[1.0 960.0],
 					 			[1280.0 1.0],
					 			[1280.0 960.0]];
end
%%%%%%%%%%%%%%%%%% end initial loading %%%%%%%%%%%%%%%%%%


average_pts = points{1};
for i = 2:size(points,2)
	average_pts = average_pts + points{i};
end

average_pts = average_pts / (size(points, 2));
triangles = delaunay(average_pts(:, 1), average_pts(:, 2));


for i = 1:size(usernames,2)

	for p = 1:size(points, 2)
		for x = 1:7
			for y = 1:7
				images{i}(uint32(points{i}(p,2))+x, uint32(points{i}(p,1))+y, :) = [1.0, 0, 0];
			end
		end
	end
	imwrite(images{i}, [ usernames{i} '.JPG' ]);
end

% saves average face
%morphed_im = averageMorph(images, points, average_pts, triangles);
%imwrite(morphed_im, [ 'output/average.JPG' ]);

% me to average
%morphed_im = warpMeToAverage(images{19} ,points{19},average_pts,triangles);
%imwrite(morphed_im, [ 'output/syan2average.JPG' ]);

% average to me
%morphed_im = warpMeToAverage(im2double(imread([ 'output\average.JPG'])), average_pts,points{19},triangles);
%imwrite(morphed_im, [ 'output/average2syan.JPG' ]);




