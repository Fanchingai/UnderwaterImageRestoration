% % % ��ӽ�������
% % % %%-------------------------------------------
clc;
clear all;
close all;
% % -----------------------------------------------------
img_path = 'C:\Users\qiqi\Desktop\�½��ļ���\����\ ';
img_name = 'under.bmp' ;
A = imread(strcat(img_path,img_name)) ;  
[h,w,c] = size(A);
A1=rgb2hsi(A);  

H = A1(:,:,1) ;
S = A1(:,:,2);
I = A1(:,:,3);
HSI = zeros(h,w,c) ;
HSI(:,:,1) = H ;
HSI(:,:,2) = S ;

%��ӽ�������
noi_I=imnoise(I,'salt & pepper',0.02);%����ǿ��Ϊ0.02�Ľ�������
imwrite(noi_I, strcat(img_path,'salt_',img_name)) 
figure, imshow(noi_I),title('��ӽ���������') 

% % %  ����3��3��ƽ�����ڶ���ͼ������ֵ�˲�
med_I=medfilt2(noi_I,[3 3]);
imwrite(med_I, strcat(img_path,'salt_med_',img_name)) 
figure, imshow(med_I),title('�������� ��ֵ�˲���') 

% % %  ����3��3��ƽ�����ڶ���ͼ������ֵ�˲�
filt1 = fspecial('average',[4 4]);%����3*3�ľ�ֵ�˲���
mean_I = imfilter(noi_I,filt1,'replicate');%�˲�,ͨ�����Ʊ߽�ֵ��չͼ��߽�

imwrite(mean_I , strcat(img_path,'salt_mean_',img_name)) 
figure, imshow(mean_I ),title('�������� ��ֵ�˲���') 







