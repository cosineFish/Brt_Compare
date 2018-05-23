function [time,K_Vol_RPG,V_Vol_RPG] = handle_RPG_vol_file(filepath,filename)
    format_data = '';
    for i = 1:1:86
        format_data = strcat(format_data,'%f ');
    end
    complete_file = strcat(filepath,filename);
    fidin = fopen(complete_file,'r+');  
    sourceData = textscan(fidin,format_data,'Delimiter',',','CommentStyle','#');
    fclose(fidin);
    column_length = length(sourceData{1});
    time = datetime(sourceData{1},sourceData{2},sourceData{3},sourceData{4},sourceData{5},sourceData{6});
    K_Vol_RPG = zeros(column_length,7);V_Vol_RPG = zeros(column_length,7);
    for i = 1:7
        K_Vol_RPG(:,i) = sourceData{68+i};
        V_Vol_RPG(:,i) = sourceData{76+i};
    end
end