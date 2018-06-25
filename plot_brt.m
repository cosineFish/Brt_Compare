function plot_brt(HRA_time,HRA_Brt ,RPG_time,RPG_Brt,receiver )
    global K_frequency_group;
    global V_frequency_group;
    K_frequency_group = { '22.24', '23.04', '23.84',...
            '25.44', '26.24', '27.84', '31.40' };
    V_frequency_group = { '51.26', '52.28', '53.86', ...
            '54.94', '56.66', '57.30', '58.00'};    
    if receiver == 'K' || receiver == 'k'
        frequencyStr = K_frequency_group;
        %y_range = 120;
    elseif receiver == 'V' || receiver == 'v'
        frequencyStr = V_frequency_group;
        %y_range = 20;
    else
        return;
    end
    msgStr = '亮温';
    y_min_HRA = min(HRA_Brt);y_min_RPG = min(RPG_Brt);
	y_min = floor(min(y_min_HRA,y_min_RPG));
    y_max_HRA = max(HRA_Brt);y_max_RPG = max(RPG_Brt);
    y_max = ceil(max(y_max_HRA,y_max_RPG));
    minValue = floor(y_min(:,:)*10)/10;maxValue= ceil(y_max(:,:)*10)/10;
    deltaValue = maxValue - minValue;
    y_range = ceil(max(deltaValue));
    global figure_num;
    %global legend_rect_up;
    global dateStr;
    xData = linspace(HRA_time(1),HRA_time(end),5);
    channel_num = 0;
    for fig_num = 1:2
       figure('name',[num2str(fig_num),'-',receiver,msgStr,'曲线']);
       figure_num = figure_num + 1;
       for sub_fig = 1:4
            channel_num = channel_num + 1;
            if channel_num == 8
                break;
            end
            subplot(2,2,sub_fig);
            plot(datenum(HRA_time) ,HRA_Brt(:,channel_num),'r.',datenum(RPG_time),RPG_Brt(:,channel_num),'g.');
            ax = gca;
            ax.XTick = datenum(xData);
            %datetick(ax,'x','HH:MM','keepticks');
            datetick(ax,'x','dd HH:MM','keepticks');
            y_tick_min = minValue(channel_num);
            if maxValue(channel_num) - minValue(channel_num) <= 2
                y_tick_max = y_tick_min + 1;
                set(gca,'ytick',y_tick_min:0.2:y_tick_max);
            else
                y_tick_max = y_tick_min + y_range;
                set(gca,'ytick',y_tick_min:(y_range/5):y_tick_max);
            end
            ylim = [y_tick_min y_tick_max];
            set(gca, 'Ylim',ylim );
            xlabel('时间/(日期 时:分)');
            ylabel([msgStr,'/K']);       
            title([frequencyStr{channel_num},'GHz']);
            set(gca,'FontSize',14);
            grid on;
            hold on;
            legend('HRA','RPG');
       end
       suptitle([dateStr,'-',receiver,...
            '波段接收机各通道的',msgStr,'对比曲线']);
       set (gcf,'Position',[100,100,1080,800], 'color','w');
       hold off;
       save2word([dateStr,'brt_compare.doc'],'-f');
       %saveas(gcf,[dateStr,'-f',num2str(figure_num)],'png');
    end
end