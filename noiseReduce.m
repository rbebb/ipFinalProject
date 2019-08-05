function [adjImage] = noiseReduce(image)

% %Removing noise with adaptive filtering 
% coinsImg = imread('coins.jpg');
% bw = rgb2gray(coinsImg);
% J = imnoise(bw,'gaussian',0,0.025);
% figure(1);
% imshow(bw);
% title('Black and White version');

% K = wiener2(bw,[5 5]);
% figure(2);
% imshow(K);
% title('Noise Removal');
% figure(3);
% imshow(coinsImg);
% title('Original Image');
% L = wiener2(K,[5 5]);
% figure(4);
% imshow(L);

% pause();
% clc; clear all; close all;

%Remove Noise Using an Averaging Filter and a Median Filter
% I = imread(image);
bw = rgb2gray(image);
figure(1);
imshow(bw);
Kaverage = filter2(fspecial('average',3), bw) / 255;
figure(2);
imshow(Kaverage);

% pause();
% clc; clear all; close all;


% Contrast enhancing
I2 = histeq(Kaverage);
figure(5);
imshow(I2);
title('Histogram Equalization');

% Light level calibration
% I = double(I);
% a = min(min(I));
% b = max(max(I));
% t = 150;
% [m1,m2] = size(I);
% I2 = zeros(m1,m2);
% for i = 1:m1
%     for j = 1:m2
%         I2(i,j) = (t/(b-a))*(I(i,j)-a);
%     end
% end
% I2 = uint8(I2);
% figure(6);
% imshow(I2);
% title("Brightness Adjusted"); 

adjImage = I2;

end