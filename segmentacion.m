close all; clear all; clc
global vid
closepreview;
vector_areas = [];
vec_ancho = [];
vec_largo = [];
%image=imread('lenteja.jpg');
%image3=image;
figure(1)
%imshow(image)
vid=videoinput('winvideo',2,'YUY2_1024x768');
videoRes = get(vid, 'VideoResolution');
numberOfBands = get(vid, 'NumberOfBand');
hImage = image(zeros([videoRes(2), videoRes(1),numberOfBands]));
preview(vid,hImage)

imagenesr=[];
imagenesg=[];
imagenesb=[];
for i=1:10
    image=getsnapshot(vid);
imager=image(:,:,1);
imageg=image(:,:,2);
imageb=image(:,:,3);    
end
% imager=round((imagenesr(:,:,1)+imagenesr(:,:,2)+imagenesr(:,:,3)+imagenesr(:,:,4)+imagenesr(:,:,5)+imagenesr(:,:,6)+imagenesr(:,:,7)+imagenesr(:,:,8)+imagenesr(:,:,9)+imagenesr(:,:,10))/10);
% imageb=round((imagenesb(:,:,1)+imagenesb(:,:,2)+imagenesb(:,:,3)+imagenesb(:,:,4)+imagenesb(:,:,5)+imagenesb(:,:,6)+imagenesb(:,:,7)+imagenesb(:,:,8)+imagenesb(:,:,9)+imagenesb(:,:,10))/10);
% imageg=round((imagenesg(:,:,1)+imagenesg(:,:,2)+imagenesg(:,:,3)+imagenesg(:,:,4)+imagenesg(:,:,5)+imagenesg(:,:,6)+imagenesg(:,:,7)+imagenesg(:,:,8)+imagenesg(:,:,9)+imagenesg(:,:,10))/10);
imgprom(:,:,1)=imager;
imgprom(:,:,2)=imageg;
imgprom(:,:,3)=imageb;
%figure(2)
imgprom=uint8(imgprom);
 imshow(imgprom);
 figure(3)
imgprom=ycbcr2rgb(imgprom);
image3=imgprom;
imshow(imgprom)
figure(4)
imgprom=im2bw(image,0.49);
% pallat 39
% arverja 29
% garbanzo lenteja 49


figure(2)

imgprom=not(imgprom);
imshow(imgprom)
%  imshow(not(imgprom))
 %figure(5)
for i=1:20
      imgprom=medfilt2(imgprom);
end
%figure(03)
imgpromnegada=not(imgprom);
imshow(imgpromnegada);

imgprom2= imfill(imgprom,'holes');
imgprom2= imfill(imgprom,'holes');
imgprom2= imfill(imgprom,'holes');
%figure(4) 
imgprom2=not(imgprom2);
imshow(imgprom2)

figure(7)
imgprom3=imgpromnegada-imgprom2;
imgprom3= imfill(imgprom3,'holes');
%  imgprom3=not(imgprom3);
imshow(imgprom3)
etiquetas = bwlabel(imgprom3,4);
objetos = max(max(etiquetas));
for i = 1:objetos
    [filas, columnas] = find(etiquetas == i);
    largo = max(filas) - min(filas) +2;
    ancho = max(columnas) - min(columnas) +2;
    vec_ancho = [vec_ancho ancho];
    vec_largo = [vec_largo largo];
    target = uint8(zeros([largo ancho]));
    target1= uint8(zeros([largo ancho]));
    sy = min(columnas) -1;
    sx = min(filas) -1;
    for j = 1: size(filas,1)
        x = filas(j,1) -sx;
        y = columnas(j,1) -sy;
        target(x,y) = (image3(filas(j,1),columnas(j,1)));%acorarse del error geenrado por uint8
        target1(x,y,1)=image(filas(j,1),columnas(j,1),1);%adjuntamos el R de la imagen original a la imagen segmentada 
        target1(x,y,2)=image(filas(j,1),columnas(j,1),2);%adjuntamos el G de la imagen original a la imagen segmentada 
        target1(x,y,3)=image(filas(j,1),columnas(j,1),3);%adjuntamos el B de la imagen original a la imagen segmentada         
    end
    
    
    area = sum(sum(target(:)));%calculamos el area de la imagen binarizada
    vector_areas = [vector_areas area];%acumulamos las areas en un vector
       
    figure,imshow(target1);%Imprimimos la imagen segmentada
    
end