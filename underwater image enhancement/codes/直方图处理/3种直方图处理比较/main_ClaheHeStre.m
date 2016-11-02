%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  �� �Աȶ����죬ֱ��ͼ���⣬���ƶԱȶ�����Ӧ����
% %  ����ͼ������ ���бȽϣ�
% %  ���۷������ء��Աȶȡ�ƽ���ݶ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc ;
clear all;

srcDir=uigetdir('D:\ͼ��ԭ����\����\ֱ��ͼ����\pipe_1\'); %���ѡ����ļ���
cd(srcDir) ;
allnames=struct2cell(dir('*.bmp')); 
[k,img_number]=size(allnames); %���ͼƬ�ļ��ĸ���

store_path = 'D:\ͼ��ԭ����\����\ֱ��ͼ����\main-ClaheHeStre���ͼ\' ;%������ͼƬ�洢·��

gradient_result = zeros(img_number,4) ;
contrast_result = zeros(img_number,4) ;
entropy_result = zeros(img_number,4) ;

for number=1 : img_number    %���ȡ���ļ�
    
    img_name=allnames{1,number} ;
    RGBimg=imread( img_name) ;
    img_ori = double(RGBimg) ;
    [h, w, c] = size(img_ori) ;
    
    R= img_ori(:,:,1) ;
    G= img_ori(:,:,2) ;    
    B= img_ori(:,:,3) ;
    
% % % --------------ֱ��ͼ����--------------------% %
%     %%%%��ͨ�����о���%%%%
%     RGB_eq = HistEq(img_ori) ;
%     R_eq = RGB_eq(:,:,1) ;
%     G_eq = RGB_eq(:,:,2) ;
%     B_eq = RGB_eq(:,:,3) ;
%     %%%%%%%%%%%%%%%
    %%%��hsv�ռ���о���%%%
    hsv_img=rgb2hsv(img_ori);
    I = hsv_img(:,:,3) ;
%     hsv_img(:,:,3) = histeq(V)*255;%��MATLAB�Դ�����
    hsv_img(:,:,3) = HistEq(I);%�Ա�ֱ��ͼ�������
    RGB_eq=hsv2rgb(hsv_img);
% % %---------------------------------------------------------------

% % % -------------�Աȶ�����---------------------% %
    reR = reshape(R,h*w,1) ;
    reG = reshape(G,h*w,1) ;
    reB = reshape(B,h*w,1) ;

    [sort_R,index_R] = sort(reR, 'ascend') ;
    [sort_G,index_G] = sort(reG, 'ascend') ;
    [sort_B,index_B] = sort(reB, 'ascend') ;
    
    cutRate = 0.002; %%�ü�����
    limit = round(cutRate*h*w) ;
    
    R_stretch = ContrastStretch(R, sort_R(1),sort_R(h*w-limit),sort_G(limit),sort_B(h*w)) ;
    G_stretch = ContrastStretch(G, sort_G(limit),sort_R(h*w),sort_R(limit),sort_B(h*w-limit)) ;
    B_stretch = ContrastStretch(B, sort_B(1),sort_B(h*w),sort_R(1),sort_B(h*w-limit)) ;
% % % % --------------------------------------------------------------------------------------

% % % % -------���ƶԱȶ�����Ӧֱ��ͼ����----------% % %
    clip_limit = 0.03 ;%����ֱ��ͼ�ü�����
    tile_num = [round(h/100),round(w/100)] ;%%�ֿ���
%     tile_num  = [6,8] ;
    if tile_num(1)<2
        tile_num(1)=2;
    end
    if tile_num(2)<2
        tile_num(2)=2;
    end
    
%     %%%%%----------��ͨ������-------------------%%
%     RGB_clahe = zeros(h,w,c,'double') ;
%     RGB_clahe(:,:,1) = adapthisteq(R,'NumTiles', tile_num,'ClipLimit',clip_limit);
%     RGB_clahe(:,:,2) = adapthisteq(G,'NumTiles', tile_num,'ClipLimit',clip_limit);
%     RGB_clahe(:,:,3) = adapthisteq(B,'NumTiles', tile_num,'ClipLimit',clip_limit);
%     %%%%%---------------------------------------------------------------------
    
    %%%%--------��hsv�ռ���о���------------%%
    hsv_img=rgb2hsv(RGBimg);
    hsv_img(:,:,3) = adapthisteq(hsv_img(:,:,3),'NumTiles', tile_num,'ClipLimit',clip_limit);
    RGB_clahe=hsv2rgb(hsv_img);
%     figure, imshow(RGB_clahe),title('HSV clahe');
%%%%-----------------------------------------------------------------------------
   
% % % -----------------�洢������-------------------% %
    imwrite(uint8(RGB_eq), strcat(store_path,'eq_',img_name))
   
    RGB_stretch = zeros(h,w,c,'double') ;
    RGB_stretch(:,:,1) = R_stretch ;
    RGB_stretch(:,:,2) = G_stretch ;
    RGB_stretch(:,:,3) = B_stretch ;
    imwrite(uint8(RGB_stretch), strcat(store_path,'stretch_',img_name))
    
    imwrite(RGB_clahe, strcat(store_path,'clahe_',num2str(clip_limit),'_',img_name))
% % % --------------------------------------------------------------------------------------% %

%     subplot(2,2,1), subimage(RGBimg);
%     xlabel('(a)ԭʼͼ��','FontSize',12,'FontName','����','color','b');
%     subplot(2,2,2), subimage(uint8(RGB_eq));
%     xlabel('(b)HE����','FontSize',12,'FontName','����','color','b');
%     subplot(2,2,3), subimage(uint8(RGB_stretch));
%     xlabel('(c)�Աȶ�����','FontSize',12,'FontName','����','color','b');
%     subplot(2,2,4), subimage(RGB_clahe);
%     xlabel('(a)CLAHE����','FontSize',12,'FontName','����','color','b');
    
% % % %------------------ͼ����������------------------%%%
    %%%%%--------����ƽ���ݶ�------------%%%%
    gradient_result(number,1) = avg_gradient(RGBimg) ;
    gradient_result(number,2) = avg_gradient(uint8(RGB_eq)) ;
    gradient_result(number,3) = avg_gradient(uint8(RGB_stretch)) ;
    gradient_result(number,4) = avg_gradient(uint8(RGB_clahe*255)) ;  
    %%%%%%%----------------------------%%%
    
    %%%%%---------����Աȶ�-----------%%%%
    contrast_result(number,1) = CalculateContrast(RGBimg) ;
    contrast_result(number,2) = CalculateContrast(uint8(RGB_eq)) ;
    contrast_result(number,3) = CalculateContrast(uint8(RGB_stretch)) ;
    contrast_result(number,4) = CalculateContrast(uint8(RGB_clahe*255)) ;
    %%%%--------------------------------%%%%
    
    %%%%%-----------������------------%%%%
    entropy_result(number,1) = entropy(RGBimg) ;
    entropy_result(number,2) = entropy(uint8(RGB_eq)) ;
    entropy_result(number,3) = entropy(uint8(RGB_stretch)) ;
    entropy_result(number,4) = entropy(uint8(RGB_clahe*255)) ;
    %%%%%-------------------------%%%%%
% % % % ------------------------------------------------------%%

end
xlswrite('D:\ͼ��ԭ����\����\ֱ��ͼ����\���\ClaheHeStre_gradient.xls',gradient_result);
xlswrite('D:\ͼ��ԭ����\����\ֱ��ͼ����\���\ClaheHeStre_contrast.xls',contrast_result);
xlswrite('D:\ͼ��ԭ����\����\ֱ��ͼ����\���\ClaheHeStre_entropy.xls',entropy_result);
