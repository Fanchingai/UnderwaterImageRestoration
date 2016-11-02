%% ����ͼ��ת��Ϊ�Ҷ�ͼ
clear;
clc;
% I=imread('C:\Users\qiqi\Desktop\�½��ļ���\�����˲�.bmp');%��ȡͼ��
I=imread('C:\Users\qiqi\Desktop\�˲�����\�����˲�\under.bmp');%��ȡͼ��
I_gray=rgb2gray(I);       %ת��Ϊ�Ҷ�ͼ��
subplot(2,1,1);
imshow(I_gray);           
title('ԭʼͼ');                      %��ʾԭͼ

I_fft=fft2(I_gray);                     %��ͼ����и���Ҷ�任
I_shift=fftshift(I_fft);    %�Ա任��ͼ����ж����仯������������ƽ�ƣ�ʹ�����Ļ�
%I_shift=gscale(I_shift);                %��Ƶ��ͼ������0-256�ķ�Χ��
%imshow(I_shift)                         %��ʾƵ��ͼ��
 %sw=1;                       %BLPF
 %sw=2;                       %GLPF
 %sw=3;                       %BHPF
sw=4;                       %GHPF
%% Butterworth LPF ��ͨ�˲���
if sw==1
    [M,N]=size(I_shift);
    nn=2;           % ���װ�����˹(Butterworth)��ͨ�˲���
    d0=100;         % �޸��ܹ�������ֹƵ��
    m=fix(M/2); n=fix(N/2);
    for i=1:M
           for j=1:N
               d=sqrt((i-m)^2+(j-n)^2);
               h1=1/(1+(d/d0)^(2*nn));  % �����ͨ�˲������ݺ���
               result1(i,j)=h1*I_shift(i,j);
           end
    end
    % ���������ƶ�������λ�ã���ЧΪresult1(x,y)=result1(x,y)*(-1)^(x+y);
    result1=ifftshift(result1); 
    J2=ifft2(result1);
    J3=uint8(real(J2));
    subplot(2,1,2);
    imshow(J3);
    title('BLPF�˲�ͼ');        % ��ʾ�˲�������ͼ��
end
%% Gaussian LPF ��ͨ�˲���
if sw==2
    [M,N]=size(I_shift);
    d0=100;                                   % �޸��ܹ�������ֹƵ��
    m=fix(M/2); n=fix(N/2);
    for i=1:M
        for j=1:N
            d=(i-m)^2+(j-n)^2;
            temp=d/(2*(d0^2));
            h1=exp(-temp);
            result1(i,j)=h1*I_shift(i,j);
        end
    end
    result1=ifftshift(result1);
    J2=ifft2(result1);
    J3=uint8(real(J2));
    subplot(2,1,2);
    imshow(J3);
    title('GLPF�˲�ͼ');                      % ��ʾ�˲�������ͼ��
end
%% Butterworth HPF ��ͨ�˲���
if sw==3
    [M,N]=size(I_shift);
    nn=2;           % ���װ�����˹(Butterworth)��ͨ�˲���
    d0=20;          % ��ֹƵ��
    m=fix(M/2); n=fix(N/2);
    for i=1:M
           for j=1:N
               d=sqrt((i-m)^2+(j-n)^2);
               h1=1/(1+(d0/d)^(2*nn));  % �����ͨ�˲������ݺ���
               result1(i,j)=h1*I_shift(i,j);
           end
    end
    result1=ifftshift(result1);
    J2=ifft2(result1);
    J3=uint8(real(J2));
    subplot(2,1,2);
    imshow(J3);
    title('BHPF�˲�ͼ');                      % ��ʾ�˲�������ͼ��
end
%% Gaussian HPF ��ͨ�˲���
if sw==4
    [M,N]=size(I_shift);
    d0=10;                                  % ��ֹƵ��
    m=fix(M/2); n=fix(N/2);
    for i=1:M
        for j=1:N
            d=(i-m)^2+(j-n)^2;
            temp=d/(2*(d0^2));
            h1=1-exp(-temp);
            result1(i,j)=h1*I_shift(i,j);
        end
    end
    result1=ifftshift(result1);
    J2=ifft2(result1);
    J3=uint8(real(J2));
    subplot(2,1,2);
    imshow(J3);
    title('GHPF�˲�ͼ');                      % ��ʾ�˲�������ͼ��
end
