% Final Poject Section 12 Group 4 Eli, Chris, Ryan
clc
close all
clear all %#ok<*CLALL>

%function counts = idcoins(name)
name = 'all.jpg'; %remove later

ratios = [0.9083, 0.6500, 0.7156, 0.8953, 0.7259, 0.7993, 1/0.9083, 1/0.6500, 1/0.7156, 1/0.8953, 1/0.7259, 1/0.7993];
coins = ["Penny", "Quarter", "Quarter", "Quarter", "Nickle", "Nickle", "dime", "dime", "Penny", "Nickle", "Dime", "Penny"];
%denominators

dp = 0.9083;
dq = 0.6500;
pq = 0.7156;
nq = 0.8953;
dn = 0.7259;
pn = 0.7993;

A = imread(name);
A = rgb2gray(A);
A = histeq(A);
% A = imbinarize(A);
% A = abs(A - 1);
% [circles, sizes] = zeros(1, 1), zeros(1,1);
% size([circles])
% 
% imshow(A);
% pause;
% A = imfill(A, 'holes');
% A = abs(A - 1);
% imshow(A);
% pause;
% 
% A = bwlabel(A, 4);
% 
imshow(A);
% 
% coloredLabels = label2rgb (A, 'hsv', 'k', 'shuffle'); % pseudo random color labels
% imshow(coloredLabels);

%pix = cast((max(size((A)))), 'uint8') %#ok<NOPTS>

%for pix = pix:-10:10
%    [centers, radii] = imfindcircles(A, [pix-5, pix + 5]);
%    if size(centers > 0)
%        disp([centers, radii])    
%    end
%end

[c, r] = imfindcircles(A, [200 1300], 'ObjectPolarity', 'dark', 'Sensitivity', 0.98) %#ok<NOPTS>
r = r*1.1;
viscircles(c, r)

if max(size(c)) == 1
   imwrite(A, 'test.pgm');
   p = match('penny.pgm', 'test.pgm');
   n = match('nickel.pgm','test.pgm');
   d = match('dime.pgm', 'test.pgm');
   q = match('quarter.pgm', 'teast.pgm');
   b = p;
   v = 1;
   if b < n
       b = n;
       v = 5;
   end
   if b < d
       b = d;
       v = 10;
   end
   if b < q
       b = q;
       v = 25;
   end
   
   %return v
end



if max(size(r)) > 1
    f = -1;
    size(c);
    nearness = zeros(size(c));
    nearness = nearness + 10;
    for i=1:size(c)
        for j=1:size(c)
            nearness(i, j) = (r(i) / r(j)) + 20;
            for k=1:size(ratios)
                if abs(ratios(k) - (r(i) / r(j))) < nearness(i, j)
                    nearness(i, j) = abs(ratios(k) - (r(i) / r(j)))
                    f = k
                end
            end
            nearness(i, j) = f;
        end
    end
    nearness
end

