% MPA-AB2 Lecture 4
clear,clc,close
%% call our algorithm for depth calculation
path = "V:\MPA-AB2\Lecture4_23\Data";
[depthMaps] = compute_depth(path);
%% evaluate results
[MAE, percantageMissing, details] = evaluateReconstruction(depthMaps);
%% create 3D view 
% load image
colorImage = imread(strcat(path,'\im1\im0.png'));
% we have to obtain the camera info
calibInfoFile = fopen(strcat(path,'\im1\calib.txt'),'r');
calibCode = textscan(calibInfoFile,'%s','delimiter','\n');
fclose(calibInfoFile);
    for j = 1:length(calibCode{1})
        eval(strcat(calibCode{1}{j},';'))
    end
focalLength = [cam0(1,1), cam0(1,1)];
principalPoint = [cam0(1,3),cam0(2,3)];

intrinsics = cameraIntrinstics(focalLength,principalPoint,size(depthMaps{2},[1,2]));
% then create a pointCloud object
ptCloud = pcfromdepth(depthMaps{2},1,intrinsics,ColorImage=colorImage);%, 'Color', frameLeftRect

% Visualize the point cloud
pcshow(ptCloud,VerticalAxis='Y', VerticalAxisDir='Up', ViewPlane='YX')