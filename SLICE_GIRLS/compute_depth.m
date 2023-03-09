function depthMaps = compute_depth(path)

numOfScenes = 5;

im0 = cell(1,numOfScenes);
im1 = cell(1,numOfScenes);
disparityMaps = cell(1,numOfScenes);
depthMaps = cell(1,numOfScenes);

for i = 1:numOfScenes
    % Load images
    im0{i} = imread([path,'im',num2str(i),'/im0.png']);
    im1{i} = imread([path,'im',num2str(i),'/im1.png']);
    
    % Load calibration parameters
    params = importdata(['Data/im',num2str(i),'/calib.txt']);
    
    doffs = regexp(params(3),'\d+\.?\d*','match');
    doffs = str2double(cell2mat(doffs{1}));

    b = regexp(params(4),'\d+\.?\d*','match');
    b = str2double(cell2mat(b{1}));

    cam0 = regexp(params(1),'\d+\.?\d*','match');
    cam0 = cell2table(cam0{1});
    f01 = str2double(cell2mat(cam0.Var2));
    f02 = str2double(cell2mat(cam0.Var6));
    f0 = mean([f01, f02]);

    cam1 = regexp(params(1),'\d+\.?\d*','match');
    cam1 = cell2table(cam1{1});
    f11 = str2double(cell2mat(cam1.Var2));
    f12 = str2double(cell2mat(cam1.Var6));
    f1 = mean([f11, f12]);

    f = mean([f1, f0]);

    vmin = regexp(params(9),'\d+\.?\d*','match');
    vmin = str2double(cell2mat(vmin{1}));

    vmax = regexp(params(10),'\d+\.?\d*','match');
    vmax = str2double(cell2mat(vmax{1}));
    
    % Calculate disparity
    disparityRange = [80 320]; % BM
    disparityMaps{i} = disparityBM(rgb2gray(im0{i}),rgb2gray(im1{i}),...
                            'BlockSize', 15,...
                            'DisparityRange', disparityRange,...
                            'UniquenessThreshold', 5,...
                            'DistanceThreshold', 5,...
                            'ContrastThreshold', 0.7);
    
    % Compute depth
    depthMaps{i} = (b*f)./(disparityMaps{i} + doffs);
    depthMaps{i}(depthMaps{i} == 0) = NaN;
    depthMaps{i} = fillmissing(depthMaps{i},'spline',2,'EndValues','nearest');
    depthMaps{i} = fillmissing(depthMaps{i},'spline',1,'EndValues','nearest');
    
    % Filter depth maps
    depthMaps{i} = medfilt2(depthMaps{i},[45 45],'symmetric');
end



end