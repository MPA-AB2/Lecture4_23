function [depth_im] = calculate_disparity_map(im1, im2, config)

siz = size(im1);
a = siz(1)/4;
b = siz(2)/4;
I1 = rgb2gray(imresize(im1,[a b]));
I2 = rgb2gray(imresize(im2,[a b]));
disparityRange = [0 64];
disparityMap = disparitySGM(I1,I2,"DisparityRange",disparityRange,"UniquenessThreshold",5);
% figure
% imshow(disparityMap,disparityRange)
% title('Disparity Map')
% colormap jet
% colorbar

calibr = nacteni_txt(config);
x = str2num(calibr(1,2));
f = x(1,1); %% z text
baseline = str2num(calibr(4,2));
ndisp = str2num(calibr(7,2));

distM = disparityMap + ndisp;
depth_im = baseline*f./distM;
depth_im(isnan(depth_im)) = 0;
depth_im(isinf(depth_im)) = 0;
depth_im = imresize(depth_im,siz(1:2));

%figure;subplot 211;imshow(depth_im,[]);subplot 212;imshow(disparityMap,disparityRange);

end