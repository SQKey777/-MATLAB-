function [error]=openslide_geterror(filepointer)
%首先判断openslide库是否已经加载成功
tf=libisloaded('openslidelib');
if tf==0
    warning('openslide库加载失败');
    openslide_loadlibrary();
end
[error]=calllib('openslidelib','openslide_get_error',filepointer);
end