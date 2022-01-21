
frc1='F:\COAWST_DATA\TokyoBay\TokyoBay2\Air\TokyoBay2_frc_MSMgb_20180101_1.nc';
frc2='F:\COAWST_DATA\TokyoBay\TokyoBay2\Air\TokyoBay2_frc_MSMgb_20180101_2.nc';

i=140; j=95;

min_date=datenum(2018,5,31,0,0,0);
max_date=datenum(2018,7,1,0,0,0);

%% 
time1 = ncread(frc1,'time');
time2 = ncread(frc2,'time');

starting_date=datenum(2000,1,1,0,0,0);

date1=starting_date+time1;
date2=starting_date+time2;

formatSpec = '%{yyyy/MM/dd HH:mm}D%f';

%% 

% Searching index number of nearest time
[M,id_tmin1] = min(abs(date1 - min_date));
[M,id_tmax1] = min(abs(date1 - max_date));
Nt1 = id_tmax1-id_tmin1+1;
date1=date1(id_tmin1:id_tmax1);

[M,id_tmin2] = min(abs(date2 - min_date));
[M,id_tmax2] = min(abs(date2 - max_date));
Nt2 = id_tmax2-id_tmin2+1;
date2=date2(id_tmin2:id_tmax2);
%% 

figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'GraphicsSmoothing','off',...
    'OuterPosition',[0 0 600 1000]);
% set(gca,'FontSize',18);

% --Wind ---
aspr=5;   %x/y
xmin=min_date;
xmax=max_date;
ymin=-16;
ymax=16;
ratio=(xmax-xmin)/(ymax-ymin);
scale=0;

Uwind= ncread(frc1,'Uwind', [i j id_tmin1], [1 1 Nt1]);
Vwind= ncread(frc1,'Vwind', [i j id_tmin1], [1 1 Nt1]);
Uwind=squeeze(Uwind);
Vwind=squeeze(Vwind);

y=zeros(size(date1));
subplot(4,1,1); q=quiver(date1,y, Uwind*ratio/aspr,Vwind, scale);
% subplot(4,1,1); q=quiver(date1,y, Uwind,Vwind, scale);
q.Color='k';
q.MaxHeadSize=0.01;

pbaspect([aspr 1 1])
% axis([xmin xmax ymin ymax])
xlim([xmin xmax]);ylim([ ymin ymax]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Velocity (m/s)')

% --Wind ---
% aspr=10;   %x/y
% xmin=min_date;
% xmax=max_date;
% ymin=-10;
% ymax=10;
% ratio=(xmax-xmin)/(ymax-ymin);
% 
% Uwind= ncread(frc,'Uwind');
% Vwind= ncread(frc,'Vwind');
% time1 = ncread(frc,'frc_time');
% date1=starting_date+time1;
% subplot(4,1,2); plot(date1,Uwind,'b');
% hold on
% subplot(4,1,2); plot(date1,Vwind,'r');
% axis([xmin xmax ymin ymax])
% datetick('x','dd-mmm','keeplimits','keepticks');
% ylabel('Velocity (m/s)')

% --swrad ---

swrad= ncread(frc2,'swrad', [i j id_tmin2], [1 1 Nt2]);
swrad=squeeze(swrad);
subplot(4,1,2); plot(date2,swrad,'k');
% axis([min_date max_date 0 1100])
xlim([min_date max_date]);ylim([0 1100]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Short wave radiation (W/m2)')

% --Tair ---

Tair= ncread(frc1,'Tair', [i j id_tmin1], [1 1 Nt1]);
Tair=squeeze(Tair);
subplot(4,1,3); plot(date1,Tair,'k');
% axis([min_date max_date 0 1100])
xlim([min_date max_date]);ylim([15.5 26.5]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Air temperature (^oC)')


% --rain ---

rain= ncread(frc2,'rain', [i j id_tmin2], [1 1 Nt2]);
rain=squeeze(rain);
subplot(4,1,4); plot(date2,rain*60*60,'k');
% axis([min_date max_date 0 48])
xlim([min_date max_date]);ylim([0 17]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Precipitation (mm/h)')

% % --Offshore water elevation ---
% formatSpec = '%{yyyy/MM/dd HH:mm}D%f';
% 
% WLL_stn = readtable('data/WLL_off_10.csv','Delimiter',',','Format',formatSpec);
% diff=0;
% subplot(7,1,5); plot(datenum(WLL_stn.DateTime), WLL_stn.m - diff,'k');
% % axis([min_date max_date -0.7 1.4])
% xlim([min_date max_date]);ylim([-0.7 1.4]);
% datetick('x','dd-mmm','keeplimits','keepticks');
% ylabel('Elevation (m)')
% 
% % --Offshore water elevation ---
% formatSpec = '%{yyyy/MM/dd HH:mm}D%f%f';
% 
% WH_stn = readtable('data/WH_Sta14_10.csv','Delimiter',',','Format',formatSpec);
% subplot(7,1,6); plot(datenum(WH_stn.DateTime), WH_stn.Hs,'k');
% % axis([min_date max_date 0 1.8])
% xlim([min_date max_date]);ylim([0 1.8]);
% datetick('x','dd-mmm','keeplimits','keepticks');
% ylabel('Significant Wave hight (m)')
% 
% subplot(7,1,7); plot(datenum(WH_stn.DateTime), WH_stn.Ts,'k');
% % axis([min_date max_date 0 18])
% xlim([min_date max_date]);ylim([0 18]);
% datetick('x','dd-mmm','keeplimits','keepticks');
% ylabel('Peak wave period (s)')


samexaxis('abc','xmt','on','ytac','join','yld',1)
