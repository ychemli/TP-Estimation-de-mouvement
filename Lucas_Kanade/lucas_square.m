clc
close all
clear all

I1 = imread('square9.png');
I2 = imread('square10.png');

I1 = double(I1);
I2 = double(I2);

w = size(I1, 2);
h = size(I1, 1);
    
alpha = 100;
Niter = 100;

err = [];

minErr = 100000;
minWin = 0;
minW = 0;

wr = readFlowFile('correct_square.flo');
 
Wx_r = wr(:,:,1);
Wy_r = wr(:,:,2);
    
lowW = 2;
step = 2;
highW = 10;

for win=lowW:step:highW
    
    [ Wx_e, Wy_e ] = lucas( I1, I2, win);

    we(:,:,1) = Wx_e;
    we(:,:,2) = Wy_e;

    angularErr = acos((1+ Wx_r.*Wx_e + Wy_r.*Wy_e) ./ sqrt(1+Wx_r.^2+Wy_r.^2) .* sqrt(1+Wx_e.^2+Wy_e.^2));
    rad = sqrt(real(angularErr).^2+imag(angularErr).^2);
    errW = mean(rad(:));
    err = [err, errW];
    
    if minErr > errW
        minErr = errW;
        minWin = win; 
        minW = we;
    end
end

figure();
plot (err);
title('Error / Window size');

figure();
imagesc(flowToColor(minW));
str = sprintf('Optical flow with window size = %d', minWin);
title(str);

figure();
imagesc(flowToColor(wr));
title('Reference optical flow');

u = minW(:,:,1);
v = minW(:,:,2);
    
u(1 : 2 : end) = 0;
v(1 : 2 : end) = 0;
quiver(u.*1000,v.*1000)