function [depthMaps] = compute_depth(path)
listing = dir(path);
scenes = cell(0);
depthMaps = cell(0);
for d = 1:length(listing)
    if listing(d).isdir && ~strcmp(listing(d).name,'.') && ~strcmp(listing(d).name,'..')
        scenes{end+1} = dir(fullfile(listing(d).folder, listing(d).name));
        % disp(strcat("In folder ", listing(d).name, " found files:"))
        % lading images to im0, im1, path to config file to "config"
        for i = 1:length(scenes{end})
            if(~scenes{end}(i).isdir)
                [filepath,name,ext] = fileparts(scenes{end}(i).name);
                if strcmp(ext, '.txt')
                    config = fullfile(scenes{end}(i).folder, scenes{end}(i).name);
                    %disp(strcat("Config is ", config))
                end
                if strcmp(scenes{end}(i).name, 'im1.png')
                    im1_name = fullfile(scenes{end}(i).folder, scenes{end}(i).name);
                    im1 = imread(im1_name);
                    %disp(strcat("Image 1 path is ", im1_name))
                end
                if strcmp(scenes{end}(i).name, 'im0.png')
                    im0_name = fullfile(scenes{end}(i).folder, scenes{end}(i).name);
                    im0 = imread(im0_name);
                    %disp(strcat("Image 0 path is ", im0_name))
                end
            end
        end
        depth_map = calculate_disparity_map2(im0, im1, config);
        depthMaps{end+1} = medfilt2(depth_map, [9 9]);
%         depth_map = calculate_disparity_map2(im0, im1, config);
%         sdm = sum(depth_map);
%         for i = 1:length(sdm)
%             if sdm(i) > 0
%                 offset = i-1;
%                 break;
%             end
%         end
%         medf_depth_map = medfilt2(depth_map, [5 5]);
%         composed_dept_map = medf_depth_map;
%         composed_dept_map(:, 1:offset) = depth_map(:, 1:offset);
%         depthMaps{end+1} = composed_dept_map;
        % depthMaps{end+1} = wiener2(depth_map, [15 15]);
    end
end