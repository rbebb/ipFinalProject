% Final Poject Section 12 Group 4 Eli, Chris, Ryan
clc
close all
clear all


A = imread('coins.jpg');
A = rgb2gray(A);
%[circles, sizes] = zeros(1, 1), zeros(1,1);
%size([circles])

imshow(A);

pix = max((size((A))))

%for pix = pix:-10:10
%    [centers, radii] = imfindcircles(A, [pix-5, pix + 5]);
%    if size(centers > 0)
%        disp([centers, radii])    
%    end
%end

[c, r] = imfindcircles(A, [100 600], 'ObjectPolarity', 'dark', 'Sensitivity', 0.965)
viscircles(c, r)









