%�������������ļ���ʱ���޺��룩
clearvars;clc;
close all;%�ر�����figure����
%global dateStr;global xlsFilePath;
day_num = struct('START_FROM_FORMER_DAY',1,'END_IN_SECOND_DAY',2);
[filename,filepath]=uigetfile('F:\fsj\Y2018M06\TIP-mod\RPG25-28\*.BRT.ASC','��RPG�����ļ�1');
[RPG_time,RPG_K_Brt,RPG_V_Brt] = handle_RPG_brt_file(filepath,filename);
% [RPG_time,RPG_K_Brt,RPG_V_Brt] = ...
%     handle_RPG_brt_file_2days(filepath,filename,day_num.START_FROM_FORMER_DAY);
%     handle_RPG_brt_file_2days(filepath,filename,day_num.END_IN_SECOND_DAY);
% [filename,filepath]=uigetfile('F:\fsj\Y2018M06\TIP-mod\RPG25-28\*.BRT.ASC','��RPG�����ļ�2');
% [RPG_time_1,RPG_K_Brt_1,RPG_V_Brt_1] = ...
%     handle_RPG_brt_file_2days(filepath,filename,day_num.END_IN_SECOND_DAY);
% RPG_data_length_part = length(RPG_time);RPG_time_1ength_all = RPG_data_length_part + length(RPG_time_1);
% RPG_time(RPG_data_length_part+1:RPG_time_1ength_all) = RPG_time_1;
% RPG_K_Brt(RPG_data_length_part+1:RPG_time_1ength_all,1:7) = RPG_K_Brt_1;
% RPG_V_Brt(RPG_data_length_part+1:RPG_time_1ength_all,1:7) = RPG_V_Brt_1;
% [filename,filepath]=uigetfile('E:/�����/2018��6��/HRAM061318/*brt.txt','��HRA-001�����ļ�');
[filename,filepath]=uigetfile('F:\fsj\Y2018M06\TIP-mod\little-angle\*brt.txt','��HRA-001�����ļ�');
%global day;%day = 15;
specify_time = datetime(2018,06,25);%day = day + 1;
[HRA_time,HRA_K_Brt ,HRA_V_Brt] = handle_HRA_brt_file_specify_time(filepath,filename,specify_time);
% [HRA_time,HRA_K_Brt ,HRA_V_Brt] = handle_HRA001_brt_file(filepath,filename);
%�ҳ������쳣��ʱ��
% data_invalid = (HRA_K_Brt(:,1)>290);
% time_invalid = HRA_time(data_invalid);
% delta_time_invalid = time_invalid(2:end) - time_invalid(1:end-1);
% split_time_invalid = ((seconds(delta_time_invalid) > 20) | (minutes(delta_time_invalid) >= 1) | (hours(delta_time_invalid) >= 1));
% split_time_invalid(2:end) = split_time_invalid(1:end-1) | (split_time_invalid(2:end));
% split_time_invalid(1)=1;split_time_invalid(end+1) = 1;
% split_time = time_invalid(split_time_invalid);
%�쳣�������
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
%�����º͵�ѹ����һ��ͼ��
% [Vol_time,HRA_K_Vol,HRA_V_Vol] = GetVol();
%����������
plot_brt(HRA_time,HRA_K_Brt ,RPG_time,RPG_K_Brt,'K');
plot_brt(HRA_time,HRA_V_Brt,RPG_time,RPG_V_Brt,'V');
% plot_brt_vol(HRA_time,HRA_K_Brt,Vol_time,HRA_K_Vol ,RPG_time,RPG_K_Brt,'K');
% plot_brt_vol(HRA_time,HRA_V_Brt,Vol_time,HRA_V_Vol ,RPG_time,RPG_V_Brt,'V');
%�ѱ�񱣴浽excel��ע��excel�ļ�̫��190KB���ң����ܵ�������д����ȥ�����
[time_with_data,delta_brt_k,delta_brt_v] = ...
    saveBrtDataToTable(HRA_time,HRA_K_Brt,HRA_V_Brt ,RPG_time,RPG_K_Brt,RPG_V_Brt);
%�����²�ֵ����
 plot_delta_brt(time_with_data,delta_brt_k,delta_brt_v);
%plot_continue_delta_brt(time_with_data,delta_brt_k,delta_brt_v);
%ȥ����ֵ�ϴ�Ĳ��֣��ٻ�ͼ
%processBrtDelta(time_with_data,delta_brt_k,delta_brt_v);
%system('taskkill /F /IM EXCEL.EXE');
%���������mat�ļ�
%delete_brt_mat();
close all;%�ر�����ͼ�񴰿