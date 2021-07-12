function [width,height,numoflevels,ratio]=picture_getproperty(picturepath)
% % % % % % % filepath  被降采样和切块的图片保存位置
% % % % % % % numoflevel   总的采样层数
% % % % % % % ratio        当前图片的采样比例
Tin=readtable([picturepath,'property.txt']);
Tin=table2array(Tin);
numoflevels=Tin(1,1);ratio=Tin(2,1);
width=Tin(numoflevels,2);height=Tin(numoflevels,3);
end