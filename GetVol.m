function [Vol_time,K_Vol,V_Vol] = GetVol()
    format_data = '';
    for i = 1:1:86
        format_data = strcat(format_data,'%f ');
    end
    [filename,filepath]=uigetfile('F:\fsj\Y2018M07\\*observeData.txt','打开文件');
    complete_file = strcat(filepath,filename);
    fidin = fopen(complete_file,'r+');
    sourceData = textscan(fidin,format_data,'CommentStyle','#');
    fclose(fidin);
    column_length = length(sourceData{1});
    Vol_time = datetime(sourceData{1},sourceData{2},sourceData{3},sourceData{4},sourceData{5},sourceData{6});
    K_Vol = zeros(column_length,8);V_Vol = zeros(column_length,8);
    for i = 1:8
        K_Vol(:,i) = sourceData{68+i};
        V_Vol(:,i) = sourceData{76+i};
    end
    K_Vol(:,7) = [];
    V_Vol(:,5) = [];
end