function [propertyvalue]=openslide_getpropertyvalue(filepointer,propertynames)
%首先判断openslide库是否已经加载成功
tf=libisloaded('openslidelib');
if tf==0
    warning('openslide库加载失败');
    openslide_loadlibrary();
end
%判断属性名是否是单元格阵列
if iscell(propertynames)
    warning('该属性名为单元格阵列，尝试用第一格作为属性名');
    propertynames = propertynames{1};
end
if isempty(propertynames)
    error('Error.\n 该属性名称不可用');
end
%获得属性值
[propertyvalue] = calllib('openslidelib','openslide_get_property_value',filepointer,propertynames);
end