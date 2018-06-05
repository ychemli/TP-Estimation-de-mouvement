clc
close all
clear all

I1 = imread('frame10.png');
I2 = imread('frame11.png');

I1 = double(rgb2gray(I1));
I2 = double(rgb2gray(I2));

w = size(I1, 2);
h = size(I1, 1);

win = 6;
Niter = 100;

[ Wx_e, Wy_e ] = lucas( I1, I2, win);

we(:,:,1) = Wx_e;
we(:,:,2) = Wy_e;

figure();
imagesc(flowToColor(we));
str = sprintf('Optical flow with window size = %d', win);
title(str);
