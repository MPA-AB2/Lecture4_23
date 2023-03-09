function[depthMaps] = compute_depth(path)
cd(path)
D = dir;
D = D(~ismember({D.name}, {'.', '..'}));
depth_map = {};

for k = 1:numel(D)
    currD = D(k).name;    
    cd(currD)
    
    I1 = imread('im0.png');
    I2 = imread('im1.png');
    calibration  = readcell("calib.txt");
    
    doffs = calibration{3,2};
    baseline = calibration{4,2};
    f = str2num(calibration{2,2});
    f = f(1,1);
    
    J1 = rgb2gray(I1);
    J2 = rgb2gray(I2);
    
    disparityRange = [64 224];
    disparityMap = disparityBM(J1,J2,'DisparityRange',disparityRange,'UniquenessThreshold',0);

    [rows cols] = size(disparityMap);
    depth = zeros(rows,cols);
    disparityMap_doff = disparityMap+doffs;
    depth(:,:) = f*baseline;
    depth_map{1,k} = depth./disparityMap_doff;
    depth_map{1,k} = medfilt2(depth_map{1,k},[40,40]);
    depth_map{1,k}(depth_map{1,k}==0) = NaN;
    depth_map{1,k} = fillmissing(depth_map{1,k},'nearest',2,'EndValues','nearest');
  
    cd('..')

    depthMaps = depth_map;
end
end