%addpath ('E:\Win7_MainPC\ROMS_results');
% grd='D:\ROMS\Shiraho_reef\OA5_Ctrl\Data\shiraho_reef_grid11.nc';
% his1='D:\ROMS\Shiraho_reef\OA5_Ctrl\ocean_his.nc';
% his2='D:\ROMS\Shiraho_reef\OA5_HpCO2\ocean_his.nc';
% his3='D:\ROMS\Shiraho_reef\OA5_HSL\ocean_his.nc';
% his4='D:\ROMS\Shiraho_reef\OA5_HSL-HpCO2\ocean_his.nc';
% his5='D:\ROMS\Shiraho_reef\OA5_MpCO2\ocean_his.nc';
% his6='D:\ROMS\Shiraho_reef\OA5_MSL\ocean_his.nc';
% his7='D:\ROMS\Shiraho_reef\OA5_MSL-MpCO2\ocean_his.nc';

grd='D:\ROMS\Data\Shiraho_reef\shiraho_reef_grid16.2.nc';
his1='D:\ROMS\output\Shiraho_reef\OAv12_ctrl\ocean_his_10.nc';
% his2='D:\ROMS\Shiraho_reef\OAv7_pCO2_RCP26\ocean_his.nc';
% his3='D:\ROMS\Shiraho_reef\OAv7_SL_RCP26\ocean_his.nc';
% his4='D:\ROMS\Shiraho_reef\OAv7_SL-pCO2_RCP26\ocean_his.nc';
his2='D:\ROMS\output\Shiraho_reef\OAv12_pCO2_RCP85\ocean_his_10.nc';
his3='D:\ROMS\output\Shiraho_reef\OAv12_SL_RCP85\ocean_his_10.nc';
his4='D:\ROMS\output\Shiraho_reef\OAv12_pCO2_SL_RCP85\ocean_his_10.nc';

Jm=192;   % Mm+2
Im=64;    % Lm+2

%i=17;j=33;
% i=18;j=36;
i=20;j=35; % P2_2010 (R9)

%i=954;%954;%864,882,900,918,936

time1 = ncread(his1,'ocean_time');
time3 = ncread(his3,'ocean_time');
dnum1=numel(time1);
dnum3=numel(time3);

zeta1 = ncread(his1,'zeta',[i j 1],[1 1 dnum1]);
zeta2 = ncread(his2,'zeta',[i j 1],[1 1 dnum3]);
zeta3 = ncread(his3,'zeta',[i j 1],[1 1 dnum3]);
zeta4 = ncread(his4,'zeta',[i j 1],[1 1 dnum3]);

% coral_QC1 = ncread(his1,'coral_orgC',[i j 1],[1 1 dnum1]);
% coral_QC3 = ncread(his3,'coral_orgC',[i j 1],[1 1 dnum3]);
% coral_Pn1 = ncread(his1,'coral_Pn',[i j 1],[1 1 dnum1]);
% coral_Pn3 = ncread(his3,'coral_Pn',[i j 1],[1 1 dnum3]);

Tau_ave1 = ncread(his1,'Tau_ave',[i j 1],[1 1 dnum1]);
Tau_ave2 = ncread(his2,'Tau_ave',[i j 1],[1 1 dnum3]);
Tau_ave3 = ncread(his3,'Tau_ave',[i j 1],[1 1 dnum3]);
Tau_ave4 = ncread(his4,'Tau_ave',[i j 1],[1 1 dnum3]);

%Hwave= ncread(his,'Hwave',[i,0,0],[1,Jm,Im]);
%Dwave= ncread(his,'Dwave',[i,0 0],[1,Jm,Im]); 
%temp = ncread(his,'temp',[i,7,0 0],[1,1,Jm,Im]);
%salt = ncread(his,'salt',[i,7,0 0],[1,1,Jm,Im]);
%mud_01= ncread(his,'mud_01',[i,7,0 0],[1,1,Jm,Im]);
%DIC  = ncread(his,'TIC',[i,7,0 0],[1,1,Jm,Im]);
% TA1   = ncread(his1,'alkalinity',[0 7 j i],[dnum1 1 1 1]) ;
%DO   = ncread(his,'oxygen',[i,7,0 0],[1,1,Jm,Im]);
%DI13C    = ncread(his,'TI13C',[i,7,0 0],[1,1,Jm,Im]);
%d13C_DIC = ncread(his,'d13C_DIC',[i,7,0 0],[1,1,Jm,Im]);
%pH= ncread(his,'pH',[i,0 0],[1,Jm,Im]);

