
% his1='D:\ROMS\output\Shiraho_reef\OAv12_ctrl\ocean_his_10.nc';
his1='K:\ROMS\output\Shiraho_reef\bleaching02\ocean_his_10_29.5.nc';

% formatSpec = '%{yyyy/MM/dd HH:mm}D%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
formatSpec = '%{yyyy/MM/dd HH:mm}D%s%f%f%f%f%f%f%f%f%f%f%f%f%f';

% WQdata = readtable('data/IS2010_WQdata2.csv','Delimiter',',','Format',formatSpec);
WQdata = readtable('data/IS2010_WQdata.csv','Delimiter',',','Format',formatSpec);

starting_date=datenum(2010,8,20,0,0,0); % for Shiraho
%% 

% ********** TC-03 (R3) ***************************************************
% i=21;j=88;
% index=find(strcmp(WQdata.Site,'TC03'));
%% ********** TC-09_2010 (R2) ***************************************************
% i=20;j=150;
% i=18;j=150; %checked
i=17;j=150;

figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'GraphicsSmoothing','off',...
    'OuterPosition',[0 0 400 400]);

index=find(strcmp(WQdata.Site,'TC-09'));
% min_date=datenum(data2009.Time(index(1)));
% max_date=datenum(data2009.Time(index(size(index,1))));
min_date=datenum(2010,8,24,0,0,0);
max_date=datenum(2010,8,28,0,0,0);

subplot(2,1,1); plot(datenum(WQdata.Time(index)), WQdata.DIC(index),'ob',...
    'LineWidth',0.2,...
    'MarkerSize',4)

xlim([min_date max_date]);ylim([1350 2250]);
ax = gca;
ax.XTick = min_date:(1/4):max_date;
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','hh:MM','keeplimits','keepticks');
ylabel('DIC (umol kg-1)')

