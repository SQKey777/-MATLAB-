function [width,height]=picture_getleveldimension(picturepath,level)
Tin=readtable([picturepath,'property.txt']);
Tin=table2array(Tin);
width=Tin(level+1,2);height=Tin(level+1,3);
end