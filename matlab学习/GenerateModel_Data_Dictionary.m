function GenerateModel_Data_Dictionary(suffix)% 子文件夹下找后缀为suffix的文件
clc
File_Struct= dir(strcat('.\**\*.',suffix ,'*'));
for i = 1:length(File_Struct)
    Data_name = File_Struct(i).name;
    Data_folder = File_Struct(i).folder;
    Data_path = strcat(Data_folder,'\',Data_name);
    fprintf("%s\n",Data_path);
end




% clc;clear;
% maindir = 'D:\qcc\HDmap_statistics_opendrive\python_code\33782112\';
% subdir  = dir( maindir );
% 
% for i = 1 : length( subdir )
%     if( isequal( subdir( i ).name, '.' )||...
%         isequal( subdir( i ).name, '..')||...
%         subdir( i ).isdir)               % 如果是目录则跳过
%         continue;
%     end
%     subdirpath = fullfile( maindir, subdir( i ).name, '*.txt' );
%     dat = dir( subdirpath )   ;            % 子文件夹下找后缀为dat的文件
% 
%     for j = 1 : length( dat )
%         datpath = fullfile( maindir, subdir( i ).name, dat( j ).name);
%         fid = fopen( datpath );
%         % 此处添加你的对文件读写操作 %　　　　　fclose(fid);
%     end
% end