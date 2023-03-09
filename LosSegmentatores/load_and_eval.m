% MPA-AB2 Lecture 4
clear,clc,close
%% call our algorithm for depth calculation
path = "V:\MPA-AB2\Lecture4_23\Data";
[depthMaps] = compute_depth(path);
%% evaluate results
[MAE, percantageMissing, details] = evaluateReconstruction(depthMaps);
%% create 3D surface 
% we have to obtain the coordinate matrix

% then create a pointCloud object
ptCloud = pointCloud(points3D);%, 'Color', frameLeftRect

% Create a streaming point cloud viewer
% player3D = pcplayer([-3, 3], [-3, 3], [0, 8], 'VerticalAxis', 'y', ...
%     'VerticalAxisDir', 'down');

% Visualize the point cloud
% view(player3D, ptCloud);
pcshow(ptCloud)