function load=openslide_loadlibrary()
%判断C库是否已经载入
tf=libisloaded('openslidelib');
if tf==1
    disp('openslide库加载成功');load=0;
    return
end
%设置该库的名称
libname='F:\Documents\MATLAB\openslide-win64-20171122\bin\libopenslide-0.dll';
%判断openslide库是否存在
if isempty(which('libname'))
    load=3;error('Error.\n 该库不存在');
end
%获得openslide.h的位置
openslidehfile='F:\Documents\MATLAB\openslide-win64-20171122\include\openslide\openslide.h';
%判断openslide头文件是否存在
if isempty(which('openslidehfile'))
    load=2;error('Error.\n 该头文件不存在');
end
%加载openslide库
loadlibrary(libname,openslidehfile,'alias','openslidelib');
%检查是否加载成功
tf=libisloaded('openslidelib');
if tf==1
    disp('openslide库加载成功');load=0;
%如果未检测到库的存在，则重新加载库
else
    warning('openslide库加载失败');load=1;
end
