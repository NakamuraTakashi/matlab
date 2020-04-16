% === Copyright (c) 2015-2019 Takashi NAKAMURA  =====

% filename='data/channel_subday.txt';  % SWAT+ hourly output file 
% 
% fileID = fopen(filename);
% FormatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
% data = textscan(fileID, FormatSpec, 'HeaderLines',1);
% fclose(fileID);

NC_FILE = './output/Yaeyama_river_Nz15_const.nc';

TIME_REF = '2000-01-01 00:00:00';
% LOCAL_TIME = 9; % hours: UTC+9 (JST) 

% Shiraho grid river mouth setting
% xi_u = 63 ;
% eta_v = 191 ;
s_rho = 15 ;
river = 1 ;    % river 1: Nagura river
riv_X = 182;
riv_Y = 162;

riv_D = 0;  % east<->west:0,  south<->north:1
riv_D2= -1;  %  west->east or south-> north: 1, east->west or north-> south:-1

%% 
start_time = datetime(TIME_REF);

data_days = datenum('1990-01-01 00:00:00');
data_days2 = datenum('2100-01-01 00:00:00');
% river_time
sta_date = datenum(start_time);
riv_date(1) = data_days - sta_date;
riv_date(2) = data_days2 - sta_date;

days_sinc_TIME_REF = ['days since ', datestr(start_time,'yyyy-mm-dd HH:MM:ss')];

%% 
% Todoroki river
%      time(i,:)= num(:,1);

data_num = 2;

flow(1:river,1:data_num)= 0.5; % flo: m3/s
SS(1:river,1:data_num)  = 0.047; % sed: ton/hour -> kg/m3
DON1(1:river,1:data_num) = 33*0.5; % orgn: kgN/hour -> umolN/L
DON2(1:river,1:data_num) = 33*0.5; % orgn: kgN/hour -> umolN/L
DOP1(1:river,1:data_num) = 0.03*0.5; % sedp: kgP/hour -> umolP/L
DOP2(1:river,1:data_num) = 0.03*0.5; % sedp: kgP/hour -> umolP/L
NO3(1:river,1:data_num) = 19; % no3: kgN/hour -> umolN/L
PO4(1:river,1:data_num) = 0.3; % solp: kgP/hour -> umolP/L
NH4(1:river,1:data_num) = 1.6; % nh3: kgN/hour -> umolN/L
% NO2(1:river,1:data_num) = 0.2; % no2: kgN/hour -> umolN/L
Oxyg(1:river,1:data_num)= 200; % dox: kg/hour -> umol/L
temp(1:river,1:data_num)= 25; % temp: degC -> degC
DOC1(1:river,1:data_num) = 156*0.5; % DOC: kgC/hour -> umol/L
DOC2(1:river,1:data_num) = 156*0.5; % DOC: kgC/hour -> umol/L
POC1(1:river,1:data_num) = 10; % POC, CPOM: kgC/hour -> umolC/L
POC2(1:river,1:data_num) = 10; % POC, CPOM: kgC/hour -> umolC/L

PON1(1:river,1:data_num) = DON1(1:river,1:data_num)*0.1;
PON2(1:river,1:data_num) = DON2(1:river,1:data_num)*0.1;
DON1(1:river,1:data_num) = DON1(1:river,1:data_num)*0.9;
DON2(1:river,1:data_num) = DON2(1:river,1:data_num)*0.9;
POP1(1:river,1:data_num) = DOP1(1:river,1:data_num)*0.1;
POP2(1:river,1:data_num) = DOP2(1:river,1:data_num)*0.1;
DOP1(1:river,1:data_num) = DOP1(1:river,1:data_num)*0.9;
DOP2(1:river,1:data_num) = DOP2(1:river,1:data_num)*0.9;

PIC1(1:river,1:data_num) = 0; % POC, CPOM: kgC/hour -> umolC/L


salt(1:river,1:data_num) = 3;

alk(1:river,1:data_num)  = 1960;
TIC(1:river,1:data_num)  = 1600;

