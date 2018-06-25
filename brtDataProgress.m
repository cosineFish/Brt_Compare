%处理亮温数据文件（时间无毫秒）
clearvars;clc;
close all;%关闭所有figure窗口
%global dateStr;global xlsFilePath;
[filename,filepath]=uigetfile('F:/辐射计/2018年6月/亮温对比7-11/*.*','打开RPG亮温文件');
[RPG_time,RPG_K_Brt,RPG_V_Brt] = handle_RPG_brt_file(filepath,filename);
[filename,filepath]=uigetfile('F:/辐射计/2018年6月/亮温对比7-11/*.*','打开HRA-001亮温文件');
[HRA_time,HRA_K_Brt ,HRA_V_Brt] = handle_HRA001_brt_file(filepath,filename);
%找出亮温异常的时间
% data_invalid = (HRA_K_Brt(:,1)>290);
% time_invalid = HRA_time(data_invalid);
% delta_time_invalid = time_invalid(2:end) - time_invalid(1:end-1);
% split_time_invalid = ((seconds(delta_time_invalid) > 20) | (minutes(delta_time_invalid) >= 1) | (hours(delta_time_invalid) >= 1));
% split_time_invalid(2:end) = split_time_invalid(1:end-1) | (split_time_invalid(2:end));
% split_time_invalid(1)=1;split_time_invalid(end+1) = 1;
% split_time = time_invalid(split_time_invalid);
%异常处理结束
global figure_num;
figure_num = 0;
global legend_rect_up;
%global lengend_rect_down;
legend_rect_up = 'NorthEast';%'SouthEast';%[0.8 0.7 0.1 0.05];
%lengend_rect_down = 'NorthEast';%[0.75 0.5 0.1 0.05];
global positionRowNum;
positionRowNum = 0;
global K_frequency_group;
global V_frequency_group; 
K_frequency_group = { '22.24', '23.04', '23.84',...
        '25.44', '26.24', '27.84', '31.40' };
V_frequency_group = { '51.26', '52.28', '53.86', ...
        '54.94', '56.66', '57.30', '58.00'};   
%画亮温曲线
plot_brt(HRA_time,HRA_K_Brt ,RPG_time,RPG_K_Brt,'K');
plot_brt(HRA_time,HRA_V_Brt,RPG_time,RPG_V_Brt,'V');
%把表格保存到excel，注意excel文件太大（190KB左右）可能导致数据写不进去的情况
[time_with_data,delta_brt_k,delta_brt_v] = ...
    saveBrtDataToTable(HRA_time,HRA_K_Brt,HRA_V_Brt ,RPG_time,RPG_K_Brt,RPG_V_Brt);
%画亮温差值曲线
% plot_delta_brt(time_with_data,delta_brt_k,delta_brt_v);
plot_continue_delta_brt(time_with_data,delta_brt_k,delta_brt_v);
%去除差值较大的部分，再画图
%processBrtDelta(time_with_data,delta_brt_k,delta_brt_v);
%system('taskkill /F /IM EXCEL.EXE');
%清除产生的mat文件
%delete_brt_mat();
close all;%关闭所有图像窗口