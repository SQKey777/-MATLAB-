function [w,h]=openslide_getleveldimensions(filepointer,level)
w=0;h=0;
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
%获取指定样本层的图像维度
[~,w,h]=calllib('openslidelib','openslide_get_level_dimensions',filepointer,level,w,h);
end