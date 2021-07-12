function [w,h]=openslide_getlevel0dimensions(filepointer)
w=0;h=0;
%首先判断openslide库是否已经加载成功
tf=libisloaded('openslidelib');
if tf==0
    warning('openslide库加载失败');
    openslide_loadlibrary();
end
%获取0级样本的图像维度
[~,w,h]=calllib('openslidelib','openslide_get_level0_dimensions',filepointer,w,h);
end
