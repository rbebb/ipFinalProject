% %Removing noise with adaptive filtering 
coinsImg = imread('mona_noisy.png');
bw = rgb2gray(coinsImg);
J = imnoise(bw,'gaussian',0,0.025);
figure(1);
imshow(bw);
title('Black and White version');

K = wiener2(bw,[5 5]);
figure(2);
imshow(K);
title('Noise Removal');
figure(3);
imshow(coinsImg);
title('Original Image');
L = wiener2(K,[5 5]);
figure(4);
imshow(L);

pause();
clc; clear all; close all;

%Remove Noise Using an Averaging Filter and a Median Filter
I = imread('mona_noisy.png');
bw = rgb2gray(I);
figure(1);
imshow(bw);
Kaverage = filter2(fspecial('average',3),bw)/255;
figure(2);
imshow(Kaverage);

pause();
clc; clear all; close all;