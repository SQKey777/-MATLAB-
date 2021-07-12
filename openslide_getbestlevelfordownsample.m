function [level]=openslide_getbestlevelfordownsample(filepointer,samplefactor)
%首先判断openslide库是否已经加载成功
tf=libisloaded('openslidelib');
if tf==0
    warning('openslide库加载失败');
    openslide_loadlibrary();
end
%获取用于显示的最佳样本层
[level]=calllib('openslidelib','openslide_get_best_level_for_downsample',filepointer,samplefactor);
end