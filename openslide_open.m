function filepointer=openslide_open(filename)
%首先判断openslide库是否已经加载成功
tf=libisloaded('openslidelib');
if tf==0
    warning('openslide库加载失败');
    openslide_loadlibrary();
end
%获取文件对应的指针
filepointer=calllib('openslidelib','openslide_open',filename);
%判断指针是否顺利生成
if isempty(filepointer)
    errorwarning('Error.\n 该指针生成失败');
    filepointer=calllib('openslidelib','openslide_open',filename);
end

end