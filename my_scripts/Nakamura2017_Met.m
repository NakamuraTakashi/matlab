
frc='D:\ROMS\Data\Shiraho_reef\frc_air100820-1001v2.nc';

formatSpec = '%{yyyy/MM/dd HH:mm}D%f';

% min_date=datenum(2009,8,25,0,0,0);
% max_date=datenum(2009,9,9,0,0,0);
min_date=datenum(2010,8,21,0,0,0);
max_date=datenum(2010,9,4,0,0,0);

starting_date=datenum(2010,8,20,0,0,0); % for Shiraho

figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'GraphicsSmoothing','off',...
    'OuterPosition',[0 0 600 1000]);

% --Wind ---
aspr=5;   %x/y
xmin=min_date;
xmax=max_date;
ymin=-11;
ymax=11;
ratio=(xmax-xmin)/(ymax-ymin);
scale=0;

Uwind= ncread(frc,'Uwind');
Vwind= ncread(frc,'Vwind');
time1 = ncread(frc,'frc_time');
date1=starting_date+time1;
y=zeros(size(date1));
subplot(7,1,1); q=quiver(date1,y, Uwind*ratio/aspr,Vwind, scale);
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

swrad= ncread(frc,'swrad');
time1 = ncread(frc,'frc_time');
date1=starting_date+time1;
subplot(7,1,3); plot(date1,swrad,'k');
% axis([min_date max_date 0 1100])
xlim([min_date max_date]);ylim([0 1100]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Short wave radiation (W/m2)')

% --rain ---

rain= ncread(frc,'rain');
time1 = ncread(frc,'frc_time');
date1=starting_date+time1;
subplot(7,1,4); plot(date1,rain*60*60,'k');
% axis([min_date max_date 0 48])
xlim([min_date max_date]);ylim([0 48]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Precipitation (mm/h)')

% --Offshore water elevation ---
formatSpec = '%{yyyy/MM/dd HH:mm}D%f';

WLL_stn = readtable('data/WLL_off_10.csv','Delimiter',',','Format',formatSpec);
diff=0;
subplot(7,1,5); plot(datenum(WLL_stn.DateTime), WLL_stn.m - diff,'k');
% axis([min_date max_date -0.7 1.4])
xlim([min_date max_date]);ylim([-0.7 1.4]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Elevation (m)')

% --Offshore water elevation ---
formatSpec = '%{yyyy/MM/dd HH:mm}D%f%f';

WH_stn = readtable('data/WH_Sta14_10.csv','Delimiter',',','Format',formatSpec);
subplot(7,1,6); plot(datenum(WH_stn.DateTime), WH_stn.Hs,'k');
% axis([min_date max_date 0 1.8])
xlim([min_date max_date]);ylim([0 1.8]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Significant Wave hight (m)')

subplot(7,1,7); plot(datenum(WH_stn.DateTime), WH_stn.Ts,'k');
% axis([min_date max_date 0 18])
xlim([min_date max_date]);ylim([0 18]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Peak wave period (s)')


samexaxis('abc','xmt','on','ytac','join','yld',1)