Warg1= ncread(his1,'Omega_arg',[i j 1],[1 1 dnum1]);
Warg2= ncread(his2,'Omega_arg',[i j 1],[1 1 dnum3]);
Warg3= ncread(his3,'Omega_arg',[i j 1],[1 1 dnum3]);
Warg4= ncread(his4,'Omega_arg',[i j 1],[1 1 dnum3]);

PARbot1= ncread(his1,'PARbot',[i j 1],[1 1 dnum1]);
PARbot2= ncread(his2,'PARbot',[i j 1],[1 1 dnum3]);
PARbot3= ncread(his3,'PARbot',[i j 1],[1 1 dnum3]);
PARbot4= ncread(his4,'PARbot',[i j 1],[1 1 dnum3]);

DO1= ncread(his1,'oxygen',[i j 8 1],[1 1 1 dnum1]);
DO2= ncread(his2,'oxygen',[i j 8 1],[1 1 1 dnum3]);
DO3= ncread(his3,'oxygen',[i j 8 1],[1 1 1 dnum3]);
DO4= ncread(his4,'oxygen',[i j 8 1],[1 1 1 dnum3]);

coral_G1 = ncread(his1,'coral1_G',[i j 1],[1 1 dnum1]);
coral_G2 = ncread(his2,'coral1_G',[i j 1],[1 1 dnum3]);
coral_G3 = ncread(his3,'coral1_G',[i j 1],[1 1 dnum3]);
coral_G4 = ncread(his4,'coral1_G',[i j 1],[1 1 dnum3]);

coral_Pg1 = ncread(his1,'coral1_Pg',[i j 1],[1 1 dnum1]);
coral_Pg2 = ncread(his2,'coral1_Pg',[i j 1],[1 1 dnum3]);
coral_Pg3 = ncread(his3,'coral1_Pg',[i j 1],[1 1 dnum3]);
coral_Pg4 = ncread(his4,'coral1_Pg',[i j 1],[1 1 dnum3]);

coral_R1 = ncread(his1,'coral1_R',[i j 1],[1 1 dnum1]);
coral_R2 = ncread(his2,'coral1_R',[i j 1],[1 1 dnum3]);
coral_R3 = ncread(his3,'coral1_R',[i j 1],[1 1 dnum3]);
coral_R4 = ncread(his4,'coral1_R',[i j 1],[1 1 dnum3]);

% TA1   = ncread(his1,'alkalinity',[i j 8 1],[1 1 1 dnum1]);
% TA3   = ncread(his3,'alkalinity',[i j 8 1],[1 1 1 dnum3]);
% DIC1   = ncread(his1,'TIC',[i j 8 1],[1 1 1 dnum1]);
% DIC3   = ncread(his3,'TIC',[i j 8 1],[1 1 1 dnum3]);

% pH1= ncread(his1,'pH',[i j 1],[1 1 dnum1]);
% pH3= ncread(his3,'pH',[i j 1],[1 1 dnum3]);
%% 

% starting_date=datenum(2009,8,25,0,0,0); % for Shiraho
starting_date=datenum(2010,8,20,0,0,0); % for Shiraho
date1=starting_date+time1/24/60/60;
date3=starting_date+time3/24/60/60;
% min_date=datenum(2009,9,5,0,0,0);
% max_date=datenum(2009,9,8,0,0,0);
% min_date=datenum(2009,9,5,0,0,0);
% max_date=datenum(2009,9,8,0,0,0);
min_date=datenum(2010,8,24,0,0,0);
max_date=datenum(2010,8,28,0,0,0);

figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'GraphicsSmoothing','off',...
    'OuterPosition',[0 0 400 700]);