% river and seepage
Phy1(1:river,1:data_num) = 0;
Phy2(1:river,1:data_num) = 0;
Phy3(1:river,1:data_num) = 0;
Zoop(1:river,1:data_num) = 0;
d13C_TIC(1:river,1:data_num) = 0;
d13C_DOC1(1:river,1:data_num) = 0;
d13C_DOC2(1:river,1:data_num) = 0;
d13C_POC1(1:river,1:data_num) = 0;
d13C_POC2(1:river,1:data_num) = 100;
d13C_Phy1(1:river,1:data_num) = 0;
d13C_Phy2(1:river,1:data_num) = 0;
d13C_Phy3(1:river,1:data_num) = 0;
d13C_Zoo(1:river,1:data_num) = 0;

%% 
% ----- Create NetCDF river file ------------------------------------------
% river
nccreate(NC_FILE,'river',...
          'Dimensions',{'river',river},...
          'Datatype','double',...
          'Format','classic')
ncwriteatt(NC_FILE,'river','long_name','river runoff identification number');
% river_Xposition
nccreate(NC_FILE,'river_Xposition',...
          'Dimensions',{'river',river},...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Xposition','long_name','river XI-position');
ncwriteatt(NC_FILE,'river_Xposition','LuvSrc_meaning','i point index of U or V face source/sink');
ncwriteatt(NC_FILE,'river_Xposition','LwSrc_meaning','i point index of RHO center source/sink');
% river_Eposition
nccreate(NC_FILE,'river_Eposition',...
          'Dimensions',{'river',river},...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Eposition','long_name','river ETA-position');
ncwriteatt(NC_FILE,'river_Eposition','LuvSrc_meaning','j point index of U or V face source/sink');
ncwriteatt(NC_FILE,'river_Eposition','LwSrc_meaning','j point index of RHO center source/sink');
% river_direction
nccreate(NC_FILE,'river_direction',...
          'Dimensions',{'river',river},...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_direction','long_name','river runoff direction');
ncwriteatt(NC_FILE,'river_direction','flag_values', '0, 1');
ncwriteatt(NC_FILE,'river_direction','flag_meanings', 'flow across u-face, flow across v-face');
ncwriteatt(NC_FILE,'river_direction','LwSrc_True', 'flag not used');
% river_Vshape
nccreate(NC_FILE,'river_Vshape',...
          'Dimensions',{'river',river, 's_rho',s_rho },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Vshape','long_name','river runoff mass transport vertical profile');
ncwriteatt(NC_FILE,'river_Vshape','requires', 'must sum to 1 over s_rho');
% river_time
nccreate(NC_FILE,'river_time',...
          'Dimensions',{'river_time',data_num},...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_time','long_name','river runoff time');
ncwriteatt(NC_FILE,'river_time','units', days_sinc_TIME_REF);  %%% ïœçXïKóv!!!!!!!!!!!!!!!!!!!!!!!!!!!
% river_transport
nccreate(NC_FILE,'river_transport',...
          'Dimensions',{'river',river, 'river_time',data_num},...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_transport','long_name','river runoff vertically integrated mass transport');
ncwriteatt(NC_FILE,'river_transport','units','meter3 second-1');
ncwriteatt(NC_FILE,'river_transport','time','river_time');
% river_temp
nccreate(NC_FILE,'river_temp',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_temp','long_name','river runoff potential temperature');
ncwriteatt(NC_FILE,'river_temp','units','Celsius');
ncwriteatt(NC_FILE,'river_temp','time','river_time');
% river_salt
nccreate(NC_FILE,'river_salt',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_salt','long_name','river runoff salinity');
ncwriteatt(NC_FILE,'river_salt','time','river_time');
% river_mud_01
nccreate(NC_FILE,'river_mud_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_mud_01','long_name','iver runoff suspended sediment concentration');
ncwriteatt(NC_FILE,'river_mud_01','units','kilogram meter-3');
ncwriteatt(NC_FILE,'river_mud_01','time','river_time');
% river_TIC
nccreate(NC_FILE,'river_TIC',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_TIC','long_name','iver runoff TIC');
ncwriteatt(NC_FILE,'river_TIC','units','umol kg-1');
ncwriteatt(NC_FILE,'river_TIC','time','river_time');
% river_alkalinity
nccreate(NC_FILE,'river_alkalinity',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_alkalinity','long_name','river runoff alkalinity');
ncwriteatt(NC_FILE,'river_alkalinity','units','umol kg-1');
ncwriteatt(NC_FILE,'river_alkalinity','time','river_time');
% river_Oxyg
nccreate(NC_FILE,'river_Oxyg',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Oxyg','long_name','river runoff oxygen');
ncwriteatt(NC_FILE,'river_Oxyg','units','umol L-1');
ncwriteatt(NC_FILE,'river_Oxyg','time','river_time');
% river_NO3
nccreate(NC_FILE,'river_NO3',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_NO3','long_name','river runoff NO3');
ncwriteatt(NC_FILE,'river_NO3','units','umol L-1');
ncwriteatt(NC_FILE,'river_NO3','time','river_time');
% river_NO2
% nccreate(NC_FILE,'river_NO2',...
%           'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
%           'Datatype','double')
% ncwriteatt(NC_FILE,'river_NO2','long_name','river runoff NO2');
% ncwriteatt(NC_FILE,'river_NO2','units','umol L-1');
% ncwriteatt(NC_FILE,'river_NO2','time','river_time');
% river_NH4
nccreate(NC_FILE,'river_NH4',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_NH4','long_name','river runoff NH4');
ncwriteatt(NC_FILE,'river_NH4','units','umol L-1');
ncwriteatt(NC_FILE,'river_NH4','time','river_time');
% river_PO4
nccreate(NC_FILE,'river_PO4',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_PO4','long_name','river runoff PO4');
ncwriteatt(NC_FILE,'river_PO4','units','umol L-1');
ncwriteatt(NC_FILE,'river_PO4','time','river_time');
% river_DOC (LDOC)
nccreate(NC_FILE,'river_DOC_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_DOC_01','long_name','river runoff DOC');
ncwriteatt(NC_FILE,'river_DOC_01','units','umol L-1');
ncwriteatt(NC_FILE,'river_DOC_01','time','river_time');
% river_DOC (RDOC)
nccreate(NC_FILE,'river_DOC_02',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_DOC_02','long_name','river runoff DOC');
ncwriteatt(NC_FILE,'river_DOC_02','units','umol L-1');
ncwriteatt(NC_FILE,'river_DOC_02','time','river_time');
% river_DON
nccreate(NC_FILE,'river_DON_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_DON_01','long_name','river runoff DON');
ncwriteatt(NC_FILE,'river_DON_01','units','umol L-1');
ncwriteatt(NC_FILE,'river_DON_01','time','river_time');
% river_DON
nccreate(NC_FILE,'river_DON_02',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_DON_02','long_name','river runoff DON');
ncwriteatt(NC_FILE,'river_DON_02','units','umol L-1');
ncwriteatt(NC_FILE,'river_DON_02','time','river_time');
% river_DOP
nccreate(NC_FILE,'river_DOP_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_DOP_01','long_name','river runoff DOP');
ncwriteatt(NC_FILE,'river_DOP_01','units','umol L-1');
ncwriteatt(NC_FILE,'river_DOP_01','time','river_time');
% river_DOP
nccreate(NC_FILE,'river_DOP_02',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_DOP_02','long_name','river runoff DOP');
ncwriteatt(NC_FILE,'river_DOP_02','units','umol L-1');
ncwriteatt(NC_FILE,'river_DOP_02','time','river_time');
% river_POC
nccreate(NC_FILE,'river_POC_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_POC_01','long_name','river runoff POC');
ncwriteatt(NC_FILE,'river_POC_01','units','umol L-1');
ncwriteatt(NC_FILE,'river_POC_01','time','river_time');
% river_POC
nccreate(NC_FILE,'river_POC_02',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_POC_02','long_name','river runoff POC');
ncwriteatt(NC_FILE,'river_POC_02','units','umol L-1');
ncwriteatt(NC_FILE,'river_POC_02','time','river_time');
% river_PON
nccreate(NC_FILE,'river_PON_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_PON_01','long_name','river runoff PON');
ncwriteatt(NC_FILE,'river_PON_01','units','umol L-1');
ncwriteatt(NC_FILE,'river_PON_01','time','river_time');
% river_PON
nccreate(NC_FILE,'river_PON_02',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_PON_02','long_name','river runoff PON');
ncwriteatt(NC_FILE,'river_PON_02','units','umol L-1');
ncwriteatt(NC_FILE,'river_PON_02','time','river_time');
% river_POP
nccreate(NC_FILE,'river_POP_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_POP_01','long_name','river runoff POP');
ncwriteatt(NC_FILE,'river_POP_01','units','umol L-1');
ncwriteatt(NC_FILE,'river_POP_01','time','river_time');
% river_POP
nccreate(NC_FILE,'river_POP_02',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_POP_02','long_name','river runoff POP');
ncwriteatt(NC_FILE,'river_POP_02','units','umol L-1');
ncwriteatt(NC_FILE,'river_POP_02','time','river_time');
% river_Phy1
nccreate(NC_FILE,'river_Phyt_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Phyt_01','long_name','river runoff phytoplankton1');
ncwriteatt(NC_FILE,'river_Phyt_01','units','umolC L-1');
ncwriteatt(NC_FILE,'river_Phyt_01','time','river_time');
% river_Phy1
nccreate(NC_FILE,'river_Phyt_02',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Phyt_02','long_name','river runoff phytoplankton2');
ncwriteatt(NC_FILE,'river_Phyt_02','units','umolC L-1');
ncwriteatt(NC_FILE,'river_Phyt_02','time','river_time');
% river_Phy1
nccreate(NC_FILE,'river_Phyt_03',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Phyt_03','long_name','river runoff phytoplankton3');
ncwriteatt(NC_FILE,'river_Phyt_03','units','umolC L-1');
ncwriteatt(NC_FILE,'river_Phyt_03','time','river_time');
% river_Zoop
nccreate(NC_FILE,'river_Zoop_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Zoop_01','long_name','river runoff zooplankton1');
ncwriteatt(NC_FILE,'river_Zoop_01','units','umolC L-1');
ncwriteatt(NC_FILE,'river_Zoop_01','time','river_time');
% river_PIC
nccreate(NC_FILE,'river_PIC_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_PIC_01','long_name','river runoff PIC');
ncwriteatt(NC_FILE,'river_PIC_01','units','umol L-1');
ncwriteatt(NC_FILE,'river_PIC_01','time','river_time');
% river_d13C_TIC
nccreate(NC_FILE,'river_d13C_TIC',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_TIC','long_name','river runoff d13C in DIC');
ncwriteatt(NC_FILE,'river_d13C_TIC','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_TIC','time','river_time');
% river_d13C_DOC
nccreate(NC_FILE,'river_d13C_DOC_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_DOC_01','long_name','river runoff d13C in DOC');
ncwriteatt(NC_FILE,'river_d13C_DOC_01','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_DOC_01','time','river_time');
% river_d13C_DOC
nccreate(NC_FILE,'river_d13C_DOC_02',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_DOC_02','long_name','river runoff d13C in DOC');
ncwriteatt(NC_FILE,'river_d13C_DOC_02','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_DOC_02','time','river_time');
% river_d13C_POC
nccreate(NC_FILE,'river_d13C_POC_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_POC_01','long_name','river runoff d13C in POC');
ncwriteatt(NC_FILE,'river_d13C_POC_01','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_POC_01','time','river_time');
% river_d13C_POC
nccreate(NC_FILE,'river_d13C_POC_02',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_POC_02','long_name','river runoff d13C in POC');
ncwriteatt(NC_FILE,'river_d13C_POC_02','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_POC_02','time','river_time');
% river_d13C_Phy1
nccreate(NC_FILE,'river_d13C_Phyt_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_Phyt_01','long_name','river runoff d13C in phtoplankton1');
ncwriteatt(NC_FILE,'river_d13C_Phyt_01','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_Phyt_01','time','river_time');
% river_d13C_Phy1
nccreate(NC_FILE,'river_d13C_Phyt_02',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_Phyt_02','long_name','river runoff d13C in phtoplankton1');
ncwriteatt(NC_FILE,'river_d13C_Phyt_02','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_Phyt_02','time','river_time');
% river_d13C_Phy1
nccreate(NC_FILE,'river_d13C_Phyt_03',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_Phyt_03','long_name','river runoff d13C in phtoplankton1');
ncwriteatt(NC_FILE,'river_d13C_Phyt_03','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_Phyt_03','time','river_time');
% river_d13C_Zoo
nccreate(NC_FILE,'river_d13C_Zoop_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_Zoop_01','long_name','river runoff d13C in zooplankton');
ncwriteatt(NC_FILE,'river_d13C_Zoop_01','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_Zoop_01','time','river_time');
% global attributes
ncwriteatt(NC_FILE,'/','type','ROMS FORCING file');
ncwriteatt(NC_FILE,'/','title','Todoroki River Forcing');
ncwriteatt(NC_FILE,'/','grd_file','shiraho_reef_grid16.3.nc');
% ncwriteatt(NC_FILE,'/','rivers','(1)Nakama river, (2) Nagura river, (3) Arakawa river, (4) Miyara river, (5) Todoroki river');
ncwriteatt(NC_FILE,'/','rivers','(1)Todoroki river, (2) submarine groundwater discharge');

%% 
% ----- Add data to NetCDF river file ------------------------------------------
% river
ncwrite(NC_FILE,'river',1:river);
% river_Xposition
ncwrite(NC_FILE,'river_Xposition',riv_X);
% river_Eposition
ncwrite(NC_FILE,'river_Eposition',riv_Y);
% river_direction
ncwrite(NC_FILE,'river_direction',riv_D(1:river));
% river_Vshap
riv_V(1)=0;
for i=2:s_rho
    riv_V(i)=riv_V(i-1)+2/s_rho/(s_rho-1);
end
for i=1:river
    riv_Vshape(i,:) = riv_V;
end
ncwrite(NC_FILE,'river_Vshape',riv_Vshape);

% river_time
ncwrite(NC_FILE,'river_time',riv_date);

% river_transport
for i=1:river
    riv_flow(i,:) = flow(i,:)*riv_D2(i);
end
ncwrite(NC_FILE,'river_transport',riv_flow);

% river_PO4
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = PO4(i,:);
    end
end
ncwrite(NC_FILE,'river_PO4',riv_value(1:river, :, :));

% river_NO3
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = NO3(i,:);
    end
end
ncwrite(NC_FILE,'river_NO3',riv_value(1:river, :, :));

% river_NH4
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = NH4(i,:);
    end
end
ncwrite(NC_FILE,'river_NH4',riv_value(1:river, :, :));

% river_NO2
% for i=1:river
%     for j=1:s_rho
%         riv_value( i, j, 1:data_num ) = NO2(i,:);
%     end
% end
% ncwrite(NC_FILE,'river_NO2',riv_value(1:river, :, :));



% river_temp
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = temp(i,:);
    end
end
ncwrite(NC_FILE,'river_temp',riv_value(1:river, :, :));

% river_salt
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = salt(i,:);
    end
end
ncwrite(NC_FILE,'river_salt',riv_value(1:river, :, :));

% river_mud_01
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = SS(i,:);
    end
end
ncwrite(NC_FILE,'river_mud_01',riv_value(1:river, :, :));

% river_TIC
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = TIC(i,:);
    end
end
ncwrite(NC_FILE,'river_TIC',riv_value(1:river, :, :));

% river_alkalinity
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = alk(i,:);
    end
end
ncwrite(NC_FILE,'river_alkalinity',riv_value(1:river, :, :));

% river_Oxyg
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = Oxyg(i,:);
    end
end
ncwrite(NC_FILE,'river_Oxyg',riv_value(1:river, :, :));

% river_DOC
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = DOC1(i,:);
    end
end
ncwrite(NC_FILE,'river_DOC_01',riv_value(1:river, :, :));
% river_DOC
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = DOC2(i,:);
    end
end
ncwrite(NC_FILE,'river_DOC_02',riv_value(1:river, :, :));

% river_DON
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = DON1(i,:);
    end
end
ncwrite(NC_FILE,'river_DON_01',riv_value(1:river, :, :));
% river_DON
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = DON2(i,:);
    end
end
ncwrite(NC_FILE,'river_DON_02',riv_value(1:river, :, :));

% river_DOP
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = DOP1(i,:);
    end
end
ncwrite(NC_FILE,'river_DOP_01',riv_value(1:river, :, :));
% river_DOP
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = DOP2(i,:);
    end
end
ncwrite(NC_FILE,'river_DOP_02',riv_value(1:river, :, :));

% river_POC
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = POC1(i,:);
    end
end
ncwrite(NC_FILE,'river_POC_01',riv_value(1:river, :, :));

% river_POC
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = POC2(i,:);
    end
end
ncwrite(NC_FILE,'river_POC_02',riv_value(1:river, :, :));

% river_PON
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = PON1(i,:);
    end
end
ncwrite(NC_FILE,'river_PON_01',riv_value(1:river, :, :));
% river_PON
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = PON2(i,:);
    end
end
ncwrite(NC_FILE,'river_PON_02',riv_value(1:river, :, :));

% river_POP
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = POP1(i,:);
    end
end
ncwrite(NC_FILE,'river_POP_01',riv_value(1:river, :, :));
% river_POP
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = POP2(i,:);
    end
end
ncwrite(NC_FILE,'river_POP_02',riv_value(1:river, :, :));

% river_Phy1
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = Phy1(i,:);
    end
end
ncwrite(NC_FILE,'river_Phyt_01',riv_value(1:river, :, :));
% river_Phy1
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = Phy2(i,:);
    end
end
ncwrite(NC_FILE,'river_Phyt_02',riv_value(1:river, :, :));

% river_Phy2
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = Phy3(i,:);
    end
end
ncwrite(NC_FILE,'river_Phyt_03',riv_value(1:river, :, :));

% river_Zoop
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = Zoop(i,:);
    end
end
ncwrite(NC_FILE,'river_Zoop_01',riv_value(1:river, :, :));

% river_PIC
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = PIC1(i,:);
    end
end
ncwrite(NC_FILE,'river_PIC_01',riv_value(1:river, :, :));

% river_d13C_TIC
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = d13C_TIC(i,:);
    end
end
ncwrite(NC_FILE,'river_d13C_TIC',riv_value(1:river, :, :));

% river_d13C_DOC
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = d13C_DOC1(i,:);
    end
end
ncwrite(NC_FILE,'river_d13C_DOC_01',riv_value(1:river, :, :));
% river_d13C_DOC
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = d13C_DOC2(i,:);
    end
end
ncwrite(NC_FILE,'river_d13C_DOC_02',riv_value(1:river, :, :));

% river_d13C_POC
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = d13C_POC1(i,:);
    end
end
ncwrite(NC_FILE,'river_d13C_POC_01',riv_value(1:river, :, :));
% river_d13C_POC
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = d13C_POC2(i,:);
    end
end
ncwrite(NC_FILE,'river_d13C_POC_02',riv_value(1:river, :, :));

% river_d13C_Phy1
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = d13C_Phy1(i,:);
    end
end
ncwrite(NC_FILE,'river_d13C_Phyt_01',riv_value(1:river, :, :));

% river_d13C_Phy2
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = d13C_Phy2(i,:);
    end
end
ncwrite(NC_FILE,'river_d13C_Phyt_02',riv_value(1:river, :, :));
% river_d13C_Phy2
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = d13C_Phy3(i,:);
    end
end
ncwrite(NC_FILE,'river_d13C_Phyt_03',riv_value(1:river, :, :));

% river_d13C_Zoo
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = d13C_Zoo(i,:);
    end
end
ncwrite(NC_FILE,'river_d13C_Zoop_01',riv_value(1:river, :, :));

%% 
% 
varData = ncread(NC_FILE,'river_transport');
% disp(varData); 
% ncdisp(NC_FILE);



