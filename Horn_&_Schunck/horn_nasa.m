clc;
close all;
clear all;

I1 = imread('nasa9.png');
I2 = imread('nasa10.png');

I1 = double(I1);
I2 = double(I2);

w = size(I1, 2);
h = size(I1, 1);
 
alpha = 100;
Niter = 100;

[ Wx_e, Wy_e ] = horn( I1, I2, alpha, Niter);

we(:,:,1) = Wx_e;
we(:,:,2) = Wy_e;    
   
figure();
imagesc(flowToColor(we));
str = sprintf('Optical flow with alpha = %d', alpha);
title(str);

