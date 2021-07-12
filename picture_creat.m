function picture_creat(picturename,picturepath,wid,hei,ratio,class)
% % % % % % % filename   要读取的文件名称
% % % % % % % filepath   降采样和切块后的文件储存位置
% % % % % % % wid,hei   限定最低采样的大小
% % % % % % % ratio      采样的比例
% % % % % % % class      获得的图片保存类型
%读取图片，设置采样比例，判断采样层数。
% picturepath='F:\Pictures\test\';ratio=2;class='.jpg';wid=1000;hei=1000;picturename='F:\Pictures\test.jpg';
bar=waitbar(0,'正在确定采样层请稍后');
Picture=imread(picturename);name=0;
mkdir(picturepath);
imwrite(Picture,[picturepath,num2str(name),class]);
[Width,Height]=size(Picture);Height=Height/3;
width=Width;height=Height;level=1;
%确定采样层数并创建相应的文件夹
while(width>wid)||(height>hei)
    width=round(width/ratio);height=round(height/ratio);    
    mkdir(picturepath,num2str(level-1));
    level=level+1;
end
mkdir(picturepath,num2str(level-1));
waitbar(1/4,bar,'已确定采样层数并创建相应的文件夹,正在降采样');
%记录样本数和比例
nature=zeros(level,1);
nature(1,1)=level;nature(2,1)=ratio;
%对大图进行将采样处理，获得各个小图
while(name<level-1)
    picture=imread([picturepath,num2str(name),class]);
    pic=picture(1:ratio:end,1:ratio:end,1:1:3);
    name=name+1;pic=uint8(pic);
    imwrite(pic,[picturepath,num2str(name),class]);
end
waitbar(2/4,bar,'已完成原图像的降采样工作，正在切块');
%之后就可以对各个图片进行切割处理
level2=level;name=0;
while(level2>0)
    picture=imread([picturepath,num2str(name),class]);
    [w,h]=size(picture);num=1;h=h/3;
    w=ceil(w/width)*width;h=ceil(h/height)*height;pic1=zeros(w,h,3);
    %对图像进行补全
    pic1=uint8(pic1);[w,h]=size(picture);h=h/3;
    pic1(1:1:w,1:1:h,1:3)=picture(1:1:w,1:1:h,1:3);
    %读取一个图片
    [w,h]=size(pic1);h=h/3;pic=zeros(width,height,3);
    for i=1:width:w
        for j=1:height:h
            a=i;b=j;
            %读取其中一个区域
            pic(1:1:width,1:1:height,1:3)=pic1(a:1:a+width-1,b:1:b+height-1,1:3);
            pic=uint8(pic);path=[picturepath,num2str(name),'\'];
            imwrite(pic,[path,num2str(num),class]);num=num+1;
        end
    end
    level2=level2-1;name=name+1;
end
waitbar(3/4,bar,'已完成对各采样图的切块处理,正在补全采样图像');
%对图像进行补全
num=level-1;levelwidth(level,1)=width;levelheight(level,1)=height;
while(num>0)
    [w,h]=size(imread([picturepath,num2str(num),class]));h=h/3;
    levelwidth(num,1)=w*ratio;levelheight(num,1)=h*ratio;num=num-1;
    picture=imread([picturepath,num2str(num),class]);
    pic=zeros(w*ratio,h*ratio,3);[w,h]=size(picture);h=h/3;pic=uint8(pic);
    pic(1:1:w,1:1:h,1:3)=picture(1:1:w,1:1:h,1:3);
    imwrite(pic,[picturepath,num2str(num),class]);
end
Tout=table(nature,levelwidth,levelheight);
writetable(Tout,[picturepath,'property.txt']);
waitbar(1,bar,'已实现对各采样图的补全，请点击显示图像');
end