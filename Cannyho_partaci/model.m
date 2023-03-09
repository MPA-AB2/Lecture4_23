im = imread('im0.png');

depth = depthMaps{1,2};

%depth is depth image in double format
Sd = size(depth);
[X,Y] = meshgrid(1:Sd(2),1:Sd(1));

K = str2num(calibration{1,2});

%K is calibration matrix
X = X - K(1,3) + 0.5;
Y = Y - K(2,3) + 0.5;
XDf = depth/K(1,1);
YDf = depth/K(2,2);
X = X .* XDf;
Y = Y .* YDf;
XY = cat(3,X,Y);
cloud = cat(3,XY,depth);

cloud = pointCloud(cloud,'Color',im);
pcshow(cloud);
title('Point Cloud'); xlabel('X'); ylabel('Y'); zlabel('Z');
