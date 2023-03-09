clc; clear all; close all;
%% nacteni
im1 = imread("Data\im1\im0.png");
im2 = imread("Data\im1\im1.png");
calibr = readtable("Data\im1\calib.txt");
%% podvzorkovani + mapa
siz = size(im1);
a = siz(1)/4;
b = siz(2)/4;
I1 = rgb2gray(imresize(im1,[a b]));
I2 = rgb2gray(imresize(im2,[a b]));
disparityRange = [0 64];
disparityMap = disparitySGM(I1,I2,"DisparityRange",disparityRange,"UniquenessThreshold",5);
figure
imshow(disparityMap,disparityRange)
title('Disparity Map')
colormap jet
colorbar
% %%
% I1_v = rgb2gray(im1);
% I2_v = rgb2gray(im2);
% disparityRange = [0 64];
% disparityMap = disparitySGM(I1,I2,"DisparityRange",disparityRange,"UniquenessThreshold",5);
% figure
% imshow(disparityMap,disparityRange)
% title('Disparity Map')
% colormap jet
% colorbar


%%
fileName = '<your full file path here>'
% my sample text contains ---> apple, baseball, car, donut, & elephant in single column.
FID = fopen(fileName);
data = textscan(FID,'%s');
fclose(FID);
stringData = string(data{:});


%%
calibr = nacteni_txt(cesta_calib);
size_depth = size(I1);
x = str2num(calibr(1,2));
f = x(1,1); %% z text
baseline = str2num(calibr(4,2));
ndisp = str2num(calibr(7,2));

distM = disparityMap + ndisp;
depth_im = baseline*f./disparityMap;
depth_im(isnan(depth_im)) = 0;
depth_im = imresize(depth_im,siz(1:2));
%figure;subplot 211;imshow(depth_im2,[]);subplot 212;imshow(disparityMap,disparityRange);
%for i=1:size_depth(1)