Nsub=4;
n=1;
% Subplot 1 1
subplot(Nsub,1,n); plot(date1,PARbot1(:),'m');
hold on
subplot(Nsub,1,n); plot(date3,PARbot2(:),'b');
hold on
subplot(Nsub,1,n); plot(date3,PARbot3(:),'g');
hold on
subplot(Nsub,1,n); plot(date3,PARbot4(:),'r');
axis([min_date max_date 0 3000])
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Photon flux density')
legend('Present condition','Case1, RCP8.5','Case2, RCP8.5','Case3, RCP8.5');
n=n+1;

% Subplot 1 2
subplot(Nsub,1,n); plot(date1,zeta1(:),'m');
hold on
subplot(Nsub,1,n); plot(date3,zeta2(:),'b');
hold on
subplot(Nsub,1,n); plot(date3,zeta3(:),'g');
hold on
subplot(Nsub,1,n); plot(date3,zeta4(:),'r');
axis([min_date max_date -0.7 2.4])
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Elevation')
% legend('Present condition','Case2, RCP8.5');
n=n+1;

% Subplot 1 3
subplot(Nsub,1,n); plot(date1,Tau_ave1(:),'m');
hold on
subplot(Nsub,1,n); plot(date3,Tau_ave2(:),'b');
hold on
subplot(Nsub,1,n); plot(date3,Tau_ave3(:),'g');
hold on
subplot(Nsub,1,n); plot(date3,Tau_ave4(:),'r');
axis([min_date max_date 0 4.5])
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Tau')
% legend('Present condition','Case2, RCP8.5');
n=n+1;

% Subplot 1 4
subplot(Nsub,1,n); plot(date1,DO1(:),'m');
hold on
subplot(Nsub,1,n); plot(date3,DO2(:),'b');
hold on
subplot(Nsub,1,n); plot(date3,DO3(:),'g');
hold on
subplot(Nsub,1,n); plot(date3,DO4(:),'r');
axis([min_date max_date 90 280])
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('DO')
% legend('Present condition','Case2, RCP8.5');
n=n+1;
samexaxis('abc','xmt','on','ytac','join','yld',1)
%% 


figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'GraphicsSmoothing','off',...
    'OuterPosition',[0 0 400 700]);

Nsub=4;
n=1;

% Subplot 1 5
subplot(Nsub,1,n); plot(date1,Warg1(:),'m');
hold on
subplot(Nsub,1,n); plot(date3,Warg2(:),'b');
hold on
subplot(Nsub,1,n); plot(date3,Warg3(:),'g');
hold on
subplot(Nsub,1,n); plot(date3,Warg4(:),'r');
axis([min_date max_date 0.5 5.2])
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Aragonite saturation state')
% legend('Present condition','Case2, RCP8.5');
n=n+1;


% Subplot 1 5
% subplot(Nsub,2,n); plot(date1,DIC1(:),'b');
% hold on
% subplot(Nsub,2,n); plot(date3,DIC3(:),'r');
% axis([min_date max_date 1600 2100])
% ax = gca;
% ax.XTick = [min_date:(1/4):max_date];
% ax.XTickLabel = {'0:00','','12:00','','0:00','','12:00','','0:00'};
% % datetick('x','dd-mmm','keeplimits','keepticks');
% ylabel('DIC')
% % legend('Present condition','Case2, RCP8.5');
% n=n+1;

% Subplot 1 5
% subplot(Nsub,2,n); plot(date1,TA1(:),'b');
% hold on
% subplot(Nsub,2,n); plot(date3,TA3(:),'r');
% axis([min_date max_date 2000 2250])
% ax = gca;
% ax.XTick = [min_date:(1/4):max_date];
% ax.XTickLabel = {'0:00','','12:00','','0:00','','12:00','','0:00'};
% % datetick('x','dd-mmm','keeplimits','keepticks');
% ylabel('TA')
% % legend('Present condition','Case2, RCP8.5');
% n=n+1;

% Subplot 1 5
% subplot(Nsub,2,n); plot(date1,pH1(:),'b');
% hold on
% subplot(Nsub,2,n); plot(date3,pH3(:),'r');
% axis([min_date max_date 7.7 8.3])
% ax = gca;
% ax.XTick = [min_date:(1/4):max_date];
% ax.XTickLabel = {'0:00','','12:00','','0:00','','12:00','','0:00'};
% % datetick('x','dd-mmm','keeplimits','keepticks');
% ylabel('pH')
% % legend('Present condition','Case2, RCP8.5');
% n=n+1;

