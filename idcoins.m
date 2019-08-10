% Final Poject Section 12 Group 4 Eli, Chris, Ryan
function [counts, t, c, r, A] = idcoins(name)

smol = 0.2;

ratios = [1.4063 1.0968 1.2741 0.7211 0.7799 0.9060 0.9251 1.2822 1.1616 0.7849 1.1038 0.8609];
coins = ["Dime" "Dime" "Dime" "Quarter" "Quarter" "Quarter" "Penny" "Penny" "Penny" "Nickel" "Nickel" "Nickel" ];

% Denominators
dp = 0.9083;
dq = 0.6500;
pq = 0.7156;
nq = 0.8953;
dn = 0.7259;
pn = 0.7993;

A = name;
A = rgb2gray(A);

% Remove noise using an averaging filter
A = filter2(fspecial('average', 3), A) / 255;
if max(size(A)) > 1300
    A = imresize(A, smol);
end
% Contrast enhancing and histogram equalization
B = histeq(A);
B = B + 30;

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

figure(9);
imshow(A);

[c, r] = imfindcircles(A, [smol*200 smol*1300], 'ObjectPolarity', 'dark', 'Sensitivity', 0.97) %#ok<NOPTS> %0.98

r = r*1.1;
viscircles(c, r)
print(9,'test.png','-dpng','-r300');

% Testing line
% imwrite(imread('pennyFront.JPG'), 'pennyFront.pgm');

% Initialize total
t = 0;

counts = zeros(4, 1);
if max(size(r)) == 1
   imwrite(A, 'test.pgm');
   p = match('penny.pgm', 'test.pgm');
   n = match('nickel.pgm','test.pgm');
   d = match('dime.pgm', 'test.pgm');
   q = match('quarter.pgm', 'test.pgm');
   
   v = p;

   counts = [1 0 0 0];
   t = .01;
   if v < n
       counts = [0 1 0 0];
       t = .05;
   end
   if v < d
       counts = [0 0 1 0];
       t = .1;
   end
   if v < q
       counts = [0 0 0 1];
       t = .25;
   end

end


if max(size(r)) > 1
    f = -1;
    p = max(size(c))
    nearness = zeros(p, p, 2);
    nearness = nearness + 19;
    for i=1:p % Cols
        for j=1:p % Rows
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
    
    for j=1:p
        g = mode(nearness(:,j,2));
        if g == 1
            counts(1) = counts(1) + 1;
        end
        if g == 7
            counts(2) = counts(2) + 1;
        end
        if g == 10
            counts(3) = counts(3) + 1;
        end
        if g == 4
            counts(4) = counts(4) + 1;
        end    
    end

    t = counts(1)*.01 + counts(2)*.05 + counts(3)*.1 + counts(4)*.25;
end

end
