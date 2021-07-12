function [imagenames]=openslide_getassociatedimagenames(filepointer)
%首先判断openslide库是否已经加载成功
tf=libisloaded('openslidelib');
if tf==0
    warning('openslide库加载失败');
    openslide_loadlibrary();
end
%获得文件的属性名称
[string]=calllib('openslidelib','openslide_get_associated_image_names',filepointer);
%
i=1;
while ~isempty(string(1))
    imagenames(i)=string.value(1);
    string=string+1;i=i+1;
end