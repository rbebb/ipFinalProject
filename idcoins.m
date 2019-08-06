% Final Poject Section 12 Group 4 Eli, Chris, Ryan
clc
close all
clear all %#ok<*CLALL>

%function counts = idcoins(name)
name = 'c4.jpg'; %remove later

smol = 0.2;

%ratios = [0.9083, 0.6500, 0.7156, 0.8953, 0.7259, 0.7993, 1/0.9083, 1/0.6500, 1/0.7156, 1/0.8953, 1/0.7259, 1/0.7993, 1];
%coins = ["Penny", "Quarter", "Quarter", "Quarter", "Nickle", "Nickle", "dime", "dime", "Penny", "Nickle", "Dime", "Penny", "SELF"];
ratios = [1.4063 1.0968 1.2741 0.7211 0.7799 0.9060 0.9251 1.2822 1.1616 0.7849 1.1038 0.8609];
coins = ["Dime" "Dime" "Dime" "Quarter" "Quarter" "Quarter" "Penny" "Penny" "Penny" "Nickel" "Nickel" "Nickel" ];
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

if max(size(r)) == 1
   imwrite(A, 'test.pgm');
   p = match('penny.pgm', 'test.pgm');
   n = match('nickel.pgm','test.pgm');
   d = match('dime.pgm', 'test.pgm');
   q = match('quarter.pgm', 'test.pgm');
   v = p;
   if v > n
       v = n;
   end
   if v > d
       v = d;
   end
   if v > q
       v = q;
   end
   
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
            if nearness(i, j, 2) == 2 || nearness(i, j, 2) == 3
                nearness(i, j, 2) = 1;
            end
            
            if nearness(i, j, 2) == 5 || nearness(i, j, 2) == 6
                nearness(i, j, 2) = 4;
            end
            
            if nearness(i, j, 2) == 8 || nearness(i, j, 2) == 9
                nearness(i, j, 2) = 7;
            end
            
            if nearness(i, j, 2) == 11 || nearness(i, j, 2) == 12
                nearness(i, j, 2) = 10;
            end
        end
    end
    nearness
end

counts = zeros(4, 1);
for j=1:p
    %nearness(:,j,2)
    g = mode(nearness(:,j,2));
    if g == 1
        counts(3) = counts(3) + 1;
    end
    if g == 7
        counts(1) = counts(1) + 1;
    end
    if g == 10
        counts(2) = counts(2) + 1;
    end
    if g == 4
        counts(4) = counts(4) + 1;
    end
        
end

disp(counts)

%return counts?
