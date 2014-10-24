user_name = 'syan';

im = imread([ 'data\' user_name '.JPG' ]);
imshow(im);

uiwait(msgbox({ 'Left click to place the next point', ...
                'Right click to delete the previous point', ...
                'Results will be automatically saved after all 43 points are entered', ...
                'Note: Right clicking does not always work, MATLAB is weird' }));

i = 1;
points = zeros(43, 2);
handles = zeros(43, 2);
while i <= 43
    [x,y,button] = ginput(1);
    % right click to delete previous point
    if button == 3
        i = i - 1;
        delete(handles(i, :));
    else
        hold on;
        handles(i, 1) = plot(x,y,'r.', 'MarkerSize', 10);
        handles(i, 2) = text(x,y,int2str(i),'VerticalAlignment','bottom',...
                                            'HorizontalAlignment','right');
        points(i, :) = [ x y ];
        i = i + 1;
    end
end
dlmwrite([ user_name '.txt' ], points);

msgbox([ 'Done! Points saved to ' user_name '.txt' ]);