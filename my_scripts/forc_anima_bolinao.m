
close all

% -------------------------------------------------------------------------
%
% -------------------------------------------------------------------------

% --- Import functions

% --- Configurations

dt_plot     = 1/24;                       % Time step in plotting (day)
d_date      = 1;                          % Interval day to plot
% min_date    = datenum(2012,10,8,0,0,0);   % Period 1 start
% max_date    = datenum(2012,10,17,0,0,0);  % Period 1 end
% out_dir     = 'frc_p1_figs_png';          % Period 1
min_date    = datenum(2012,10,22,0,0,0);  % Period 2 start
max_date    = datenum(2012,11,3,0,0,0);   % Period 2 end
out_dir     = 'frc_p2_figs_png';          % Period 2
% min_date    = datenum(2012,12,4,0,0,0);   % Period 3 start
% max_date    = datenum(2012,12,14,0,0,0);  % Period 3 end
% out_dir     = 'frc_p3_figs_png';          % Period 3
% min_date    = datenum(2012,12,20,0,0,0);  % Period 4 start
% max_date    = datenum(2012,12,31,0,0,0);  % Period 4 end
% out_dir     = 'frc_p4_figs_png';          % Period 4
name_case   = 'HYCOMpNAO_fish_farm_grd_v8.1_cd1.5_zob0.03_riv2';
period_case = '201210_01';

% --- Start processing

waq_dt = waq_time(2) - waq_time(1);  % Time step in data
dt_tol = waq_dt - 1.e-06;

t_start = 0;
for t = 1 : waq_nt
    if abs(waq_time(t) - min_date) < dt_tol
        t_start = t;
        datestr(waq_time(t))
        break
    end
end
t_end = 0;
for t = 1 : waq_nt
    if abs(waq_time(t) - max_date) < dt_tol
        t_end = t;
        datestr(waq_time(t))
        break
    end
end

n_dt = dt_plot / waq_dt;
count = 0;
for t = t_start : t_end
    if count == 0 || abs(n_dt - count) < 0.1
        datestr(waq_time(t))
        count = 0;
        
        figure (1)

        subplot(4,1,1)
        plot(waq_time(t_start:t_end), swrad(t_start:t_end), '-k')
        xlim([min_date max_date])
        ylim([0 1000])
        xticks(min_date:d_date:max_date)
        datetick('x','dd-mmm','keeplimits','keepticks');
        grid on
        title('Solar radiation (W/m2)')
        hold on

        subplot(4,1,2)
        plot(waq_time(t_start:t_end), tair(t_start:t_end), '-k')
        xlim([min_date max_date])
        ylim([23 30])
        xticks(min_date:d_date:max_date)
        datetick('x','dd-mmm','keeplimits','keepticks');
        grid on
        title('Air temperature (degree C)')
        hold on

        subplot(4,1,3)
        plot(waq_time(t_start:t_end), uwind(t_start:t_end), '-k')
        hold on
        plot(waq_time(t_start:t_end), vwind(t_start:t_end), '-b')
        xlim([min_date max_date])
        ylim([-10 10])
        xticks(min_date:d_date:max_date)
        datetick('x','dd-mmm','keeplimits','keepticks');
        grid on
        %legend({'uwind','vind'},'Location','northeast','Orientation','horizontal')
        title('Wind velocity (m/s)')
        hold on

        subplot(4,1,4)
        plot(waq_time(t_start:t_end), oxy(t_start:t_end), '-k')
        xlim([min_date max_date])
        ylim([0 16])
        xticks(min_date:d_date:max_date)
        datetick('x','dd-mmm','keeplimits','keepticks');
        grid on
        title('DO (mg/L)')
        hold on
        
        y = -3000 : 3000 : 3000;
        x = [waq_time(t) waq_time(t) waq_time(t)];
        subplot(4,1,1)
        plot(x,y,'-r')
        subplot(4,1,2)
        plot(x,y,'-r')
        subplot(4,1,3)
        plot(x,y,'-r')
        subplot(4,1,4)
        plot(x,y,'-r')
        
        hgexport(figure(1), strcat(['output/',name_case,'/',out_dir,'/v01_'],num2str(t-t_start+1,'%0.4u'),'.png'),hgexport('factorystyle'),'Format','png');
        
        close(figure(1))
        
    end
    count = count + 1;
        
end










