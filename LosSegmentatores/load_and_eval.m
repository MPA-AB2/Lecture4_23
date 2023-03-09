% MPA-AB2 Lecture 4
clear,clc,close
%% call our algorithm for depth calculation
path = "V:\MPA-AB2\Lecture4_23\Data";
[depthMaps] = compute_depth(path);
%% evaluate results
[MAE, percantageMissing, details] = evaluateReconstruction(depthMaps);
%% create 3D view
n=0;
[s1, s2] = size(depthMaps{2});
xyz = zeros(338400,3);
colors = zeros(338400,3);
for i = 1:4:s1
  for j = 1:4:s2
      n = n+1;
      xyz(n,1) = i;
      xyz(n,2) = j;
      xyz(n,3) = depthMaps{2}(i,j);
      colors(n,:) = colorImage(i,j,:);
  end
end

ptCloud = pointCloud(xyz);%,'Color',colors
pcshow(ptCloud,"VerticalAxis","X")