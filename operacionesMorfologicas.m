clear all; close all; clc;
closepreview;
% vid=videoinput('winvideo',1,'RGB24_352x288');  
% src = getselectedsource(vid);
% 
% preview(vid);
% pause(5);
% 
% I = getsnapshot(vid); %función de captura de una imagen
% figure(100)

I=imread('foto.png'); 
imshow(uint8(I));
impixelinfo;

Igray=rgb2gray(I);  
%% Recuantizacion
% 
% r=8;   % nuevo r (8 tonalidades de gris). 
% 
% %Para hacer procesamiento, los valores de las imágenes tiene que %ser convertidas a datos tipo double.
% 
% Igray=double(Igray); 
% 
% fe=max(max(Igray));
% 
% Irecuan=round(Igray*((2^r)-1)/fe);
% Irecuan=round(Irecuan*fe/((2^r)-1));
% 
% figure(4)
% imshow(uint8(Irecuan));
% impixelinfo;

%% Extraer R, G y B

% [M,N]=size(I);
% RR=I(:,:,1);     %extrae la matriz componente R
% GG=I(:,:,2);     %extrae la matriz componente G
% BB=I(:,:,3);     %extrae la matriz componente B  
% 
% figure(2)
% imshow(uint8(RR));
% impixelinfo;
% 
% figure(3)
% imshow(uint8(GG));
% impixelinfo;
% 
% figure(4)
% imshow(uint8(BB));
% impixelinfo;

%% Otsu

 figure(5)
 imshow(Igray)

figure(2)
%subplot(2,2,1), imshow(Igray); 
%subplot(2,2,2), im2bw(I,0.35);
[counts,X]=imhist(Igray);       %para imagen en escala de grises
P=polyfit(X,counts,6); Y=polyval(P,X);
[V,ind]=sort(abs(diff(Y))); thresh=ind(3)./255;
%subplot(2,2,3), im2bw(I,thresh);   
level=graythresh(I);
%subplot(2,2,4), 
Ibin = im2bw(I,level);
imshow(Ibin);
figure(3); plot(X,counts); hold on, plot(X,Y,'r');

h1=fspecial('average',[9,9]);
Ibin=imfilter(Ibin,h1);

figure(4)
imshow(Ibin);


%% Reduccion de ruido imagen binaria
% 
% %Igray=im2bw(I,level);
% figure(4)
% imshow(Igray)
% 
% fn=imnoise(Igray,'gaussian');
% h1=fspecial('average',[9,9]);
% Igray=imfilter(Igray,h1);
% Igray=medfilt2(Igray);
% 
% 
%  figure(5)
%  imshow(Igray)
% 
% 
% % figure(2)
% % Ibin=im2bw(I,0.35);
% % imshow(Ibin);
%% Deteccion de objetos
[M,N]=size(Ibin);  % determina el tamaño de la imagen.

[Iobjeto,numobjeto] = bwlabel(Ibin);

for i=1:numobjeto
    if numobjeto>0 & i<=numobjeto & i>0
       If=zeros(M,N); 
       for x=1:M
           for y=1:N
               if Iobjeto(x,y)==i
                  If(x,y)=255;    
               end;   
           end;    
       end;
       figure(5+i)
       imshow(uint8(If));
       title('Objeto extraido');
       impixelinfo
    end 
end

%% Area de cada objeto

[f,k] = bwlabel(Ibin,8);
Area=[];
for i=1:k
    ip=find(f==i);
    Area=[Area length(ip)];
end

%% Segmentacion 
% 
% vec_ancho = [];
% vec_largo = [];
% etiquetas=f;
% objetos=k;
% for i = 1:objetos
%     [filas, columnas] = find(etiquetas == i);
%     largo = max(filas) - min(filas) +2;
%     ancho = max(columnas) - min(columnas) +2;
%     vec_ancho = [vec_ancho ancho];
%     vec_largo = [vec_largo largo];
%     target = uint8(zeros([largo ancho]));
%     target1= uint8(zeros([largo ancho]));
%     sy = min(columnas) -1;
%     sx = min(filas) -1;
%     for j = 1: size(filas,1)
%         x = filas(j,1) -sx;
%         y = columnas(j,1) -sy;
%         target(x,y) = (I(filas(j,1),columnas(j,1)));%acorarse del error geenrado por uint8
%         target1(x,y,1)=I(filas(j,1),columnas(j,1),1);%adjuntamos el R de la imagen original a la imagen segmentada 
%         target1(x,y,2)=I(filas(j,1),columnas(j,1),2);%adjuntamos el G de la imagen original a la imagen segmentada 
%         target1(x,y,3)=I(filas(j,1),columnas(j,1),3);%adjuntamos el B de la imagen original a la imagen segmentada         
%     end
%     figure,imshow(target1);%Imprimimos la imagen segmentada
% end