%% Introduction to Computer Vision 185
%% Instructor: Prof. Ming-Hsuan Yang TA: Tiantian Wang & Tsai-Shien Chen
%% Completed by: Mike Monokandilos
%%
%% Lab 07 
%% file: Harris_corner_detector.m
%% part of: Lab07.m

%% added(2 nd parameter == name) for ease in saving photos with respective names




function [corner_x, corner_y] = Harris_corner_detector(I, name, sigma1, sigma2, alpha, Rthreshold)
    % Gaussian kernel calculation
    H1 = 1 + 2 * (sigma1 * 2);
    H2 = 1 + 2 * (sigma2 * 2);

    gaussH1 = fspecial('gaussian', H1, sigma1);
    gaussH2 = fspecial('gaussian', H2, sigma2);

    % Derivative filter
    Dx = [1 0 -1]; Dy = [1; 0; -1];

    % first Blur with gauss then extract features of X, Y
    Ix = imfilter(imfilter(I, gaussH1, 'replicate'), Dx, 'replicate');
    Iy = imfilter(imfilter(I, gaussH1, 'replicate'), Dy, 'replicate');
    G = imfilter(I, gaussH1); % Gaussian filter

    % show gradients x & y 
    figure, imshow(Ix + 0.5); title('Gradient_X');
    imwrite(Ix+0.5, sprintf('%s_Ix.png', name));
    figure, imshow(Iy + 0.5); title('Gradient_Y');
    imwrite(Iy+0.5, sprintf('%s_Iy.png', name));
    figure, imshow(G); title('Gaussian Filtering');

    % Product of gradients, partial derivative calc
    Ixx = Ix .* Ix;
    Iyy = Iy .* Iy;
    Ixy = Ix .* Iy;

    % Matrix M
    Sxx = imfilter(Ixx, gaussH2, 'replicate');
    Syy = imfilter(Iyy, gaussH2, 'replicate');
    Sxy = imfilter(Ixy, gaussH2, 'replicate');

    % Corner response through Harris_corner_detector
    M = [Sxx Sxy; Sxy Syy];
    detM = Sxx .* Syy - Sxy .* Sxy;
    traceM = Sxx + Syy;

    R = detM - alpha * (traceM.^2);
    figure, imagesc(R); colormap jet; colorbar; axis image; title('Corner Response');
    h = gcf; saveas(h, sprintf('%s_R.png', name));

    % Apply thresholding on R
    corner_map = R > Rthreshold;
    figure, imshow(corner_map); title('Corner Map');
    imwrite(corner_map, sprintf('%s_corner_map.png', name));

    % Non-maxima Suppression
    local_maxima = imregionalmax(R);
    figure, imshow(local_maxima); title('Local Maxima');
    imwrite(local_maxima, sprintf('%s_local_maxima.png', name));

    % final corner map
    final_corner_map = corner_map & local_maxima;
    [corner_y, corner_x] = find(final_corner_map);
    figure, imshow(final_corner_map); title('Final Corner Map');
    imwrite(final_corner_map, sprintf('%s_final_corner_map.png', name));
end