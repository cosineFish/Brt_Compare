% write2xls(xlsFilePath,['K',title],cnames_K,data_brt_k,length(cnames_K));  
function write2csv(file_name,row_name,data)
    data = round(data.*100)./100;%保留2位有效数字
    T = cell2table(num2cell(data),'RowNames',row_name);%,'RowNames',row_name
    writetable(T,file_name,'WriteRowNames',true,'WriteVariableNames',false);%
end