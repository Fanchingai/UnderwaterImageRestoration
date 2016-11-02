function Fcontrast = CalculateContrast(I)
%%%%%%%%%%%%%%%%%%%%%%
% % % �Աȶȼ���
%%%%%%%%%%%%%%%%%%%%%%
[Nx,Ny,c] = size(I) ;
if c == 3
    I_gray=rgb2gray(I); 
else
    I_gray = I ;
end

Ng=256;
G=double(I_gray);

%����Աȶ�
[counts,graylevels]=imhist(I_gray);
PI=counts/(Nx*Ny);
averagevalue=sum(graylevels.*PI);
u4=sum((graylevels-repmat(averagevalue,[256,1])).^4.*PI);
standarddeviation=sum((graylevels-repmat(averagevalue,[256,1])).^2.*PI);
alpha4=u4/standarddeviation^2;
Fcontrast=sqrt(standarddeviation)/alpha4.^(1/4);
