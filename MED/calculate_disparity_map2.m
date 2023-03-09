function [depth_im] = calculate_disparity_map2(im1, im2, config)

siz = size(im1);
% a = siz(1)/4;
% b = siz(2)/4;
I1 = rgb2gray(im1);
I2 = rgb2gray(im2);
disparityRange = [-16 32]; % 0-16
disparityMap = disparitySGM(I1,I2,"DisparityRange",disparityRange,"UniquenessThreshold",1); %1
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
%depth_im(isnan(depth_im)) = 0;
offset = get_offset(depth_im);
% depth_im(:, offset+1:end) = NaN;
depth_im(isinf(depth_im)) = NaN;
depth_im = fillmissing(depth_im,'spline');
figure;subplot 211;imshow(depth_im,[]);subplot 212;imshow(disparityMap,disparityRange);

end