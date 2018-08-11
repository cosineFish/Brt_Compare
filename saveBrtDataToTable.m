function [time_with_data,delta_brt_k,delta_brt_v] = saveBrtDataToTable(HRA_time,HRA_K_Brt,HRA_V_Brt ,RPG_time,RPG_K_Brt,RPG_V_Brt)
%     global xlsFilePath;
    global dateStr;
%     global K_frequency_group;
%     global V_frequency_group;
    global rnames;
    rnames = {'frequency/GHz','average/K','std/K','(max-min)/K'};
    HRA_data_no_empty = ismember(HRA_time,RPG_time);RPG_data_no_empty = ismember(RPG_time,HRA_time);
    %same_time = ismember(HRA_data_no_empty,RPG_data_no_empty);HRA_data_no_empty = HRA_data_no_empty(same_time);
    %same_time = ismember(RPG_data_no_empty,HRA_data_no_empty);RPG_data_no_empty = RPG_data_no_empty(same_time);
    time_with_data = RPG_time(RPG_data_no_empty);
    hra_time_with_data = HRA_time(HRA_data_no_empty);%hra_time_with_data = unique(hra_time_with_data);%rpg_time_with_data = RPG_time(RPG_data_no_empty);
    if length(time_with_data) ~= length(hra_time_with_data)
        delta_time = datenum(time_with_data) - datenum(hra_time_with_data(1:length(time_with_data)));
        logic_time = (abs(delta_time) > 0);
        error_time = hra_time_with_data(logic_time);
        error_msg = strcat('!!!check error at HRA brt data:',datestr(error_time(1)));
        disp(error_msg);        
    end
    HRA_K_Brt_SameTime = HRA_K_Brt(HRA_data_no_empty,:);%HRA_K_Brt_SameTime = unique(HRA_K_Brt_SameTime);
    RPG_K_Brt_SameTime = RPG_K_Brt(RPG_data_no_empty,:);
    HRA_V_Brt_SameTime = HRA_V_Brt(HRA_data_no_empty,:);%HRA_V_Brt_SameTime = unique(HRA_V_Brt_SameTime);
    RPG_V_Brt_SameTime = RPG_V_Brt(RPG_data_no_empty,:);
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
%     title = ['波段接收机亮温差值(测量日期:',dateStr,')'];
%     cnames_K = K_frequency_group;
    fre_k = [ 22.24, 23.04, 23.84,25.44, 26.24, 27.84, 31.40];   
%     global sheetNum;sheetNum = 1;
    %write2xls(filePath , title , values , sheetName , length)
    write2csv([dateStr,'-k-delta.csv'],rnames,[fre_k;data_brt_k]);
    fre_v = [51.26, 52.28, 53.86,54.94, 56.66, 57.30, 58.00];
    write2csv([dateStr,'-v-delta.csv'],rnames,[fre_v;data_brt_v]);
%     write2xls(xlsFilePath,['K',title],cnames_K,data_brt_k,length(cnames_K));  
%     cnames_V = V_frequency_group;
%     write2xls(xlsFilePath,['V',title],cnames_V,data_brt_v,length(cnames_V));
end