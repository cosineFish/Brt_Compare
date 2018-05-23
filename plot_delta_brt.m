function plot_delta_brt(time_with_data,delta_brt_k,delta_brt_v)
    global K_frequency_group;
    global V_frequency_group;
    K_frequency_group = { '22.24', '23.04', '23.84',...
            '25.44', '26.24', '27.84', '31.40' };
    V_frequency_group = { '51.26', '52.28', '53.86', ...
            '54.94', '56.66', '57.30', '58.00'};    
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
    for fig_num = 1:2
       figure('name',[num2str(fig_num),receiver,msgStr,'曲线']);
       figure_num = figure_num + 1;channel_num = 0;
       for sub_fig = 1:7
            channel_num = channel_num + 1;
            subplot(4,2,sub_fig);
            plot(datenum(time_with_data) ,delta_brt(:,channel_num),'r-');
            ax = gca;
            ax.XTick = datenum(xData);
            datetick(ax,'x','HH:MM','keepticks');
%             y_tick_min = minValue(channel_num);
%             if maxValue(channel_num) - minValue(channel_num) <= 2
%                 y_tick_max = y_tick_min + 1;
%                 set(gca,'ytick',y_tick_min:0.2:y_tick_max);
%             else
%                 y_tick_max = y_tick_min + y_range;
%                 set(gca,'ytick',y_tick_min:(y_range/5):y_tick_max);
%             end
%             ylim = [y_tick_min y_tick_max];
%             set(gca, 'Ylim',ylim );
            %xlabel('时间/(时:分)');
            ylabel([msgStr,'/K']);       
            title([frequencyStr{channel_num},'GHz']);
            set(gca,'FontSize',14);
            grid on;
            hold on;
       end
       suptitle([dateStr,'-',receiver,...
            '波段接收机各通道的',msgStr,'对比曲线']);
       set (gcf,'Position',[100,100,1080,900], 'color','w');
       hold off;
       save2word([dateStr,'delta_brt_compare.doc'],'-f');
       if fig_num == 2
           break;
       else
           frequencyStr = V_frequency_group;receiver = 'v';delta_brt = delta_brt_v;
       end
    end
end