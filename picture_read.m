function [pic]=picture_read(picturepath,x,y,level,w,h,class)
% % % % % % % filepath 被降采样和切块的图片保存位置
% % % % % % % x,y      图片左上角起点坐标
% % % % % % % w,h      图片长和宽
% % % % % % % level    指定的采样层
% picturepath='F:\Pictures\test\';x=1000;y=1000;level=4;w=515;h=719;class='.jpg';
x=round(x);y=round(y);
[width,height,numoflevels,ratio]=picture_getproperty(picturepath);
Tin=readtable([picturepath,'property.txt']);Tin=table2array(Tin);
%判断制定的坐标指数是否可以使用
if level>numoflevels-1
    level=numoflevels-1;
elseif level<0
    level=0;
end
Width=Tin(level+1,2);Height=Tin(level+1,3);
if x+width>Width
     x=Width-width+1;
end
if y+height>Height
     y=Height-height+1;
end
if x<1
    x=1;
end
if y<1
    y=1;
end
%确定图片的相对坐标
N=ratio^(numoflevels-level-1);%确定对应样本层的“横纵碎片数”
x0=ceil(x/width);y0=ceil(y/height);%左上角的起点坐标
if x0==0
    x0=1;
end
if y0==0
    y0=1;
end
x1=ceil((x+w-1)/width);y1=ceil((y+h-1)/height);%右下角的起点坐标
%将范围内的所有图像汇集成一个大图像
x2=(x1-x0+1)*width;y2=(y1-y0+1)*height;
picture=zeros(x2,y2,3);pic=zeros(width,height,3);
i=x0;
for a=1:width:x2
    j=y0;
    for b=1:height:y2
        name=(i-1)*N+j;%确定对应图片的名称
        pic=imread([picturepath,num2str(level),'\',num2str(name),class]);%获取对应的图片碎片
        picture(a:1:a+width-1,b:1:b+height-1,1:3)=pic(1:1:width,1:1:height,1:3);
        j=j+1;
    end
    i=i+1;
end
%对图像进行截取
pic=zeros(w,h,3);
x=rem(x,width);y=rem(y,height);
if x==0
    x=1;
end
if y==0
    y=1;
end
pic(1:1:w,1:1:h,1:3)=picture(x:1:x+w-1,y:1:y+h-1,1:3);
pic=uint8(pic);
% imshow(pic);
end
