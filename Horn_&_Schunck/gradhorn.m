function [Ix, Iy, It] = gradhorn(I1, I2)
    w = size(I1, 2);
    h = size(I1, 1);
    I1_ip1 = zeros(1,w); %line of zeros
    I1_ip1 = [ I1_ip1  ; I1(1:h-1,:) ]; % I1(i+1, j)
    I1_jp1 = zeros(h,1); %columns of zeros
    I1_jp1 = [ I1_jp1 , I1(:,1:w-1) ];  % I1(i, j+1)
    I1_ip1_jp1 = zeros(h,h);
    I1_ip1_jp1(2:h, 2:w) =  I1(1:h-1,1:w-1);  % I1(i+1, j+1)
    
    I2_ip1 = zeros(1,w); %line of zeros
    I2_ip1 = [ I2_ip1  ; I1(1:h-1,:) ]; % I2i+1, j)
    I2_jp1 = zeros(h,1); %columns of zeros
    I2_jp1 = [ I2_jp1 , I2(:,1:w-1) ];  % I2(i, j+1)
    I2_ip1_jp1 = zeros(h,h);
    I2_ip1_jp1(2:h, 2:w) =  I2(1:h-1,1:w-1);  % I2(i+1, j+1)
    
    Ix = 1/4 * ( I1_ip1 - I1 + I1_ip1_jp1 - I1_jp1 + I2_ip1 - I2 + I2_ip1_jp1 - I2_ip1);
    Iy = 1/4 * ( I1_jp1 - I1 + I1_ip1_jp1  - I1_ip1 + I2_jp1 - I2 + I2_ip1_jp1 - I2_ip1);
    It = 1/4 * ( I2 - I1 + I2_ip1 - I1_ip1 + I2_jp1 - I1_jp1 + I2_ip1_jp1 - I1_ip1_jp1);
end