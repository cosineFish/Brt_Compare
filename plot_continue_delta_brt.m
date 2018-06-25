function plot_continue_delta_brt(time_with_data,delta_brt_k,delta_brt_v)
    global K_frequency_group;
    global V_frequency_group; 
    msgStr = '亮温差值';
    global figure_num;
    global dateStr;
%     xtick_time = datetime(2018*ones(1,5));
    xtick_num = zeros(1,5);
%     date_num = [4,5,7,8,9];
%     for i = 1:5
%         logic_time = datenum(time_with_data)>datenum(datetime(2018,06,date_num(i),00,00,00));
%         time = time_with_data(logic_time);
%         xtick_time(i) = time(1);
%         xtick_num(i) = find(time_with_data==xtick_time(i));
%     end
    data_length = length(time_with_data);xtick_num(1) = 1;xtick_time(1) = time_with_data(1);
    for i = 2:4
       xtick_num(i) = xtick_num(i-1) + floor(data_length/4);
       xtick_time(i) = time_with_data(xtick_num(i));
    end
    xtick_num(5) = data_length;xtick_time(5) = time_with_data(end);
%     xData = linspace(time_with_data(1),time_with_data(end),5);   
    delta_brt = delta_brt_k;
    frequencyStr = K_frequency_group;receiver = 'k';
    y_min = min([delta_brt_k delta_brt_v]);y_max = max([delta_brt_k delta_brt_v]);
    %y_delta = y_max - y_min;
    y_range = ceil(y_max - y_min);
    channel_num = 0;
    y_tick_min = ceil(y_min);y_tick_max = y_tick_min + y_range;
    for fig_num = 1:2
       figure('name',[num2str(fig_num),receiver,msgStr,'曲线']);
       figure_num = figure_num + 1;
       for sub_fig = 1:7
            channel_num = channel_num + 1;
            subplot(4,2,sub_fig);
%             plot(datenum(time_with_data) ,delta_brt(:,sub_fig),'r.');
            plot(delta_brt(:,sub_fig),'r-');
            ax = gca;
%             ax.XTick = datenum(xData);
            ax.XTick = xtick_num;
            %datetick(ax,'x','HH:MM','keepticks');
%             datetick(ax,'x','dd HH:MM','keepticks');
            set(gca,'xticklabel',datestr(xtick_time,'dd'));
            set(gca,'ytick',y_tick_min(channel_num):(y_range(channel_num)/5):y_tick_max(channel_num));
            ylim = [y_tick_min(channel_num) y_tick_max(channel_num)];
            set(gca, 'Ylim',ylim );
            %xlabel('时间/(时:分)');
            %xlabel('时间/(年/月/日 时:分)');
            ylabel([msgStr,'/K']);       
            title([frequencyStr{sub_fig},'GHz']);
            set(gca,'FontSize',14);
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