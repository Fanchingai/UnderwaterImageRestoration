clc;
clear all;
close all;
% % -----------------------------------------------------
img_path = 'C:\Users\qiqi\Desktop\�˲�����\Guss-conv\ ';
img_name = 'under.bmp' ;
A = imread(strcat(img_path,img_name)) ; 
% figure, imshow(A), title('ԭʼͼ��')

[h,w,c] = size(A);
A1=rgb2hsi(A);  

H = A1(:,:,1) ;
S = A1(:,:,2);
I = A1(:,:,3);
HSI = zeros(h,w,c) ;
HSI(:,:,1) = H ;
HSI(:,:,2) = S ;

I_img=I;
I_img_1=double(I_img);%��֤����
I_img__=im2uint8(I_img_1);
% img_pro=im2double(img);
G_img=fspecial('gaussian',[8 8],2);%�˲�����С����׼ƫ�����Ϊ2
Gimage=imfilter(I_img__,G_img,'conv');%ģ��ͼ��
Gimage1=imfilter(I_img_1,G_img,'conv');%ģ��ͼ��

imwrite(Gimage, strcat(img_path,'Gimage_',img_name)) 
figure, imshow(Gimage),title('ģ��ͼ��') 

imwrite(Gimage1, strcat(img_path,'Gimage1_',img_name)) 
figure, imshow(Gimage1),title('ģ��ͼ��1') 

%-------------------------���˲�-----------------------------
[j, p]=deconvblind(Gimage,G_img,10);
B_img=j;
%imwrite(B_img, strcat(img_path,'B_img_',img_name)) 
figure, imshow(B_img),title('���˲���ԭͼ��') 

%-------------------------ά���˲�---------------------------
W_img=wiener2(Gimage,[3 3],0.1);%�������Ϊ0.1
W_img1=deconvwnr(Gimage1,G_img,0.1);%�������Ϊ0.1
imwrite(W_img1, strcat(img_path,'W_img1_',img_name)) 
figure, imshow(W_img1),title('ά���˲���ԭͼ��') 

%-------------------------�����׾����˲�----------------------
P=sqrt(1./(G_img.^2+0.1));
P_img=filter2(P,Gimage1);
imwrite(P_img, strcat(img_path,'P_img_',img_name)) 
figure, imshow(P_img,[]),title('�����׾��⸴ԭͼ��') 

