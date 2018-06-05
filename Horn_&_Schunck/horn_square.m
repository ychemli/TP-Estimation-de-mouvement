clc;
close all;
clear all;

I1 = imread('square9.png');
I2 = imread('square10.png');

I1 = double(I1);
I2 = double(I2);

w = size(I1, 2);
h = size(I1, 1);
    
Niter = 100;

err = [];

minErr = 10000000;
minAlpha = 0;
minW = 0;

wr = readFlowFile('correct_square.flo');

Wx_r = wr(:,:,1);
Wy_r = wr(:,:,2);

lowA = 100;
step = 1000;
highA = 200000;

for alpha=lowA:step:highA
    
    [ Wx_e, Wy_e ] = horn( I1, I2, alpha, Niter);

    we(:,:,1) = Wx_e;
    we(:,:,2) = Wy_e;
    
    angularErr = acos((1+ Wx_r.*Wx_e + Wy_r.*Wy_e) ./ sqrt(1+Wx_r.^2+Wy_r.^2) .* sqrt(1+Wx_e.^2+Wy_e.^2));
    rad = sqrt(real(angularErr).^2+imag(angularErr).^2);
    errA = mean(rad(:));
    err = [err, errA];
    
    if minErr > errA
        minErr = errA;
        minAlpha = alpha; 
        minW = we;
    end
end

figure();
plot (err);
title('Error / Alpha');

figure();
imagesc(flowToColor(minW));
str = sprintf('Optical flow with alpha = %d', minAlpha);
title(str);

figure();
imagesc(flowToColor(wr));
title('Reference optical flow');

u = minW(:,:,1);
v = minW(:,:,2);
    
u(1 : 2 : end) = 0;
v(1 : 2 : end) = 0;
quiver(u.*200,v.*200)
