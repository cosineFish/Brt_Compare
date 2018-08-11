function plot_delta_brt(time_with_data,delta_brt_k,delta_brt_v)
    global K_frequency_group;
    global V_frequency_group; 
    msgStr = '亮温差值';
    %y_min_k = min(abs(delta_brt_k));y_min_v = min(abs(delta_brt_v));
	%y_min = floor(min(y_min_k,y_min_v));
%     y_mean_k = mean(delta_brt_k);y_mean_v = mean(delta_brt_v);
%     y_max = ceil(max(y_mean_k,y_mean_v));
%     minValue = floor(y_min(:,:)*10)/10;maxValue= ceil(y_max(:,:)*10)/10;
%     deltaValue = maxValue - minValue;
%     y_range = ceil(max(deltaValue));
    global figure_num;
    %global legend_rect_up;
    global dateStr;
    xData = linspace(time_with_data(1),time_with_data(end),5);   
    delta_brt = delta_brt_k;
    frequencyStr = K_frequency_group;receiver = 'k';
    y_min = min([delta_brt_k delta_brt_v]);y_max = max([delta_brt_k delta_brt_v]);
    %y_delta = y_max - y_min;
    y_range = ceil(y_max - y_min);
%     if y_delta < 30
%         y_range = ceil(y_delta * 10)/10;
%     elseif y_delta < 100
%         y_range = ceil(y_delta * 10)/20;
%     else
%         y_range = ceil(y_delta * 10)/40;
%     end
    channel_num = 0;
    y_tick_min = ceil(y_min);y_tick_max = y_tick_min + y_range;
    for fig_num = 1:2
       figure('name',[num2str(fig_num),receiver,msgStr,'曲线']);
       figure_num = figure_num + 1;
       for sub_fig = 1:7
            channel_num = channel_num + 1;
            subplot(4,2,sub_fig);
            plot(datenum(time_with_data) ,delta_brt(:,sub_fig),'r');
            ax = gca;
            ax.XTick = datenum(xData);
            datetick(ax,'x','HH:MM','keepticks');
            %datetick(ax,'x','dd HH:MM','keepticks');
            set(gca,'ytick',y_tick_min(channel_num):(y_range(channel_num)/5):y_tick_max(channel_num));
            ylim = [y_tick_min(channel_num) y_tick_max(channel_num)];
            set(gca, 'Ylim',ylim );
            %xlabel('时间/(时:分)');
            %xlabel('时间/(年/月/日 时:分)');
            ylabel([msgStr,'/K']);       
            title([frequencyStr{sub_fig},'GHz']);
            set(gca,'FontSize',12);
            grid on;
            hold on;
       end
       suptitle([dateStr,'-',receiver,...
            '波段接收机各通道的',msgStr,'对比曲线']);
       set (gcf,'Position',[100,100,1080,900], 'color','w');
       hold off;
       save2word([dateStr,'delta_brt_compare.doc'],'-f');
       if fig_num == 1
           frequencyStr = V_frequency_group;receiver = 'v';delta_brt = delta_brt_v;
       else
           break;
       end
    end
end