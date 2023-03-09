clear all; close all; clc
oldpath_orig = path;

for i = 1:5
    oldpath = oldpath_orig 
% path(oldpath,'C:\Users\Veronika\Desktop\VUT\magistr\MPA-AB2\cv4\Data\im1')
filename = ['C:\Users\Veronika\Desktop\VUT\magistr\MPA-AB2\cv4\Data\im' num2str(i)];
path(oldpath,filename)
%%
% Load stereo images
left_image = rgb2gray(imread('im0.png'));
right_image = rgb2gray(imread('im1.png'));
imshow(left_image)
disp('filename')

%%
% Compute disparity map using SGMdisparity_range = [0 64];
disparityMap = disparitySGM(left_image, right_image, 'UniquenessThreshold',15);
figure
imshow(disparityMap, []);
title('disparityMap')
colormap jet
colorbar


% Convert disparity map to depth map
data = readcell('calib.txt');
data_pom = str2num(data{1,2});
focal_length = data_pom(1,1);

doff = data{3,2};
baseline = data{4,2};
depth_map = baseline * focal_length ./ double(disparityMap+doff);

% Post-processing pipeline
% depth_map = imfill(depth_map,'holes');
% depth_map = edgeAwareSmoothing(depth_map);
% depth_map = normalizeDepth(depth_map, depth_gt_range);


%%
J = medfilt2(depth_map,[3 3]);

%%
subplot (221)
imshow(depth_map, []);
title('depth')
colormap jet
colorbar
subplot(222)
imshow(J,[])
title('med')
colormap jet
colorbar
subplot(223)
imshow(disparityMap, []);
title('disparityMap')
colormap jet
colorbar
%%
depthMaps{1,i} = depth_map;
end

%% 
imshow(depthMaps{1,2})

%%
path(oldpath_orig,'C:\Users\Veronika\Desktop\VUT\magistr\MPA-AB2\cv4')
[MAE, percantageMissing, details] = evaluateReconstruction(depthMaps)
