function [depthMaps] = compute_depth(path)
oldPath = cd;

path = path;
cd(path)

folderNames = ls;
folderNames = folderNames(3:end,:);
cd(oldPath)


depthMaps = cell(size(folderNames,1),1);


for i=1:size(folderNames,1)
    cd([path,'\',folderNames(i,:)])
    
im0 = imread('im0.png');
im1 = imread('im1.png');

calib = importdata('calib.txt') ;  

% Loading the needed params from calib.txt file
f = calib{1,1};
f = str2double(f(7:14));

doffs = calib{3,1};
doffs = str2double(doffs(7:end));

b = calib{4,1};
b = str2double(b(10:end));

% Read in the left and right stereo images
left_image = im0;
right_image = im1;

% Convert the images to grayscale
left_gray = rgb2gray(left_image);
right_gray = rgb2gray(right_image);


% Compute the disparity map using block matching
disparity_range = [0 256];
block_size = 25;
% contrast_threshold = 1;
texture_threshold  = 0.01;

disparity_map = disparityBM(left_gray, right_gray, 'BlockSize', block_size, 'DisparityRange', ...
    disparity_range, 'TextureThreshold', texture_threshold);

depthMaps{i,1} = (f*b)./((disparity_map)+doffs);

cd(oldPath)
end

end