function [depthMaps] = compute_depth(path)
%% nacteni dat
depthMaps = cell(1,5);

for i = 1:5
I1 = imread(append(path, '\im', num2str(i), '\im0.png'));
I2 = imread(append(path, '\im', num2str(i), '\im1.png'));
cal = readcell(append(path, '\im', num2str(i), '\calib.txt'));
cam0 = str2num(cal{1,2});
cam1 = str2num(cal{2,2});
b = cal{4,2};
f = cam0(1);
offs = cal{3,2};

%% zpracovani fotek - gray a podvzorkovani
I1 = rgb2gray(I1); %I1 = I1(1:4:end,1:4:end);
I2 = rgb2gray(I2); %I2 = I2(1:4:end,1:4:end);
% A = stereoAnaglyph(I1,I2);
% figure
% imshow(A)
% title('Red-Cyan composite view of the rectified stereo pair image')
%% disparitni mapa - https://www.mathworks.com/help/vision/ref/disparitybm.html?fbclid=IwAR2ct3m86lg8ZPWMsGPF3VWXuipVOOe-BdVfbbr92SXZw0g26SSpFwzL6pM
disparityRange = [0 256];
disparityMap = disparityBM(I1,I2,'DisparityRange',disparityRange,'UniquenessThreshold',1);%,'TextureThreshold', 0.001);
tf = isnan(disparityMap);
disparityMap(tf) = 0;
% disparityRange = [0 128];
% disparityMap = disparitySGM(I1,I2,'DisparityRange',disparityRange);

% J = medfilt2(disparityMap,[4 4]);

% figure(); imshow(disparityMap,disparityRange); title('Disparity Map'); colormap jet; colorbar %zobrazeni

%% hloubkova mapa - prezentace
h = (f*b)./(disparityMap+offs);
tf = isnan(h);
h(tf) = 0;
% figure (); imshow(h,[]); title('Depth'); colormap jet; colorbar %zobrazeni
depthMaps{1,i} = h;

end

end