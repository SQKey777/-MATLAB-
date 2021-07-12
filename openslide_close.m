function openslide_close(filepointer)
%首先判断openslide库是否已经加载成功
tf=libisloaded('openslidelib');
if tf==0
    warning('openslide库加载失败');
    openslide_loadlibrary();
end
%关闭整个文件
calllib('openslidelib','openslide_close',filepointer);
end
