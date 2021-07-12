% function openslide=openslide()
%openslide加载图像文件

%加载openslide库
openslide_loadlibrary();

%获得程序所在的路径，名字，文件种类（图像文件此时与程序文件在同一文件夹）
p=mfilename('fullpath');[filepath,name,ext]=fileparts(p);
picture=[filepath,filesep,'picture',filesep,'fakejoker.jpg'];

%打开图像文件，创建图像指针
pointer=openslide_open(picture);

%% 加载各个属性
%设置像素起点
x=0;y=0;
%确定文件存在的样本数
[numoflevels]=openslide_getlevelcount(pointer);     
disp(['文件所含的样本数:',num2str(numoflevels)]);level=numoflevels-1;
%确定对应样本层的长宽
[width,height]=openslide_getleveldimensions(pointer,numoflevels-1);   
disp(['第',num2str(level),'样本层的长: ',num2str(width),' 宽:',num2str(height)]);
%确定对应样本层的采样因子
[factor]=openslide_getleveldownsample(pointer,level);
disp(['第',num2str(level),'样本层的采样因子:',num2str(factor)]);
%获得对应样本层的图像   
x=x/factor;y=y/factor;
[ARGB]=openslide_readregion(pointer,x,y,level,width,height);  
figure;
imshow(ARGB(:,:,2:4));
title(['样本层数为:',num2str(level),' ','起点坐标为:',num2str(x),'，',num2str(y),' ','图像维度为:',num2str(width),'，',num2str(height)]);
% imwrite(ARGB(:,:,2:4),'F:\Pictures\test1.jpg');   %显示图像



