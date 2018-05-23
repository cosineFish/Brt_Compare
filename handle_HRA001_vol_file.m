function [time,K_Vol_HRA,V_Vol_HRA] = handle_HRA001_vol_file(filepath,filename)
    format_data = '';
    for i = 1:1:86
        format_data = strcat(format_data,'%f ');
    end
    complete_file = strcat(filepath,filename);
    fidin = fopen(complete_file,'r+');
    sourceData = textscan(fidin,format_data,'CommentStyle','#');
    fclose(fidin);
    column_length = length(sourceData{1});
    time = datetime(sourceData{1},sourceData{2},sourceData{3},sourceData{4},sourceData{5},sourceData{6});
    K_Vol_HRA = zeros(column_length,8);V_Vol_HRA = zeros(column_length,8);
    for i = 1:8
        K_Vol_HRA(:,i) = sourceData{68+i};
        V_Vol_HRA(:,i) = sourceData{76+i};
    end
    K_Vol_HRA(:,7) = [];%去除第7个通道
    V_Vol_HRA(:,5) = [];%去掉倒数第4个通道
    format_onlyDate = 'yymmdd';
    startDate = datestr(time(1),format_onlyDate);startMonth = datestr(time(1),'yymm');
    endDate = datestr(time(end),format_onlyDate);
    global dateStr;
    if startDate == endDate
        dateStr = startDate;
    else
        dateStr = [startDate,'~',endDate];
    end
    global xlsFilePath;
    xlsFilePath = ['data_',startMonth,'.xls'];
end