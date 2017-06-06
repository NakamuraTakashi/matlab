
his1='D:\ROMS\output\Shiraho_reef\OAv12_ctrl\ocean_his_10.nc';

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
i=27;j=24;

WLL_stn = readtable('data/WLL_Sta14_10.csv','Delimiter',',','Format',formatSpec);
diff=9.15;
subplot(4,1,1); plot(datenum(WLL_stn.DateTime), WLL_stn.m - diff,'b');
xlim([min_date max_date]);ylim([-0.7 1.4]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Elevation (m)')

WLL= ncread(his1,'zeta',[i j 1],[1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(4,1,1); plot(date1,WLL(:),'r');
skill(datenum(WLL_stn.DateTime), WLL_stn.m - diff, date1, WLL(:))


%% --TC-10 (R1) ---
i=16;j=158;

WLL_stn = readtable('data/WLL_TC10_10.csv','Delimiter',',','Format',formatSpec);
diff=1.35;
subplot(4,1,2); plot(datenum(WLL_stn.DateTime), WLL_stn.m - diff,'b');
xlim([min_date max_date]);ylim([-0.7 1.4]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Elevation (m)')

WLL= ncread(his1,'zeta',[i j 1],[1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(4,1,2); plot(date1,WLL(:),'r');
skill(datenum(WLL_stn.DateTime), WLL_stn.m - diff, date1, WLL(:))

%% --TC-02 (R8) ---
i=16;j=69;

WLL_stn = readtable('data/WLL_TC02_10.csv','Delimiter',',','Format',formatSpec);
diff=2.2;
subplot(4,1,3); plot(datenum(WLL_stn.DateTime), WLL_stn.m - diff,'b');
xlim([min_date max_date]);ylim([-0.7 1.4]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Elevation (m)')

WLL= ncread(his1,'zeta',[i j 1],[1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(4,1,3); plot(date1,WLL(:),'r');
skill(datenum(WLL_stn.DateTime), WLL_stn.m - diff, date1, WLL(:))

%% --Sta13 (R12) ---
i=17;j=7;

WLL_stn = readtable('data/WLL_Sta13_10.csv','Delimiter',',','Format',formatSpec);
diff=1.6;
subplot(4,1,4); plot(datenum(WLL_stn.DateTime), WLL_stn.m - diff,'b');
xlim([min_date max_date]);ylim([-0.7 1.4]);
datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Elevation (m)')

WLL= ncread(his1,'zeta',[i j 1],[1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(4,1,4); plot(date1,WLL(:),'r');
skill(datenum(WLL_stn.DateTime), WLL_stn.m - diff, date1, WLL(:))

samexaxis('abc','xmt','on','ytac','join','yld',1)

