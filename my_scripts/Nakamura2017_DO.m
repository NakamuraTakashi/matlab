
% his1='D:\ROMS\output\Shiraho_reef\test\ocean_his_10.nc';
% his1='D:\ROMS\output\Shiraho_reef\OAv12_ctrl\ocean_his_10.nc';
his1='K:\ROMS\output\Shiraho_reef\bleaching02\ocean_his_10_29.5.nc';

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

%% --Sta14 (O1) ---
% i=28;j=24;
i=27;j=24;
DO_stn = readtable('data/DO_Sta14_10.csv','Delimiter',',','Format',formatSpec);

subplot(7,1,1); plot(datenum(DO_stn.DateTime),DO_stn.umol_L,'b');
xlim([min_date max_date]);ylim([0 550]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('DO (umol/L)')

DO= ncread(his1,'oxygen',[i j 1 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(7,1,1); plot(date1,DO(:),'r');
skill(datenum(DO_stn.DateTime),DO_stn.umol_L, date1, DO(:))


%% --TC-09 (R2) ---
% i=17;j=150;
% i=18;j=150; %checked
i=17;j=150;

DO_stn = readtable('data/DO_TC09_10.csv','Delimiter',',','Format',formatSpec);

subplot(7,1,2); plot(datenum(DO_stn.DateTime),DO_stn.umol_L,'b');
xlim([min_date max_date]);ylim([0 550]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('DO (umol/L)')

DO= ncread(his1,'oxygen',[i j 1 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(7,1,2); plot(date1,DO(:),'r');
skill(datenum(DO_stn.DateTime),DO_stn.umol_L, date1, DO(:))

%% --TC-07 (R3) ---
% i=22;j=129;
i=24;j=131; %checked
DO_stn = readtable('data/DO_TC07_10.csv','Delimiter',',','Format',formatSpec);

subplot(7,1,3); plot(datenum(DO_stn.DateTime),DO_stn.umol_L,'b');
xlim([min_date max_date]);ylim([0 550]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('DO (umol/L)')

DO= ncread(his1,'oxygen',[i j 1 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(7,1,3); plot(date1,DO(:),'r');
skill(datenum(DO_stn.DateTime),DO_stn.umol_L, date1, DO(:))

%% --TS-05 (R4) ---
% i=25;j=118;
i=23;j=119; %checked
DO_stn = readtable('data/DO_TS05_10.csv','Delimiter',',','Format',formatSpec);

subplot(7,1,4); plot(datenum(DO_stn.DateTime),DO_stn.umol_L,'b');
xlim([min_date max_date]);ylim([0 550]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('DO (umol/L)')

DO= ncread(his1,'oxygen',[i j 1 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(7,1,4); plot(date1,DO(:),'r');
skill(datenum(DO_stn.DateTime),DO_stn.umol_L, date1, DO(:))

%% --TS-03 (R7) ---
% i=17;j=89;
% i=14;j=90; % checked
% i=13;j=90;
i=15;j=90;
DO_stn = readtable('data/DO_TS03_10.csv','Delimiter',',','Format',formatSpec);

subplot(7,1,5); plot(datenum(DO_stn.DateTime),DO_stn.umol_L,'b');
xlim([min_date max_date]);ylim([0 550]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('DO (umol/L)')

DO= ncread(his1,'oxygen',[i j 1 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(7,1,5); plot(date1,DO(:),'r');
skill(datenum(DO_stn.DateTime),DO_stn.umol_L, date1, DO(:))

%% --P2 (R9)---
% i=19;j=34;
i=20;j=35; % checked
DO_stn = readtable('data/DO_P2_10.csv','Delimiter',',','Format',formatSpec);

subplot(7,1,6); plot(datenum(DO_stn.DateTime),DO_stn.umol_L,'b');
xlim([min_date max_date]);ylim([0 550]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('DO (umol/L)')

DO= ncread(his1,'oxygen',[i j 1 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(7,1,6); plot(date1,DO(:),'r');
skill(datenum(DO_stn.DateTime),DO_stn.umol_L, date1, DO(:))

%% --H03 (R10) ---
% i=7 ;j=26; % checked
% i=10;j=19;
i=8 ;j=26; %
% i=9 ;j=26; %

DO_stn = readtable('data/DO_H03_10.csv','Delimiter',',','Format',formatSpec);

subplot(7,1,7); plot(datenum(DO_stn.DateTime),DO_stn.umol_L,'b');
xlim([min_date max_date]);ylim([0 550]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('DO (umol/L)')

DO= ncread(his1,'oxygen',[i j 1 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(7,1,7); plot(date1,DO(:),'r');
skill(datenum(DO_stn.DateTime),DO_stn.umol_L, date1, DO(:))


samexaxis('abc','xmt','on','ytac','join','yld',1)

