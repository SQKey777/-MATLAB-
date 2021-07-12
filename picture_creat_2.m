function picture_creat_2(picname,picpath,numx,numy,wid,hei,ratio,class,kind)
% picname='F:\Pictures\hhhhh\';picpath='F:\Pictures\myfinaljob\';
% numx=16;numy=16;wid=1000;hei=1000;ratio=2;class='.jpg';
bar=waitbar(0,'正在确定采样层请稍后');
file=dir(fullfile([picname,'*',class]));
pic=imread([picname,file(1).name]);[w,h]=size(pic);h=h/3;
Width=numy*w;Height=numx*h;num=numx*numy;name=0;level=1;width=Width;height=Height;
%确定采样层数并创建相应的文件夹
while((width>wid)||(height>hei))
    width=round(width/ratio);height=round(height/ratio);    
    mkdir(picpath,num2str(level-1));
    level=level+1;
end
mkdir(picpath,num2str(level-1));
w0=round(Width/width)*width;h0=round(Height/height)*height;
waitbar(1/4,bar,'已确定采样层数并创建相应的文件夹,正在对图像进行初步切割');
%对现有碎片图层进行初步切割
numofpic=1;
for i=1:width:Width
    for j=1:height:Height
        %确定左上角和右下角相对坐标
        y1=ceil(i/w);x1=ceil(j/h);y2=ceil((i+width-1)/w);x2=ceil((j+height-1)/h);
        if x1>numx
            x1=numx;
        end
        if x2>numx
            x2=numx;
        end
        if y1>numy
            y1=numy;
        end
        if y2>numy
            y2=numy;
        end
        x=x2-x1+1;y=y2-y1+1;inipic=zeros(y*w,x*h);
        %将所有图片汇聚成大图
        f=y1;
        for a=1:w:y*w
            g=x1;
            for b=1:h:x*h
                name=(f-1)*numx+g;
                %加载不同命名种类的图片
                if kind==2
                    pic=imread([picname,file(name).name]);
                elseif kind==1
                    pic=imread([picname,num2str(name),class]);
                end
                inipic(a:1:a+w-1,b:1:b+h-1,1:3)=pic(1:1:w,1:1:h,1:3);
                g=g+1;
            end
            f=f+1;
        end
        %对图片进行截取
        pic=zeros(width,height,3);
        ii=rem(i,w);jj=rem(j,h);
        if ii==0
            ii=1;
        end
        if jj==0
            jj=1;
        end
        [ww,hh]=size(inipic);hh=hh/3;pic=zeros(width,height,3);
        if ((ii+width-1)<=ww&&(jj+height-1)<=hh)
            pic(1:1:width,1:1:height,1:3)=inipic(ii:1:ii+width-1,jj:1:jj+height-1,1:3);
        elseif ((ii+width-1)>ww&&(jj+height-1)>hh)
            pic(1:1:ww-ii+1,1:1:hh-jj+1,1:3)=inipic(ii:1:end,jj:1:end,1:3);
        elseif ((ii+width-1)>ww&&(jj+height-1)<=hh)
            pic(1:1:ww-ii+1,1:1:height,1:3)=inipic(ii:1:end,jj:1:jj+height-1,1:3);
        elseif ((ii+width-1)<=ww&&(jj+height-1)>hh)
            pic(1:1:width,1:1:hh-jj+1,1:3)=inipic(ii:1:ii+width-1,jj:1:end,1:3);
        end
        pic=uint8(pic);
        imwrite(pic,[picpath,'0\',num2str(numofpic),class]);
        numofpic=numofpic+1;
    end
end
waitbar(2/4,bar,'已完成对图像的初步切割，正在记录各样本层数据');
%记录各样本层的数据
nature=zeros(level,1);levelwidth=zeros(level,1);levelheight=zeros(level,1);
nature(1,1)=level;nature(2,1)=ratio;
width2=w0;height2=h0;
for i=1:1:level
    levelwidth(i,1)=width2;levelheight(i,1)=height2;
    width2=width2/ratio;height2=height2/ratio;
end
Tout=table(nature,levelwidth,levelheight);
writetable(Tout,[picpath,'property.txt']);
waitbar(3/4,bar,'已完成各样本层的数据记录，正在进行降采样');
%对后续图片进行降采样
name=0;
while(name<level-1)
    [w2,h2]=picture_getleveldimension(picpath,name);
    numy=w2/width;numx=h2/height;number=1;
    for i=1:ratio:numy
        for j=1:ratio:numx
            inipic=zeros(width*ratio,height*ratio,3);
            for a=i:1:i+ratio-1 
                for b=j:1:j+ratio-1
                    num=(a-1)*numx+b;aa=rem(a,i)+1;bb=rem(b,j)+1;
                    if a==ratio&&i==1
                        aa=ratio;
                    end
                    if b==ratio&&j==1
                        bb=ratio;
                    end
                    pic=imread([picpath,num2str(name),'\',num2str(num),class]);
                    inipic((aa-1)*width+1:1:aa*width,(bb-1)*height+1:1:bb*height,1:3)=pic(1:1:end,1:1:end,1:3);
                end
            end
            finpic=inipic(1:ratio:end,1:ratio:end,1:3);finpic=uint8(finpic);
            imwrite(finpic,[picpath,num2str(name+1),'\',num2str(number),class]);
            number=number+1;
        end
    end
    name=name+1;
end
waitbar(4/4,bar,'已完成降采样，请点击显示图像');