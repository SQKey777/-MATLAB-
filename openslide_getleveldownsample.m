function [samplefactor]=openslide_getleveldownsample(filepointer,level)
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
%得到指定样本层的下采样因子(放大倍数)
[samplefactor]=calllib('openslidelib','openslide_get_level_downsample',filepointer,level);
end