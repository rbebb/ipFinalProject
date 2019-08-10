function [adjImage] = noiseReduce(image)

% Remove noise using a median filter
% I = imread(image);
bw = rgb2gray(image);
Kmedian = medfilt2(bw);
    

% Contrast enhancing and histogram equalization
I2 = histeq(Kmedian);

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