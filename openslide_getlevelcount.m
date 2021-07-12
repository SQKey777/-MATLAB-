function [levelcount]=openslide_getlevelcount(filepointer)
%首先判断openslide库是否已经加载成功
tf=libisloaded('openslidelib');
if tf==0
    warning('openslide库加载失败');
    openslide_loadlibrary();
end
%获得文件总样本层数
[levelcount]=calllib('openslidelib','openslide_get_level_count',filepointer);
end