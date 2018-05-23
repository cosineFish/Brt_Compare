%处理亮温数据文件（时间无毫秒）
clearvars;clc;
close all;%关闭所有figure窗口
%global dateStr;global xlsFilePath;
[filename,filepath]=uigetfile('*.*','打开RPG亮温文件');
[RPG_time,RPG_K_Brt,RPG_V_Brt] = handle_RPG_brt_file(filepath,filename);
[filename,filepath]=uigetfile('*.*','打开HRA-001亮温文件');
[HRA_time,HRA_K_Brt ,HRA_V_Brt] = handle_HRA001_brt_file(filepath,filename);
global figure_num;
figure_num = 0;
global legend_rect_up;
%global lengend_rect_down;
legend_rect_up = 'NorthEast';%'SouthEast';%[0.8 0.7 0.1 0.05];
%lengend_rect_down = 'NorthEast';%[0.75 0.5 0.1 0.05];
global positionRowNum;
positionRowNum = 0;
%把表格保存到excel，注意excel文件太大（190KB左右）可能导致数据写不进去的情况
[time_with_data,delta_brt_k,delta_brt_v] = ...
    saveBrtDataToTable(HRA_time,HRA_K_Brt,HRA_V_Brt ,RPG_time,RPG_K_Brt,RPG_V_Brt);
%画亮温曲线
plot_brt(HRA_time,HRA_K_Brt ,RPG_time,RPG_K_Brt,'K');
plot_brt(HRA_time,HRA_V_Brt,RPG_time,RPG_V_Brt,'V');
%画亮温差值曲线
plot_delta_brt(time_with_data,delta_brt_k,delta_brt_v);
%system('taskkill /F /IM EXCEL.EXE');
%清除产生的mat文件
%delete_brt_mat();
close all;%关闭所有图像窗口