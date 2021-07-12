function [propertynames]=openslide_getpropertynames(filepointer)
%首先判断openslide库是否已经加载成功
tf=libisloaded('openslidelib');
if tf==0
    warning('openslide库加载失败');
    openslide_loadlibrary();
end
%获得文件的属性名称
[string]=calllib('openslidelib','openslide_get_property_names',filepointer);
%
i=1;
while ~isempty(string(1))
    propertynames(i)=string.value(1);
    string=string+1;i=i+1;
end

end
