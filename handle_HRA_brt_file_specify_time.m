function [HRA_time,HRA_K_Brt ,HRA_V_Brt] = handle_HRA_brt_file_specify_time(filepath,filename,specify_time)
    format_data = '';
    for i = 1:1:22%前6个是时间，后面16个是亮温
        format_data = strcat(format_data,'%f ');
    end
    complete_file = strcat(filepath,filename);
    fidin = fopen(complete_file,'r+');
    sourceData = textscan(fidin,format_data,'CommentStyle','#');
    fclose(fidin);
    column_length = length(sourceData{1});
    HRA_time = datetime(sourceData{1},sourceData{2},sourceData{3},sourceData{4},sourceData{5},sourceData{6});
    HRA_K_Brt = zeros(column_length,8);HRA_V_Brt = zeros(column_length,8);
    for i = 1:8
        HRA_K_Brt(:,i) = sourceData{6+i};
        HRA_V_Brt(:,i) = sourceData{14+i};
    end
    HRA_K_Brt(:,7) = [];%去除第7个通道
    HRA_V_Brt(:,5) = [];%去掉倒数第4个通道
    %只取指定日期的数据
    valid_time_logic = ...
        (datenum(HRA_time) >= datenum(specify_time)) & ...
        (datenum(HRA_time) < datenum(specify_time+hours(24)));
    HRA_time = HRA_time(valid_time_logic);
    HRA_K_Brt = HRA_K_Brt(valid_time_logic,1:7);
    HRA_V_Brt = HRA_V_Brt(valid_time_logic,1:7);
    column_length = length(HRA_time);
    %去掉时间重复的数据
    hra_valid_time = (datenum(HRA_time(2:end) - HRA_time(1:end-1)) ~= 0);hra_valid_time(column_length) = 1;
    HRA_time = HRA_time(hra_valid_time);
    HRA_K_Brt = HRA_K_Brt(hra_valid_time,1:7);HRA_V_Brt = HRA_V_Brt(hra_valid_time,1:7);
    %获取时间
    format_onlyDate = 'yymmdd';
    startDate = datestr(HRA_time(1),format_onlyDate);startMonth = datestr(HRA_time(1),'yymm');
%     endDate = datestr(HRA_time(end),format_onlyDate);
    global dateStr;dateStr = startDate;
%     if startDate == endDate
%         dateStr = startDate;
%     else
%         dateStr = [startDate,'~',endDate];
%     end
    global xlsFilePath;
    xlsFilePath = ['data_mod_',startMonth,'.xls'];
end