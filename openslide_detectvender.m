function [vender]=openslide_detectvender(filename)
%首先判断openslide库是否已经加载成功
tf=libisloaded('openslidelib');
if tf==0
    warning('openslide库加载失败');
    openslide_loadlibrary();
end
%检测文件的供应商
[vender]=calllib('openslidelib','openslide_detect_vender',filename);
end