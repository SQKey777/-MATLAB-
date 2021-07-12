function [ARGB]=openslide_motionregion(filepointer,x,y,level,w,h)
%首先判断openslide库是否已经加载成功
tf=libisloaded('openslidelib');
if tf==0
    warning('openslide库加载失败');
    openslide_loadlibrary();
end
%判断指定的样本层数是否存在
[levelcount]=openslide_getlevelcount(filepointer);
if level>=levelcount
    error('Error.\n 该样本层不存在');
end
%获取对应样本层的图像维度
[width,height]=openslide_getleveldimensions(filepointer,level);
%判断制定的坐标指数是否可以使用
% x1=x;y1=y;
if x+w>width
     x=width-w;
end
if y+h>height
     y=height-h;
end
if x<0
    x=0;
end
if y<0
    y=0;
end
%将指定的像素起点对应到相应的样本层
samplefactor=openslide_getleveldownsample(filepointer,level);
x = x*samplefactor;y = y*samplefactor;
%从整个图像中复制预乘的ARGB数据
dest=uint32(zeros(w*h,1));
region=libpointer('uint32Ptr',dest);
[~,region]=calllib('openslidelib','openslide_read_region',filepointer,region,int64(x),int64(y),int64(level),int64(w),int64(h));
%强制转换和重新格式化读取数据
RGBA = typecast(region,'uint8');
ARGB = uint8(zeros(w,h,4));
ARGB(:,:,1) = reshape(RGBA(4:4:end),w,h);
ARGB(:,:,2) = reshape(RGBA(3:4:end),w,h);
ARGB(:,:,3) = reshape(RGBA(2:4:end),w,h);
ARGB(:,:,4) = reshape(RGBA(1:4:end),w,h);
%对图像进行排列，确保它符合标准的MATLAB格式
ARGB = permute(ARGB,[2 1 3]);