DIC= ncread(his1,'TIC',[i j 8 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(2,1,1); plot(date1,DIC(:),'r');
legend('Obs.','Comp.');
skill(datenum(WQdata.Time(index)),WQdata.DIC(index), date1, DIC(:))

subplot(2,1,2); plot(datenum(WQdata.Time(index)), WQdata.TA(index),'ob',...
    'LineWidth',0.2,...
    'MarkerSize',4)
xlim([min_date max_date]);ylim([1950 2350]);
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','hh:MM','keeplimits','keepticks');
ylabel('TA (umol kg-1)')

TA= ncread(his1,'alkalinity',[i j 8 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(2,1,2); plot(date1,TA(:),'r');
skill(datenum(WQdata.Time(index)),WQdata.TA(index), date1, TA(:))

samexaxis('abc','xmt','on','ytac','join','yld',1)

%% 

% ************* P2 (R7) ***************************************************
% i=18;j=35;
% index=find(strcmp(WQdata.Site,'P2'));
%% ************* P2_2010 (R9) ***************************************************
% i=19;j=34;
i=20;j=35; % checked

figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'GraphicsSmoothing','off',...
    'OuterPosition',[0 0 400 400]);

index=find(strcmp(WQdata.Site,'P2'));
% min_date=datenum(data2009.Time(index(1)));
% max_date=datenum(data2009.Time(index(size(index,1))));
min_date=datenum(2010,8,24,0,0,0);
max_date=datenum(2010,8,28,0,0,0);

subplot(2,1,1); plot(datenum(WQdata.Time(index)), WQdata.DIC(index),'ob',...
    'LineWidth',0.2,...
    'MarkerSize',4)

xlim([min_date max_date]);ylim([1350 2250]);
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','hh:MM','keeplimits','keepticks');
ylabel('DIC (umol kg-1)')

DIC= ncread(his1,'TIC',[i j 8 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(2,1,1); plot(date1,DIC(:),'r');
skill(datenum(WQdata.Time(index)),WQdata.DIC(index), date1, DIC(:))

subplot(2,1,2); plot(datenum(WQdata.Time(index)), WQdata.TA(index),'ob',...
    'LineWidth',0.2,...
    'MarkerSize',4)
xlim([min_date max_date]);ylim([1950 2350]);
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','hh:MM','keeplimits','keepticks');
ylabel('TA (umol kg-1)')

TA= ncread(his1,'alkalinity',[i j 8 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(2,1,2); plot(date1,TA(:),'r');
skill(datenum(WQdata.Time(index)),WQdata.TA(index), date1, TA(:))

samexaxis('abc','xmt','on','ytac','join','yld',1)

%% 

% ************** TS-02 (R4) ***********************************************
% i=14;j=83;
% index=find(strcmp(WQdata.Site,'TS02'));
%% ************** TS-03_2010 (R7) ***********************************************
% i=14;j=90; % checked
i=15;j=90;
% i=16;j=85;

figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'GraphicsSmoothing','off',...
    'OuterPosition',[0 0 400 400]);

index=find(strcmp(WQdata.Site,'TS-03'));
% min_date=datenum(data2009.Time(index(1)));
% max_date=datenum(data2009.Time(index(size(index,1))));
min_date=datenum(2010,8,24,0,0,0);
max_date=datenum(2010,8,28,0,0,0);

subplot(2,1,1); plot(datenum(WQdata.Time(index)), WQdata.DIC(index),'ob',...
    'LineWidth',0.2,...
    'MarkerSize',4)

xlim([min_date max_date]);ylim([1350 2250]);
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','hh:MM','keeplimits','keepticks');
ylabel('DIC (umol kg-1)')
DIC= ncread(his1,'TIC',[i j 8 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(2,1,1); plot(date1,DIC(:),'r');
skill(datenum(WQdata.Time(index)),WQdata.DIC(index), date1, DIC(:))

subplot(2,1,2); plot(datenum(WQdata.Time(index)), WQdata.TA(index),'ob',...
    'LineWidth',0.2,...
    'MarkerSize',4)
xlim([min_date max_date]);ylim([1800 2500]);
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','hh:MM','keeplimits','keepticks');
ylabel('TA (umol kg-1)')

TA= ncread(his1,'alkalinity',[i j 8 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(2,1,2); plot(date1,TA(:),'r');
skill(datenum(WQdata.Time(index)),WQdata.TA(index), date1, TA(:))

samexaxis('abc','xmt','on','ytac','join','yld',1)

%% 

%% ********** H03 (R10) *****************************************************
% i=8 ;j=25;
% i=7 ;j=26; % checked
i=8 ;j=26; %
% i=9 ;j=26; %

figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'GraphicsSmoothing','off',...
    'OuterPosition',[0 0 400 400]);

index=find(strcmp(WQdata.Site,'H03'));
% min_date=datenum(data2009.Time(index(1)));
% max_date=datenum(data2009.Time(index(size(index,1))));
min_date=datenum(2010,8,24,0,0,0);
max_date=datenum(2010,8,28,0,0,0);

subplot(2,1,1); plot(datenum(WQdata.Time(index)), WQdata.DIC(index),'ob',...
    'LineWidth',0.2,...
    'MarkerSize',4)

xlim([min_date max_date]);ylim([1150 2250]);
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','hh:MM','keeplimits','keepticks');
ylabel('DIC (umol kg-1)')
DIC= ncread(his1,'TIC',[i j 8 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(2,1,1); plot(date1,DIC(:),'r');
skill(datenum(WQdata.Time(index)),WQdata.DIC(index), date1, DIC(:))

subplot(2,1,2); plot(datenum(WQdata.Time(index)), WQdata.TA(index),'ob',...
    'LineWidth',0.2,...
    'MarkerSize',4)
xlim([min_date max_date]);ylim([1950 2350]);
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','hh:MM','keeplimits','keepticks');
ylabel('TA (umol kg-1)')

TA= ncread(his1,'alkalinity',[i j 8 1],[1 1 1 Inf]);
time1 = ncread(his1,'ocean_time');
date1=starting_date+time1/24/60/60;
hold on
subplot(2,1,2); plot(date1,TA(:),'r');
skill(datenum(WQdata.Time(index)),WQdata.TA(index), date1, TA(:))

samexaxis('abc','xmt','on','ytac','join','yld',1)

% 


