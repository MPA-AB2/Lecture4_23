input_path='V:\AB2\Lecture4_23';
addpath(genpath(input_path))
[depthMaps] = compute_depth('V:\AB2\Lecture4_23\Lecture4_data\Data');

[MAE, percantageMissing, details] = evaluateReconstruction(depthMaps)