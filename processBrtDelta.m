function processBrtDelta(time_with_data,delta_brt_k,delta_brt_v)
    delta_brt = [delta_brt_k delta_brt_v];
    median_delta = median(delta_brt);
    logic_get_data = (abs(delta_brt - median_delta) < 5);
    
    global K_frequency_group;
    global V_frequency_group;
    K_frequency_group = { '22.24', '23.04', '23.84',...
            '25.44', '26.24', '27.84', '31.40' };
    V_frequency_group = { '51.26', '52.28', '53.86', ...
            '54.94', '56.66', '57.30', '58.00'};    
    msgStr = '亮温差值';
    %y_min = min(delta_brt);y_max = max(delta_brt);
    %y_range = ceil(y_max - y_min);
    channel_num = 0;
    %y_tick_min = ceil(y_min);y_tick_max = y_tick_min + y_range;
    y_range = 10;
    y_tick_min = floor(median_delta * 10)/10 - 5;y_tick_max = y_tick_min + y_range;
    global figure_num;
    global dateStr;
    frequencyStr = K_frequency_group;receiver = 'k';
    for fig_num = 1:2
       figure('name',[num2str(fig_num),receiver,msgStr,'曲线']);
       figure_num = figure_num + 1;
       for sub_fig = 1:7
            channel_num = channel_num + 1;
            subplot(4,2,sub_fig);
            time_channel = time_with_data(logic_get_data(:,channel_num));
            xData = linspace(time_channel(1),time_channel(end),5);
            original_delta_brt_channel = delta_brt(:,channel_num);
            delta_brt_channel = original_delta_brt_channel(logic_get_data(:,channel_num));
            plot(datenum(time_channel) ,delta_brt_channel(:),'r-');
            ax = gca;
            ax.XTick = datenum(xData);
            datetick(ax,'x','HH:MM','keepticks');
            set(gca,'ytick',y_tick_min(channel_num):(y_range/5):y_tick_max(channel_num));
            ylim = [y_tick_min(channel_num) y_tick_max(channel_num)];
            set(gca, 'Ylim',ylim );
            %xlabel('时间/(时:分)');
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
       %save2word([dateStr,'delta_brt_compare.doc'],'-f');
       saveas(gcf,[dateStr,'-delta-f',num2str(figure_num)],'png');
       if fig_num == 1
           frequencyStr = V_frequency_group;receiver = 'v';
       else
           break;
       end
    end    
end