clear all;
close all;
clc;

closepreview;
vid=videoinput('winvideo',1,'RGB24_352x288'); 
%define resolución de captura (las que permita la cámara). 

src = getselectedsource(vid);

% BacklightCompensation = ‘on’; % ‘off’
% Brightness = 55;
% ColorEnable = ‘on’; % ‘off’
% Contrast = 56;
% FrameRate = '15.0000';
% Gamma = 22;
% HorizontalFlip = ‘off’;
% Saturation = 100;
% VerticalFlip = ‘off’;
% src.BacklightCompensation='off';
% src.Contrast=20;
% src.ColorEnable = 'on'; % ‘off’
% src.FrameRate = '30.000';
% src.Gamma = 22;
% src.Saturation =100;
% src.HorizontalFlip = 'off'; % ‘on’
% src.VerticalFlip = 'on'; %‘off’

preview(vid);

pause(10);

%i=1;

%while i==1
      I = getsnapshot(vid); %función de captura de una imagen
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

%I=im2bw(I,level);

Igray=rgb2gray(I);  %Convierte la imagen a escala de grises 

figure(4)
imshow(uint8(Igray)); 
impixelinfo;

[M,N]=size(Igray);  % determina el tamaño de la imagen.

[Iobjeto,numobjeto] = bwlabel(Igray);

objeto=2;
if numobjeto>0 & objeto<=numobjeto & objeto>0
   If=zeros(M,N); 
   for x=1:M
       for y=1:N
           if Iobjeto(x,y)==objeto
              If(x,y)=255;    
           end;   
       end;    
   end;
   figure(2)
   imshow(uint8(If));
   title('Objeto extraido');
   impixelinfo
   disp(strcat('se han detectado : ',num2str(numobjeto),'objetos'));

else
   disp('no se han detectado objetos o no existe el objeto requerido');
end;   
