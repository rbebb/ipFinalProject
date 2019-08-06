% Final Poject Section 12 Group 4 Eli, Chris, Ryan
clc
close all
clear all %#ok<*CLALL>

%function counts = idcoins(name)
name = 'c1.jpg'; %remove later

smol = 0.2;

%ratios = [0.9083, 0.6500, 0.7156, 0.8953, 0.7259, 0.7993, 1/0.9083, 1/0.6500, 1/0.7156, 1/0.8953, 1/0.7259, 1/0.7993, 1];
%coins = ["Penny", "Quarter", "Quarter", "Quarter", "Nickle", "Nickle", "dime", "dime", "Penny", "Nickle", "Dime", "Penny", "SELF"];
ratios = [1.3004 1.1367 1.3695 0.769 0.8741 1.0531 0.8797 1.144 1.2048 0.7302 0.9496 0.83 1];
coins = ["Penny" "Nickel" "Dime" "Quarter" "Nickel" "Dime" "Quarter" "Penny" "Dime" "Quarter" "Penny" "Nickel" "ME"];
%denominators

dp = 0.9083;
dq = 0.6500;
pq = 0.7156;
nq = 0.8953;
dn = 0.7259;
pn = 0.7993;

A = imread(name);
A = rgb2gray(A);
A = filter2(fspecial('average',3), A) / 255;
A = imresize(A, smol);
B = histeq(A);
B = B + 30;

%
I = double(A);
a = min(min(I));
b = max(max(I));
t = 150;
[m1,m2] = size(I);
I2 = zeros(m1,m2);
for i = 1:m1
    for j = 1:m2
        I2(i,j) = (t/(b-a))*(I(i,j)-a);
    end
end
A = uint8(I2);


% 
imshow(A);
% 

%%%testing
%mask = zeros(size(A));
%mask(1:end,1:end) = 1;
%X = activecontour(A,mask, 8000, 'edge');
%%%
%imshow(X);


[c, r] = imfindcircles(A, [smol*200 smol*1300], 'ObjectPolarity', 'dark', 'Sensitivity', 0.97) %#ok<NOPTS> %0.98
%[c, r] = imfindcircles(A, [200 1300], 'ObjectPolarity', 'dark', 'Sensitivity', 0.99) %#ok<NOPTS> %0.98
r = r*1.1;
viscircles(c, r)

if max(size(c)) == 1
   imwrite(A, 'test.pgm');
   p = match('penny.pgm', 'test.pgm');
   n = match('nickel.pgm','test.pgm');
   d = match('dime.pgm', 'test.pgm');
   q = match('quarter.pgm', 'teast.pgm');
   
   
   %return v
end



if max(size(r)) > 1
    f = -1;
    p = max(size(c))
    nearness = zeros(p, p, 2);
    nearness = nearness + 19;
    for i=1:p %cols
        for j=1:p %rows
            nearness(i, j, 1) = (r(i) / r(j));
            nearness(i, j, 2) = 1;
            for k=1:max(size(ratios))
                %disp(abs(ratios(k) - nearness(i, j, 1)))
                %disp(abs(ratios(nearness(i, j, 2)) - nearness(i, j, 1)))
                %disp(abs(ratios(k) - nearness(i, j, 1)) < abs(ratios(nearness(i, j, 2)) - nearness(i, j, 1)))
                if abs(ratios(k) - nearness(i, j, 1)) < abs(ratios(nearness(i, j, 2)) - nearness(i, j, 1)) 
                    nearness(i, j, 2) = k;
                    
                    %f = k
                end
            end
            
            %nearness(i, j, 2) = coins(nearness(i, j, 2));
        end
    end
    nearness
end


% mask = zeros(size(A));
% mask(1:end,1:end) = 1;
% X = activecontour(A,mask, 8000, 'edge');
% %Y = imopen(Y, strel('disk',5));
% X = imclose(X, strel('disk',10));
% %Y = imdilate(X, strel('disk',20));
% Y = imfill(X, 'holes');
% 
% f1 = figure();
% subplot(1, 2, 1), imshow(X);
% subplot(1, 2, 2), imshow(Y);

