clc; clear all; close all;
%% nacteni
im1 = imread("Data\im1\im0.png");
im2 = imread("Data\im1\im1.png");
calibr = readtable("Data\im1\calib.txt");
%% podvzorkovani + mapa
siz = size(im1);
a = siz(1)/2;
b = siz(2)/2;
I1 = rgb2gray(imresize(im1,[a b]));
I2 = rgb2gray(imresize(im2,[a b]));
disparityRange = [0 64];
disparityMap = disparitySGM(I1,I2,"DisparityRange",disparityRange,"UniquenessThreshold",5);
figure
imshow(disparityMap,disparityRange)
title('Disparity Map')
colormap jet
colorbar
%%
I1_v = rgb2gray(im1);
I2_v = rgb2gray(im2);
disparityRange = [0 64];
disparityMap = disparitySGM(I1,I2,"DisparityRange",disparityRange,"UniquenessThreshold",5);
figure
imshow(disparityMap,disparityRange)
title('Disparity Map')
colormap jet
colorbar