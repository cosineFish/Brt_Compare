%�������������ļ���ʱ���޺��룩
clearvars;clc;
close all;%�ر�����figure����
%global dateStr;global xlsFilePath;
[filename,filepath]=uigetfile('*.*','��RPG�����ļ�');
[RPG_time,RPG_K_Brt,RPG_V_Brt] = handle_RPG_brt_file(filepath,filename);
[filename,filepath]=uigetfile('*.*','��HRA-001�����ļ�');
[HRA_time,HRA_K_Brt ,HRA_V_Brt] = handle_HRA001_brt_file(filepath,filename);
global figure_num;
figure_num = 0;
global legend_rect_up;
%global lengend_rect_down;
legend_rect_up = 'NorthEast';%'SouthEast';%[0.8 0.7 0.1 0.05];
%lengend_rect_down = 'NorthEast';%[0.75 0.5 0.1 0.05];
global positionRowNum;
positionRowNum = 0;
%�ѱ�񱣴浽excel��ע��excel�ļ�̫��190KB���ң����ܵ�������д����ȥ�����
[time_with_data,delta_brt_k,delta_brt_v] = ...
    saveBrtDataToTable(HRA_time,HRA_K_Brt,HRA_V_Brt ,RPG_time,RPG_K_Brt,RPG_V_Brt);
%����������
plot_brt(HRA_time,HRA_K_Brt ,RPG_time,RPG_K_Brt,'K');
plot_brt(HRA_time,HRA_V_Brt,RPG_time,RPG_V_Brt,'V');
%�����²�ֵ����
plot_delta_brt(time_with_data,delta_brt_k,delta_brt_v);
%system('taskkill /F /IM EXCEL.EXE');
%���������mat�ļ�
%delete_brt_mat();
close all;%�ر�����ͼ�񴰿