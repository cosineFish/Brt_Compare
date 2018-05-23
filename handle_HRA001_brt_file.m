function [HRA_time,HRA_K_Brt ,HRA_V_Brt] = handle_HRA001_brt_file(filepath,filename)
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
    format_onlyDate = 'yymmdd';
    startDate = datestr(HRA_time(1),format_onlyDate);startMonth = datestr(HRA_time(1),'yymm');
    %endDate = datestr(time(end),format_onlyDate);
    global dateStr;dateStr = startDate;
%     if startDate == endDate
%         dateStr = startDate;
%     else
%         dateStr = [startDate,'~',endDate];
%     end
    global xlsFilePath;
    xlsFilePath = ['data_',startMonth,'.xls'];
end