function [version]=openslide_getversion()
%首先判断openslide库是否已经加载成功
tf=libisloaded('openslidelib');
if tf==0
    warning('openslide库加载失败');
    openslide_loadlibrary();
end
%检测库的版本
[version]=calllib('openslidelib','openslide_get_version');
end