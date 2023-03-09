function [depthMaps] = compute_depth(path)
% This function computes depth maps for all pairs of rectified images in
% subfolders located in path, the subfolders shall also include calibration
% info
%% find names of folders
filesAndFolders = dir(path);
folderFlags = [filesAndFolders.isdir];
foldersInfo = filesAndFolders(folderFlags);
folders = {foldersInfo(3:end).name};
%% loop for iteration through the image folders
depthMaps = cell(length(folders),1);
for i = 1:length(folders)
    %% loading images and calibration data
    im0 = rgb2gray(imread(strcat(path,'\',folders{i},'\im0.png')));
    im1 = rgb2gray(imread(strcat(path,'\',folders{i},'\im1.png')));

%     calibInfo = readvars(strcat(path,'\',folders{i},'\calib.txt'));
    calibInfoFile = fopen(strcat(path,'\',folders{i},'\calib.txt'),'r');
    calibCode = textscan(calibInfoFile,'%s','delimiter','\n');
%     calibInfo = fscanf(calibInfoFile,'%f');
    fclose(calibInfoFile);
    for j = 1:4
        eval(strcat(calibCode{1}{j},';'))
    end
    focalLength = cam0(1,1);
    %% calculate disparity map
    im0Gray = im2gray(im0);
    im1Gray = im2gray(im1);
%     im0Gray = medfilt2(im0Gray,[21,21]);
%     im1Gray = medfilt2(im1Gray,[21,21]);
%     disparityMap = disparityBM(im0Gray,im1Gray,'DisparityRange',[0,304],'BlockSize',15,'ContrastThreshold',0.2,'UniquenessThreshold',5,'DistanceThreshold',20,'TextureThreshold',0.0005);
    disparityMap = disparitySGM(im0Gray,im1Gray,'DisparityRange',[0,128],'UniquenessThreshold',2);%,'DisparityRange',[0,40],'DistanceThreshold',400
%     imshow(disparityMap,[])
    %for BM
%     disparityMap = imgaussfilt(disparityMap,0.01,"FilterSize",15);

    %for SGM
%     disparityMap = medfilt2(disparityMap,[25 25]);
    disparityMap = imgaussfilt(disparityMap,0.01,"FilterSize",13);
    % calculating the depth map
    depthMap = (baseline * focalLength) ./ (disparityMap + doffs);

    depthMap(isnan(depthMap)) = 0;
    depthMap(isinf(depthMap)) = 0;
%     imshow(depthMap,[])

    depthMaps{i} = depthMap;
end
end