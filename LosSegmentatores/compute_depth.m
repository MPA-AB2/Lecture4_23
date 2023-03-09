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

    calibInfoFile = fopen(strcat(path,'\',folders{i},'\calib.txt'),'r');
    calibCode = textscan(calibInfoFile,'%s','delimiter','\n');
    fclose(calibInfoFile);
    for j = 1:4
        eval(strcat(calibCode{1}{j},';'))
    end
    focalLength = cam0(1,1);
    %% calculate disparity map
%     im0 = medfilt2(im0,[21,21]);
%     im1 = medfilt2(im1,[21,21]);

    %BM
%     disparityMap = disparityBM(im0,im1,'DisparityRange',[0,400],'BlockSize',21,'ContrastThreshold', 0.02,'UniquenessThreshold',2,'DistanceThreshold',40,'TextureThreshold',0.0005);
    %     disparityMap = imgaussfilt(disparityMap,0.01,"FilterSize",15);

    %SGM
%     disparityMap = disparitySGM(im0,im1,'DisparityRange',[0,128],'UniquenessThreshold',35);%,'DisparityRange',[0,40],'DistanceThreshold',400
%     imshow(disparityMap,[])
%     disparityMap = imgaussfilt(disparityMap,0.01,"FilterSize",15);


    % other method
    win=25;
    max_dis=250;
    weight=0.5;

    tic;
    disparityMap = disparity_estimator(im0, im1, win, max_dis, weight);
    toc;

    disparityMap = imgaussfilt(disparityMap,0.1,"FilterSize",11);
    % calculating the depth map
    depthMap = (baseline * focalLength) ./ (double(disparityMap) + doffs);

    depthMap(isnan(depthMap)) = 0;
    depthMap(isinf(depthMap)) = 0;

    depthMaps{i} = depthMap;
end
end