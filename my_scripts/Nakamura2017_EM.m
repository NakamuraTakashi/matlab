
his1='D:\ROMS\output\Shiraho_reef\OAv12_ctrl\ocean_his_10.nc';

formatSpec = '%{yyyy/MM/dd HH:mm}D%f%f';

% min_date=datenum(2009,8,25,0,0,0);
% max_date=datenum(2009,9,9,0,0,0);
min_date=datenum(2010,8,21,0,0,0);
max_date=datenum(2010,9,4,0,0,0);

starting_date=datenum(2010,8,20,0,0,0); % for Shiraho

figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'GraphicsSmoothing','off',...
    'OuterPosition',[0 0 600 1000]);

%% --TC-07 (R3) ---
i=24;j=129;
% i=24;j=131;
EM_stn = readtable('data/EM_TC07_10.csv','Delimiter',',','Format',formatSpec);
subplot(12,1,1); plot(datenum(EM_stn.DateTime), EM_stn.VelEW,'b');
% axis([min_date max_date -27 27])
xlim([min_date max_date]);ylim([-29 29]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Velocity (cm)')

Vel= ncread(his1,'u',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(12,1,1); plot(date1,Vel(:)*100,'r');
skill(datenum(EM_stn.DateTime), EM_stn.VelEW, date1, Vel(:)*100)

subplot(12,1,2); plot(datenum(EM_stn.DateTime), EM_stn.VelNS,'b');
% axis([min_date max_date -27 27])
xlim([min_date max_date]);ylim([-29 29]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Velocity (cm)')

Vel= ncread(his1,'v',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(12,1,2); plot(date1,Vel(:)*100,'r');
skill(datenum(EM_stn.DateTime), EM_stn.VelNS, date1, Vel(:)*100)

%% --TC-06 (R5) ---
% i=34;j=112;
i=33;j=112;
EM_stn = readtable('data/EM_TC06_10.csv','Delimiter',',','Format',formatSpec);
subplot(12,1,3); plot(datenum(EM_stn.DateTime), EM_stn.VelEW,'b');
% axis([min_date max_date -27 27])
xlim([min_date max_date]);ylim([-29 29]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Velocity (cm)')


Vel= ncread(his1,'u',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(12,1,3); plot(date1,Vel(:)*100,'r');
skill(datenum(EM_stn.DateTime), EM_stn.VelEW, date1, Vel(:)*100)

subplot(12,1,4); plot(datenum(EM_stn.DateTime), EM_stn.VelNS,'b');
% axis([min_date max_date -27 27])
xlim([min_date max_date]);ylim([-29 29]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Velocity (cm)')

Vel= ncread(his1,'v',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(12,1,4); plot(date1,Vel(:)*100,'r');
skill(datenum(EM_stn.DateTime), EM_stn.VelNS, date1, Vel(:)*100)

%% --TC-03 (R6) ---
i=26;j=92;
EM_stn = readtable('data/EM_TC03_10.csv','Delimiter',',','Format',formatSpec);
subplot(12,1,5); plot(datenum(EM_stn.DateTime), EM_stn.VelEW,'b');
% axis([min_date max_date -27 27])
xlim([min_date max_date]);ylim([-29 29]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Velocity (cm)')

Vel= ncread(his1,'u',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(12,1,5); plot(date1,Vel(:)*100,'r');
skill(datenum(EM_stn.DateTime), EM_stn.VelEW, date1, Vel(:)*100)

subplot(12,1,6); plot(datenum(EM_stn.DateTime), EM_stn.VelNS,'b');
% axis([min_date max_date -27 27])
xlim([min_date max_date]);ylim([-29 29]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Velocity (cm)')

Vel= ncread(his1,'v',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(12,1,6); plot(date1,Vel(:)*100,'r');
skill(datenum(EM_stn.DateTime), EM_stn.VelNS, date1, Vel(:)*100)

%% --P2 (R9) ---
i=19;j=34;
EM_stn = readtable('data/EM_P2_10.csv','Delimiter',',','Format',formatSpec);
subplot(12,1,7); plot(datenum(EM_stn.DateTime), EM_stn.VelEW,'b');
% axis([min_date max_date -27 27])
xlim([min_date max_date]);ylim([-29 29]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Velocity (cm)')

Vel= ncread(his1,'u',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(12,1,7); plot(date1,Vel(:)*100,'r');
skill(datenum(EM_stn.DateTime), EM_stn.VelEW, date1, Vel(:)*100)

subplot(12,1,8); plot(datenum(EM_stn.DateTime), EM_stn.VelNS,'b');
% axis([min_date max_date -27 27])
xlim([min_date max_date]);ylim([-29 29]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Velocity (cm)')

Vel= ncread(his1,'v',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(12,1,8); plot(date1,Vel(:)*100,'r');
skill(datenum(EM_stn.DateTime), EM_stn.VelNS, date1, Vel(:)*100)


%% --Sta8 (R11)---
i=20;j=17;
EM_stn = readtable('data/EM_Sta8_10.csv','Delimiter',',','Format',formatSpec);
subplot(12,1,9); plot(datenum(EM_stn.DateTime), EM_stn.VelEW,'b');
% axis([min_date max_date -27 27])
xlim([min_date max_date]);ylim([-29 29]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Velocity (cm)')


Vel= ncread(his1,'u',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(12,1,9); plot(date1,Vel(:)*100,'r');
skill(datenum(EM_stn.DateTime), EM_stn.VelEW, date1, Vel(:)*100)

subplot(12,1,10); plot(datenum(EM_stn.DateTime), EM_stn.VelNS,'b');
xlim([min_date max_date]);ylim([-29 29]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Velocity (cm)')

Vel= ncread(his1,'v',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(12,1,10); plot(date1,Vel(:)*100,'r');
skill(datenum(EM_stn.DateTime), EM_stn.VelNS, date1, Vel(:)*100)

%% --Sta13 (R12) ---
i=17;j=7;
EM_stn = readtable('data/EM_Sta13_10.csv','Delimiter',',','Format',formatSpec);
subplot(12,1,11); plot(datenum(EM_stn.DateTime), EM_stn.VelEW,'b');
% axis([min_date max_date -27 27])
xlim([min_date max_date]);ylim([-29 29]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Velocity (cm)')

Vel= ncread(his1,'u',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(12,1,11); plot(date1,Vel(:)*100,'r');
skill(datenum(EM_stn.DateTime), EM_stn.VelEW, date1, Vel(:)*100)

subplot(12,1,12); plot(datenum(EM_stn.DateTime), EM_stn.VelNS,'b');
% axis([min_date max_date -27 27])
xlim([min_date max_date]);ylim([-29 29]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Velocity (cm)')

Vel= ncread(his1,'v',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(12,1,12); plot(date1,Vel(:)*100,'r');
skill(datenum(EM_stn.DateTime), EM_stn.VelNS, date1, Vel(:)*100)

samexaxis('abc','xmt','on','ytac','join','yld',1)


