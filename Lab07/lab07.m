%% Introduction to Computer Vision 185
%% Instructor: Prof. Ming-Hsuan Yang TA: Tiantian Wang & Tsai-Shien Chen
%% Completed by: Mike Monokandilos
%%
%% Lab 07 
%% file: Lab07.m
%% part of: Harris_corner_detector.m

%1. Sigma = 1 in the gaussian filter G1.
%2. Sigma = 2 in the gaussian filter G2.
%3. Alpha=0.04 when calculating the corner response.
%4. R_threshold = 1e-5 * 5 when applying thresholding on R.
% Read the three images




baboon = im2double(imread('baboon.png'));
name = 'baboon';
cameraman = im2double(imread('cameraman.png'));
name2 = 'cameraman';
checkboard = im2double(imread('checkboard.png'));
name3 = 'checkboard';

% Apply corner detection for first image
sigma1 = 1; sigma2 = 2;
alpha = 0.05; Rthreshold = 1e-5 * 5;

% Baboon image
[corner_x, corner_y] = Harris_corner_detector(baboon, name, sigma1, sigma2, alpha, Rthreshold);

% Visualize results
figure, imshow(baboon); hold on; title('Results');
plot(corner_x, corner_y, 'ro');
h = gcf; saveas(h, sprintf('baboon_corners.png'));

% Cameraman image
[corner_x, corner_y] = Harris_corner_detector(cameraman, name2, sigma1, sigma2, alpha, Rthreshold);

% Visualize results
figure, imshow(cameraman); hold on; title('Results');
plot(corner_x, corner_y, 'ro');
h = gcf; saveas(h, sprintf('cameraman_corners.png'));

% Checkboard image
[corner_x, corner_y] = Harris_corner_detector(checkboard, name3, sigma1, sigma2, alpha, Rthreshold);

% Visualize results
figure, imshow(checkboard); hold on; title('Results');
plot(corner_x, corner_y, 'ro');
h = gcf; saveas(h, sprintf('checkboard_corners.png'));