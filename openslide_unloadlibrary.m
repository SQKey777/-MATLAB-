function openslide_unloadlibrary()
%检查库是否已经被关闭
tf=libisloaded('openslidelib');
if tf==0
    disp('openslide库已经关闭');
    return
end
%关闭库
unloadlibrary('openslidelib');
%检查库是否已经被关闭
tf=libisloaded('openslidelib');
if tf==0
    disp('openslide库已经关闭');
else
    error('openslide库关闭失败');
end