# Lecture4 - STEREOSCOPY AND MULTISCOPY

[**Benchmark Results**](https://moodle.vut.cz/pluginfile.php/407360/mod_resource/content/1/BenchmarkReconstruction.xlsx%20-%20List1.pdf)

## Preparation

1. Run Git bash.
2. Set username by: `$ git config --global user.name "name_of_your_GitHub_profile"`
3. Set email by: `$ git config --global user.email "email@example.com"`
4. Select some MAIN folder with write permision.
5. Clone the **Lecture4** repository from GitHub by: `$ git clone https://github.com/MPC-AB2/Lecture4.git`
6. In the MAIN folder should be new folder **Lecture4**.
7. In the **Lecture4** folder create subfolder **NAME_OF_YOUR_TEAM**.
8. Run Git bash in **Lecture4** folder (should be *main* branch active).
9. Create a new branch for your team by: `$ git checkout -b NAME_OF_YOUR_TEAM`
10. Check that  *NAME_OF_YOUR_TEAM* branch is active.
11. Continue to the task...

## Tasks to do

1. Download the data in a zip folder from [here](https://www.vut.cz/www_base/vutdisk.php?i=285511a1fd). Extract the content of the zip folder into **Lecture4** folder. It contains folder Data with a set of five folders of scenes (imX), each with two images (im0 and im1) from two cameras and calibration information (calib.txt). Stereoscopic images have been already rectified into the epipolar planes. Besides, the fip filder contains an encrypted ground truht image *GT.mat*. 
2. Compute a disparity maps for each im0 in horizontal direction by any method.
3. Compute a depth maps from obtained disparity maps and available calibration parameters.
4. Design an automatic algorithm for depth maps computation (depth will be in mm). Try to design also a pipeline for post-processing of disparity (depth) maps that will reflect in gaining similar results as the ground truth maps. 
5. Use the provided MATLAB function for evaluation of the results and submit the output to the provided Excel table. The function *evaluateReconstruction.p* called as:
`[MAE,percantageMissing,details] = evaluateReconstruction(depthMaps)`,
has the following inputs and outputs:
  * depthMaps (cell array 1xNumber of scenes, where each cell contains matrix sized as image containing depth values in mm, missing pixels should have value equal to zero); the order of scenes has to be preserved,
  * MAE (mean absolute error for whole dataset),
  * percentageMissing (mean percent of pixels without estimated depth)
  * details for individual scenes.
6. Store your implemented algorithm as a form of function `[depthMaps] = TeamName( path )`; for *depthMaps* see above; *path* is the path to the *Data* folder with subfolders of individual scenes. Make sure the function will open individual subfolders, compute the depth map and store it in the cell array with the order of scene preserved. The function will be used for evaluation of universality of your solution using another input scenes. **Push** your program implementations into GitHub repository **Lecture4** using the **branch of your team** (stage changed -> fill commit message -> sign off -> commit -> push -> select *NAME_OF_YOUR_TEAM* branch -> push -> manager-core -> web browser -> fill your credentials).
7. Create a reconstructed 3D surface image of your best-estimated depth map and use representation by a point cloud (due to the high resolution of original images use subsampled
space only). Check the quality of the reconstruction. You can rotate the 3D plot and make sure that the reconstructed objects are clearly visible.
8. Submit *.tiff* image of the 3d surface and the best-obtained result of your method evaluated on the competition dataset using the evaluation function (i.e. submit the calculated evaluation values) into a shared [Excel table](https://docs.google.com/spreadsheets/d/1_cAuTqY7bAdAE_-ORHeWioJ7d9sKWocp/edit?usp=sharing&ouid=105272487043795807825&rtpof=true&sd=true). The evaluation of results from each team will be presented at the end of the lecture.