% Subplot 2 1
subplot(Nsub,1,n); plot(date1,coral_Pg1(:),'m');
hold on
subplot(Nsub,1,n); plot(date3,coral_Pg2(:),'b');
hold on
subplot(Nsub,1,n); plot(date3,coral_Pg3(:),'g');
hold on
subplot(Nsub,1,n); plot(date3,coral_Pg4(:),'r');
axis([min_date max_date 0 0.65])
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('Pg')
% legend('Present condition','Case2, RCP8.5');
n=n+1;

% Subplot 2 2
% subplot(Nsub,2,n); plot(date1,coral_QC1(:),'b');
% hold on
% subplot(Nsub,2,n); plot(date3,coral_QC3(:),'r');
% axis([min_date max_date 0 20])
% ax = gca;
% ax.XTick = [min_date:(1/4):max_date];
% ax.XTickLabel = {'0:00','','12:00','','0:00','','12:00','','0:00'};
% % datetick('x','dd-mmm','keeplimits','keepticks');
% ylabel('Stored organic carbon')
% % legend('Present condition','Case2, RCP8.5');
% n=n+1;


% Subplot 2 3
subplot(Nsub,1,n); plot(date1,coral_R1(:),'m');
hold on
subplot(Nsub,1,n); plot(date3,coral_R2(:),'b');
hold on
subplot(Nsub,1,n); plot(date3,coral_R3(:),'g');
hold on
subplot(Nsub,1,n); plot(date3,coral_R4(:),'r');
axis([min_date max_date 0 0.36])
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('R')
% legend('Present condition','Case2, RCP8.5');
n=n+1;

% Subplot 2 4
subplot(Nsub,1,n); plot(date1,coral_G1(:),'m');
hold on
subplot(Nsub,1,n); plot(date3,coral_G2(:),'b');
hold on
subplot(Nsub,1,n); plot(date3,coral_G3(:),'g');
hold on
subplot(Nsub,1,n); plot(date3,coral_G4(:),'r');
axis([min_date max_date -0.02 0.12])
ax = gca;
ax.XTick = [min_date:(1/4):max_date];
ax.XTickLabel = {'0:00','','12:00',''};
% datetick('x','dd-mmm','keeplimits','keepticks');
ylabel('G')
% legend('Present condition','Case2, RCP8.5');
n=n+1;

samexaxis('abc','xmt','on','ytac','join','yld',1)

% plot(time1,coral_G1, time2,coral_G2, time3,coral_G3, time4,coral_G4);
% plot(time1,Tau_ave1, time2,Tau_ave2, time3,Tau_ave3, time4,Tau_ave4);
%plot(time1,Warg1, time2,Warg2, time3,Warg3, time4,Warg4);
%plot(time1,coral_QC1, time2,coral_QC2, time3,coral_QC3, time4,coral_QC4);
% plot(time1,coral_Pn1, time2,coral_Pn2, time3,coral_Pn3, time4,coral_Pn4);
% 
% Ctrl=mean2(coral_G1)
% HpCO2=mean2(coral_G2)
% HSL=mean2(coral_G3)
% HpCO2pHSL=mean2(coral_G4)
% MpCO2=mean2(coral_G5)
% MSL=mean2(coral_G6)
% MpCO2pMSL=mean2(coral_G7)
% 
% HpCO2/Ctrl*100
% HSL/Ctrl*100
% HpCO2pHSL/Ctrl*100
% MpCO2/Ctrl*100
% MSL/Ctrl*100
% MpCO2pMSL/Ctrl*100
% 
% Ctrl=mean2(coral_Pn1)
% HpCO2=mean2(coral_Pn2)
% HSL=mean2(coral_Pn3)
% HpCO2pHSL=mean2(coral_Pn4)
% HpCO2/Ctrl*100
% HSL/Ctrl*100
% HpCO2pHSL/Ctrl*100

