clear all,close all,clc
I=imread('imagen.png');
x=ind2gray(I);
J=histeq(x,32);
K=histeq(x,4);
subplot(2,2,1),imhist(J,32);
subplot(2,2,1),imshow(J,32);
subplot(2,2,1),imhist(K,32);
subplot(2,2,1),imshow(K,32);