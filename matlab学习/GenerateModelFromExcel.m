%% 通过表格生成模型框架
function GenerateModelFromExcel()
File_Struct = dir('*.xlsx');
for i = 1:length(File_Struct) %遍历当前路径下的xlsx文件
    Excel_Name = File_Struct(i).name;
    Model_Name = strrep(Excel_Name,'.xlsx','');
    new_system(Model_Name);%创建模型
    open_system(Model_Name);%打开模型
    [~,Sheet_Cell] = xlsfinfo(Excel_Name);
    for j = 1:length(Sheet_Cell) %遍历当前Excel中的Sheet页
        Sheet_Name = Sheet_Cell{j};
        add_block('simulink/Ports & Subsystems/Subsystem',[Model_Name,'/',Sheet_Name]);
        Line_Handle = find_system([Model_Name,'/',Sheet_Name],'FindAll','on','Type','Line');
        delete(Line_Handle);delete_block([Model_Name,'/',Sheet_Name,'/In1']);delete_block([Model_Name,'/',Sheet_Name,'/Out1']);
        [~,~,ExcelContent_Cell] = xlsread(Excel_Name,Sheet_Name);
        PortNum = 1;
        for row = 2:size(ExcelContent_Cell,1) %遍历当前Sheet页的每一行
            if ~isnan(ExcelContent_Cell{row,1})%在子系统内外层添加Inport模块
                Inport_Name = ExcelContent_Cell{row,1};
                Inport_Type = ExcelContent_Cell{row,2};
                add_block('simulink/Ports & Subsystems/In1',[Model_Name,'/',Sheet_Name,'/',Inport_Name]);
                set_param([Model_Name,'/',Sheet_Name,'/',Inport_Name],'DataType',Inport_Type);
                add_block('simulink/Ports & Subsystems/In1',[Model_Name,'/',Inport_Name]);
                set_param([Model_Name,'/',Inport_Name],'DataType',Inport_Type);
                add_line(Model_Name,[Inport_Name,'/1'],[Sheet_Name,'/',num2str(PortNum)]);
            end
            if ~isnan(ExcelContent_Cell{row,3})%在子系统内外层添加Outport模块
                Outport_Name = ExcelContent_Cell{row,3};
                Outport_Type = ExcelContent_Cell{row,4};
                add_block('simulink/Ports & Subsystems/Out1',[Model_Name,'/',Sheet_Name,'/',Outport_Name]);
                set_param([Model_Name,'/',Sheet_Name,'/',Outport_Name],'DataType',Outport_Type);
                add_block('simulink/Ports & Subsystems/Out1',[Model_Name,'/',Outport_Name]);
                set_param([Model_Name,'/',Outport_Name],'DataType',Outport_Type);
                add_line(Model_Name,[Sheet_Name,'/',num2str(PortNum)],[Outport_Name,'/1']);
            end
            PortNum = PortNum + 1;
        end        
    end
    save_system(Model_Name);
    close_system(Model_Name)
    
end

end
