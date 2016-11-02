% �������ͼ�� �ֱ���HSV�ռ��RGB�ռ� �������ƶԱȶ�����Ӧֱ��ͼ���� 

close all
clear all
clc

clip_limit = 0.017 ;%%�ü�����
tile_num  = [12,6] ;  %%%���зֿ���

img_path = 'C:\Users\qiqi\Desktop\ͼ����ǿ����\ֱ��ͼ����\CLAHE\' ;
img_name = 'ͼƬ3.bmp';

RGB_img = imread(strcat(img_path,img_name));
hsv_img=rgb2hsv(RGB_img);
V = hsv_img; 

% % % % Perform CLAHE
V(:,:,3) = adapthisteq(V(:,:,3),'NumTiles', tile_num,'ClipLimit',clip_limit);
% % % % Convert back to RGB_img color space
RGB_img1=hsv2rgb(V);
% % % %  Display the results
figure, imshow(RGB_img); 
figure, imshow(RGB_img1),title('HSV clahe');
%oldresults(RGB_img,RGB_img1);
% % % % contrast gain

im = double(rgb2gray(RGB_img));
op = double(rgb2gray(RGB_img1));
[M, ~] = size(im);

% RGB_img
RGB_img1(:,:,1) = adapthisteq(RGB_img(:,:,1),'NumTiles', tile_num,'ClipLimit',clip_limit);
RGB_img1(:,:,2) = adapthisteq(RGB_img(:,:,2),'NumTiles', tile_num,'ClipLimit',clip_limit);
RGB_img1(:,:,3) = adapthisteq(RGB_img(:,:,3),'NumTiles', tile_num,'ClipLimit',clip_limit);

figure, imshow(uint8(RGB_img1)),title('RGB clahe');


