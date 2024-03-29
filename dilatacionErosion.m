clear all;
close all;
clc;

closepreview;
vid=videoinput('winvideo',2,'RGB24_352x288'); 
%define resoluci�n de captura (las que permita la c�mara). 

src = getselectedsource(vid);

% BacklightCompensation = �on�; % �off�
% Brightness = 55;
% ColorEnable = �on�; % �off�
% Contrast = 56;
% FrameRate = '15.0000';
% Gamma = 22;
% HorizontalFlip = �off�;
% Saturation = 100;
% VerticalFlip = �off�;
% src.BacklightCompensation='off';
% src.Contrast=20;
% src.ColorEnable = 'on'; % �off�
% src.FrameRate = '30.000';
% src.Gamma = 22;
% src.Saturation =100;
% src.HorizontalFlip = 'off'; % �on�
% src.VerticalFlip = 'on'; %�off�

preview(vid);

pause(10);

%i=1;

%while i==1
      I = getsnapshot(vid); %funci�n de captura de una imagen
      figure(1)
      imshow(uint8(I));
      impixelinfo;
      %pause(5);
%end;     


Igray=rgb2gray(I);

figure(2)
subplot(2,2,1), imshow(Igray); 
subplot(2,2,2), im2bw(I,0.35);
[counts,X]=imhist(Igray);       %para imagen en escala de grises
P=polyfit(X,counts,6); Y=polyval(P,X);
[V,ind]=sort(abs(diff(Y))); thresh=ind(3)./255;
subplot(2,2,3), im2bw(I,thresh);
level=graythresh(I);
subplot(2,2,4), im2bw(I,level);
figure(3); plot(X,counts); hold on, plot(X,Y,'r');

A=im2bw(I,level);

figure(4)

se1=strel('line',15,60);
bw1=imdilate(A,se1);
bw2=imerode(A,se1);
subplot(1,2,1),imshow(bw1);
subplot(1,2,2),imshow(bw2);