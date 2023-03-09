close all;
path = 'Lecture4_data/Data';
listing = dir(path);
scenes = cell(0);
depthMaps = cell(0);
for d = 1:length(listing)
    if listing(d).isdir && ~strcmp(listing(d).name,'.') && ~strcmp(listing(d).name,'..')
        scenes{end+1} = dir(fullfile(listing(d).folder, listing(d).name));
        for i = 1:length(scenes{end})
            if(~scenes{end}(i).isdir)
                [filepath,name,ext] = fileparts(scenes{end}(i).name);
                if strcmp(ext, '.txt')
                    config = fullfile(scenes{end}(i).folder, scenes{end}(i).name);
                end
                if strcmp(scenes{end}(i).name, 'im1.png')
                    im1_name = fullfile(scenes{end}(i).folder, scenes{end}(i).name);
                    im1 = imread(im1_name);
                end
                if strcmp(scenes{end}(i).name, 'im0.png')
                    im0_name = fullfile(scenes{end}(i).folder, scenes{end}(i).name);
                    im0 = imread(im0_name);
                end
            end
        end
        depthMaps{end+1} = calculate_disparity_map2(im0, im1, config);
    end
end