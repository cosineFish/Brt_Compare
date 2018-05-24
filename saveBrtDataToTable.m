function [time_with_data,delta_brt_k,delta_brt_v] = saveBrtDataToTable(HRA_time,HRA_K_Brt,HRA_V_Brt ,RPG_time,RPG_K_Brt,RPG_V_Brt)
    global xlsFilePath;
    global dateStr;
    global K_frequency_group;
    global V_frequency_group;
    global rnames;
    rnames = {'均值/K','标准差/K','峰峰值/K'};
    data_no_empty = ismember(HRA_time,RPG_time);
    time_with_data = HRA_time(data_no_empty);
    HRA_K_Brt_SameTime = HRA_K_Brt(data_no_empty,:);
    RPG_K_Brt_SameTime = RPG_K_Brt(data_no_empty,:);
    HRA_V_Brt_SameTime = HRA_V_Brt(data_no_empty,:);
    RPG_V_Brt_SameTime = RPG_V_Brt(data_no_empty,:);
    delta_brt_k = HRA_K_Brt_SameTime - RPG_K_Brt_SameTime;
    delta_brt_v = HRA_V_Brt_SameTime - RPG_V_Brt_SameTime;
    average_k = mean(delta_brt_k);average_v = mean(delta_brt_v);
    std_k = std(delta_brt_k);std_v = std(delta_brt_v);
    pp_k = max(delta_brt_k)-min(delta_brt_k);
    pp_v = max(delta_brt_v)-min(delta_brt_v);
    data_brt_k = [average_k;std_k;pp_k];
    data_brt_v = [average_v;std_v;pp_v];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %保存亮温数据表格
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    title = ['波段接收机亮温差值(测量日期:',dateStr,')'];
    cnames_K = K_frequency_group;
    %write2xls(filePath , title , values , sheetName , length)
    write2xls(xlsFilePath,['K',title],cnames_K,data_brt_k,length(cnames_K));  
    cnames_V = V_frequency_group;
    write2xls(xlsFilePath,['V',title],cnames_V,data_brt_v,length(cnames_V));
end