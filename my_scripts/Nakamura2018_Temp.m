
% his1='D:\ROMS\output\Shiraho_reef\OAv12_ctrl\ocean_his_10.nc';
% his1='K:\ROMS\output\Shiraho_reef\test01\ocean_his_10.nc';
% his1='K:\ROMS\output\Shiraho_reef\test01\ocean_his_10cwm.nc';
his1='K:\ROMS\output\Shiraho_reef\bleaching02\ocean_his_10_29.5.nc';
xls = 'data\Temp_2010.xlsx';

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
%% 

[num_e,txt_e,raw] = xlsread(xls,'Data_EM','A3:G711');
[num_d1,txt_d1,raw] = xlsread(xls,'Data_DOW','A3:G2127');
[num_d2,txt_d2,raw] = xlsread(xls,'Data_DOW','H3:I1419');
%% 
ymin=26.5; ymax=37.5;

%% --Sta14 (O1) ---DO
% i=28;j=24;
i=27;j=24;

subplot(11,1,1); plot(datenum(txt_d2), num_d2,'b');
xlim([min_date max_date]);ylim([ymin ymax]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Temp.(oC)')
data= ncread(his1,'temp',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(11,1,1); plot(date1,data(:),'r');
skill(datenum(txt_d2), num_d2, date1, data(:))

%% --TC-10 (R1) ---WLL
i=16;j=158;
%% --TC-09 (R2) ---DO
% i=17;j=150;
% i=18;j=150; %checked
i=17;j=150;

subplot(11,1,2); plot(datenum(txt_d1), num_d1(:,3),'b');
xlim([min_date max_date]);ylim([ymin ymax]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Temp.(oC)')
data= ncread(his1,'temp',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(11,1,2); plot(date1,data(:),'r');
skill(datenum(txt_d1), num_d1(:,3), date1, data(:))

%% --TC-07 (R3) ---EM
i=24;j=129;
% i=24;j=131;

subplot(11,1,3); plot(datenum(txt_e), num_e(:,4),'b');
xlim([min_date max_date]);ylim([ymin ymax]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Temp.(oC)')
data= ncread(his1,'temp',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(11,1,3); plot(date1,data(:),'r');
skill(datenum(txt_e), num_e(:,4), date1, data(:))

%% --TS-05 (R4) ---DO
% i=25;j=118;
i=23;j=119; %checked

subplot(11,1,4); plot(datenum(txt_d1), num_d1(:,4),'b');
xlim([min_date max_date]);ylim([ymin ymax]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Temp.(oC)')
data= ncread(his1,'temp',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(11,1,4); plot(date1,data(:),'r');
skill(datenum(txt_d1), num_d1(:,4), date1, data(:))

%% --TC-06 (R5) ---EM
% i=34;j=112;
i=33;j=112;

subplot(11,1,5); plot(datenum(txt_e), num_e(:,3),'b');
xlim([min_date max_date]);ylim([ymin ymax]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Temp.(oC)')
data= ncread(his1,'temp',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(11,1,5); plot(date1,data(:),'r');
skill(datenum(txt_e), num_e(:,3), date1, data(:))

%% --TC-03 (R6) ---EM
i=26;j=92;

subplot(11,1,6); plot(datenum(txt_e), num_e(:,2),'b');
xlim([min_date max_date]);ylim([ymin ymax]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Temp.(oC)')
data= ncread(his1,'temp',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(11,1,6); plot(date1,data(:),'r');
skill(datenum(txt_e), num_e(:,2), date1, data(:))

%% --TS-03 (R7) ---DO
% i=17;j=89;
% i=14;j=90; % checked
% i=13;j=90;
i=15;j=90;

subplot(11,1,7); plot(datenum(txt_d1), num_d1(:,5),'b');
xlim([min_date max_date]);ylim([ymin ymax]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Temp.(oC)')
data= ncread(his1,'temp',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(11,1,7); plot(date1,data(:),'r');
skill(datenum(txt_d1), num_d1(:,5), date1, data(:))

%% --TC-02 (R8) ---WLL
i=16;j=69;
%% --P2 (R9) ---EM,DO
i=19;j=34;

subplot(11,1,8); plot(datenum(txt_d1), num_d1(:,1),'b');
xlim([min_date max_date]);ylim([ymin ymax]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Temp.(oC)')
data= ncread(his1,'temp',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(11,1,8); plot(date1,data(:),'r');
skill(datenum(txt_d1), num_d1(:,1), date1, data(:))

%% --H03 (R10) ---DO
% i=7 ;j=26; % checked
% i=10;j=19;
i=8 ;j=26; %
% i=9 ;j=26; %

subplot(11,1,9); plot(datenum(txt_d1), num_d1(:,6),'b');
xlim([min_date max_date]);ylim([ymin ymax]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Temp.(oC)')
data= ncread(his1,'temp',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(11,1,9); plot(date1,data(:),'r');
skill(datenum(txt_d1), num_d1(:,6), date1, data(:))

%% --Sta8 (R11)---EM
i=20;j=17;

subplot(11,1,10); plot(datenum(txt_e), num_e(:,5),'b');
xlim([min_date max_date]);ylim([ymin ymax]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Temp.(oC)')
data= ncread(his1,'temp',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(11,1,10); plot(date1,data(:),'r');
skill(datenum(txt_e), num_e(:,5), date1, data(:))

%% --Sta13 (R12) ---EM
i=17;j=7;

subplot(11,1,11); plot(datenum(txt_e), num_e(:,6),'b');
xlim([min_date max_date]);ylim([ymin ymax]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Temp.(oC)')
data= ncread(his1,'temp',[i j 2 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(11,1,11); plot(date1,data(:),'r');
skill(datenum(txt_e), num_e(:,6), date1, data(:))

samexaxis('abc','xmt','on','ytac','join','yld',1)


