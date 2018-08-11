function [RPG_time,RPG_K_Brt,RPG_V_Brt] = handle_RPG_brt_file_2days(filepath,filename,daynum)
    format_data = '';
    for i = 1:1:23%前6个是时间，第7个是雨滴，后面14个是亮温,最后2个是角度
        format_data = strcat(format_data,'%f ');
    end
    complete_file = strcat(filepath,filename);
    fidin = fopen(complete_file,'r+');  
    sourceData = textscan(fidin,format_data,'Delimiter',',','CommentStyle','#', 'headerlines',8);
    fclose(fidin);
    RPG_time = datetime(sourceData{1}+2000,sourceData{2},sourceData{3},sourceData{4},sourceData{5},sourceData{6});
    RPG_time = RPG_time + hours(8);
    start_time = RPG_time(1);
    if daynum == 1%文件包含了前一天至当天的数据，只取当天的部分
       RPG_time_part_logic = (datenum(RPG_time) >= datenum(start_time.Year,start_time.Month,start_time.Day+1));
    elseif daynum == 2%文件包含了当天至第二天的数据，只取当天的部分
       RPG_time_part_logic = (datenum(RPG_time) < datenum(start_time.Year,start_time.Month,start_time.Day+1));
    end
    column_length = length(sourceData{1});
    RPG_K_Brt = zeros(column_length,7);RPG_V_Brt = zeros(column_length,7);
    for i = 1:7
        RPG_K_Brt(:,i) = sourceData{7+i};
        RPG_V_Brt(:,i) = sourceData{14+i};
    end
    RPG_time = RPG_time(RPG_time_part_logic);
    RPG_K_Brt = RPG_K_Brt(RPG_time_part_logic,:);
    RPG_V_Brt = RPG_V_Brt(RPG_time_part_logic,:);
end