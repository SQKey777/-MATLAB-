function [AGRB]=openslide_readassociatedimage(filepointer,imagenames)
%首先判断openslide库是否已经加载成功
tf=libisloaded('openslidelib');
if tf==0
    warning('openslide库加载失败');
    openslide_loadlibrary();
end
%判断属性名是否是单元格阵列
if iscell(imagenames)
    warning('该属性名为单元格阵列，尝试用第一格作为属性名');
    propertynames = propertynames{1};
end
if isempty(propertynames)
    error('Error.\n 该属性名称不可用');
end
[w,h]=openslide_getassociatedimagedimensions(filepointer,imagenames);
%从整个图像中复制预乘的ARGB数据
dest=uint32(zeros(w*h,1));
region=libpointer('uint32ptr',dest);
[~,~,region]=calllib('openslidelib','openslide_read_region',filepointer,iamgenames,region);
%强制转换和重新格式化读取数据
RGBA = typecast(region,'uint8');
ARGB = uint8(zeros(width,height,4));
ARGB(:,:,1) = reshape(RGBA(4:4:end),width,height);
ARGB(:,:,2) = reshape(RGBA(3:4:end),width,height);
ARGB(:,:,3) = reshape(RGBA(2:4:end),width,height);
ARGB(:,:,4) = reshape(RGBA(1:4:end),width,height);
%对图像进行排列，确保它符合标准的MATLAB格式
ARGB = permute(ARGB,[2 1 3]);
end