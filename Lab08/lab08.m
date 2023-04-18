%% Introduction to Computer Vision 185
%% Instructor: Prof. Ming-Hsuan Yang TA: Tiantian Wang & Tsai-Shien Chen
%% Completed by: Mike Monokandilos
%%
%% Lab 08
%% file: Lab08.m
%% part of: hough_transform_polar.m, hough_transform.m.

imgName = 'bridge';
%imgName = 'hill';
%imgName = 'lines';
img = imread(sprintf('%s.png', imgName));

edge_map = edge(rgb2gray(img), 'canny', 0.1, 3);
%figure, imshow(edge_map);

% Solve for Hough transform in cartesian coordinates
[m, b] = hough_transform(edge_map);
x = 1:size(img, 2);
y = m * x + b;
figure, imshow(img);title('Cartesian space(m,b)');
hold on;
plot(x, y, 'LineWidth', 4, 'Color', 'red');
saveas(gcf, sprintf('%s_mb_line.png', imgName));

% Solve for Hough Transform in polar coordinates
[r, theta] = hough_transform_polar(edge_map);
x = 1:size(img, 2);
y = -(cos(theta)/sin(theta)) * x + (r / sin(theta));
figure, imshow(img);
hold on;
plot(x, y, 'LineWidth', 4, 'Color', 'blue');title('Polar space(r, theta)');
saveas(gcf, sprintf('%s_polar_line.png', imgName));