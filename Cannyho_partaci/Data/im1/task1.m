clc; clear all;
image_2 = imread('im1.png');
image_1 = imread('im0.png');

info = readcell('calib.txt');
focal_length = str2num(info{1,2});
focal_length = focal_length(1,1);
baseline = info{4,2};
doff = info{3,2};

%64,240

J1 = rgb2gray(image_1);
J2 = rgb2gray(image_2);
l = 1;
for t = 8:8:128
    if t > 16
disparity_Range = [0 t];

disparityMap = disparitySGM(J1,J2,'DisparityRange',disparity_Range,'UniquenessThreshold',10);
figure(1)
subplot(4,4,l)
l = l+1;
imshow(disparityMap,disparity_Range)
title('Disparity Map')
colormap jet
colorbar
    end
end

%% depth
[rows cols] = size(disparityMap);
depth = zeros(rows,cols);
disparityMap_doff = disparityMap+doff;
depth(:,:) = focal_length*baseline;
depth_map = depth./disparityMap_doff;

figure(17)
imshow(depth_map,[])
colormap jet
colorbar 
title('Depth Map')
