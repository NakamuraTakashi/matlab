% === Copyright (c) 2015-2019 Takashi NAKAMURA  =====

filename='data/hourly.dat';  % SWAT hourly output file 

fileID = fopen(filename);
FormatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
data = textscan(fileID, FormatSpec, 'HeaderLines',6);
fclose(fileID);

NC_FILE = './output/shiraho_river_Nz8_10_3.nc';

TIME_REF = '2000-01-01 00:00:00';
LOCAL_TIME = 9; % hours: UTC+9 (JST) 

% Shiraho grid river mouth setting
xi_u = 63 ;
eta_v = 191 ;
s_rho = 8 ;
river = 2 ;    % river 1: Todoroki river, river 2: SGD
riv_X = [  9,   1 ];
riv_Y = [ 58,   1 ];

riv_D = [  0,   0 ];  % east<->west:0,  south<->north:1
riv_D2= [  1,   1 ];  % east->west or south-> north: 1,  west->east or north-> south:-1

%% 
start_time = datetime(TIME_REF);

data_time = years(data{1,1})+days(data{1,2})+hours(data{1,3});
data_days = days(data_time);
% river_time
sta_date = datenum(start_time);
riv_date = data_days - sta_date;

days_sinc_TIME_REF = ['days since ', datestr(start_time,'yyyy-mm-dd HH:MM:ss')];

%% 
% Todoroki river
%      time(i,:)= num(:,1);
i=1;

flow(i,:)= data{1,4}; % m3/s
SS(i,:)  = data{1,5}; % mg/L -> kg/m3
DON(i,:) = data{1,6}/14.007*1000; % mg/L -> umol/L
DOP(i,:) = data{1,7}/30.97*1000; % mg/L -> umol/L
NO3(i,:) = data{1,8}/14.007*1000; % mg/L -> umol/L
NH4(i,:) = data{1,9}/14.007*1000; % mg/L -> umol/L
NO2(i,:) = data{1,10}/14.007*1000; % mg/L -> umol/L
PO4(i,:) = data{1,11}/30.97*1000; % mg/L -> umol/L
Oxyg(i,:)= data{1,13}/32*1000; % mg/L -> umol/L

data_num = size(flow(1,:),2);

PON(i,:) = DON(i,:)*0.1;
DON(i,:) = DON(i,:)*0.9;
POP(i,:) = DOP(i,:)*0.1;
DOP(i,:) = DOP(i,:)*0.9;
POC(i,:) = PON(i,:)*106/16;
DOC(i,:) = DON(i,:)*106/16;

salt(i,1:data_num) = 3;
temp(i,1:data_num) = 27;
alk(i,1:data_num)  = 3600;
TIC(i,1:data_num)  = 3500;

% Seepage
i=2;
flow(i,:)= 0.042*10e-6; % m3/m2/s
SS(i,:)  = 0; % kg/m3
DON(i,:) = 0; % umol/L
DOP(i,:) = 0; % umol/L
NO3(i,:) = 10.01; % umol/L
NH4(i,:) = 4.37; % umol/L
NO2(i,:) = 0.46; % umol/L
PO4(i,:) = 0.032; % umol/L

salt(i,:) = 32.36;
temp(i,:) = 27;
alk(i,:)  = 2300; %!!!!!!!!!!!!!!!!!!!!!!!!
TIC(i,:)  = 2000; %!!!!!!!!!!!!!!!!!!!!!!!!
Oxyg(i,:) = 10; %!!!!!!!!!!!!!!!!!!!!!!!!
PON(i,:) = 0;
POP(i,:) = 0;
POC(i,:) = 0;
DOC(i,:) = 0;

% river and seepage
Phy1(1:river,1:data_num) = 0;
Phy2(1:river,1:data_num) = 0;
Zoop(1:river,1:data_num) = 0;
d13C_TIC(1:river,1:data_num) = -8.4;
d13C_DOC(1:river,1:data_num) = -25;
d13C_POC(1:river,1:data_num) = -25;
d13C_Phy1(1:river,1:data_num) = -25;
d13C_Phy2(1:river,1:data_num) = -25;
d13C_Zoo(1:river,1:data_num) = -25;

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
ncwriteatt(NC_FILE,'river_Xposition','long_name','river XI-position at RHO-points');
ncwriteatt(NC_FILE,'river_Xposition','valid_min',1);
ncwriteatt(NC_FILE,'river_Xposition','valid_max',xi_u);
% river_Eposition
nccreate(NC_FILE,'river_Eposition',...
          'Dimensions',{'river',river},...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Eposition','long_name','river ETA-position at RHO-points');
ncwriteatt(NC_FILE,'river_Eposition','valid_min',1);
ncwriteatt(NC_FILE,'river_Eposition','valid_max',eta_v);
% river_direction
nccreate(NC_FILE,'river_direction',...
          'Dimensions',{'river',river},...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_direction','long_name','river runoff direction');
% river_Vshape
nccreate(NC_FILE,'river_Vshape',...
          'Dimensions',{'river',river, 's_rho',s_rho },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Vshape','long_name','river runoff mass transport vertical profile');
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
nccreate(NC_FILE,'river_NO2',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_NO2','long_name','river runoff NO2');
ncwriteatt(NC_FILE,'river_NO2','units','umol L-1');
ncwriteatt(NC_FILE,'river_NO2','time','river_time');
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
% river_DOC
nccreate(NC_FILE,'river_DOC',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_DOC','long_name','river runoff DOC');
ncwriteatt(NC_FILE,'river_DOC','units','umol L-1');
ncwriteatt(NC_FILE,'river_DOC','time','river_time');
% river_DON
nccreate(NC_FILE,'river_DON',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_DON','long_name','river runoff DON');
ncwriteatt(NC_FILE,'river_DON','units','umol L-1');
ncwriteatt(NC_FILE,'river_DON','time','river_time');
% river_DOP
nccreate(NC_FILE,'river_DOP',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_DOP','long_name','river runoff DOP');
ncwriteatt(NC_FILE,'river_DOP','units','umol L-1');
ncwriteatt(NC_FILE,'river_DOP','time','river_time');
% river_POC
nccreate(NC_FILE,'river_POC',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_POC','long_name','river runoff POC');
ncwriteatt(NC_FILE,'river_POC','units','umol L-1');
ncwriteatt(NC_FILE,'river_POC','time','river_time');
% river_PON
nccreate(NC_FILE,'river_PON',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_PON','long_name','river runoff PON');
ncwriteatt(NC_FILE,'river_PON','units','umol L-1');
ncwriteatt(NC_FILE,'river_PON','time','river_time');
% river_POP
nccreate(NC_FILE,'river_POP',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_POP','long_name','river runoff POP');
ncwriteatt(NC_FILE,'river_POP','units','umol L-1');
ncwriteatt(NC_FILE,'river_POP','time','river_time');
% river_Phy1
nccreate(NC_FILE,'river_Phy1',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Phy1','long_name','river runoff phytoplankton1');
ncwriteatt(NC_FILE,'river_Phy1','units','umolC L-1');
ncwriteatt(NC_FILE,'river_Phy1','time','river_time');
% river_Phy2
nccreate(NC_FILE,'river_Phy2',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Phy2','long_name','river runoff phytoplankton2');
ncwriteatt(NC_FILE,'river_Phy2','units','umolC L-1');
ncwriteatt(NC_FILE,'river_Phy2','time','river_time');
% river_Zoop
nccreate(NC_FILE,'river_Zoop',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Zoop','long_name','river runoff zooplankton');
ncwriteatt(NC_FILE,'river_Zoop','units','umolC L-1');
ncwriteatt(NC_FILE,'river_Zoop','time','river_time');
% river_d13C_TIC
nccreate(NC_FILE,'river_d13C_TIC',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_TIC','long_name','river runoff d13C in DIC');
ncwriteatt(NC_FILE,'river_d13C_TIC','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_TIC','time','river_time');
% river_d13C_DOC
nccreate(NC_FILE,'river_d13C_DOC',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_DOC','long_name','river runoff d13C in DOC');
ncwriteatt(NC_FILE,'river_d13C_DOC','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_DOC','time','river_time');
% river_d13C_POC
nccreate(NC_FILE,'river_d13C_POC',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_POC','long_name','river runoff d13C in POC');
ncwriteatt(NC_FILE,'river_d13C_POC','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_POC','time','river_time');
% river_d13C_Phy1
nccreate(NC_FILE,'river_d13C_Phy1',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_Phy1','long_name','river runoff d13C in phtoplankton1');
ncwriteatt(NC_FILE,'river_d13C_Phy1','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_Phy1','time','river_time');
% river_d13C_Phy2
nccreate(NC_FILE,'river_d13C_Phy2',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_Phy2','long_name','river runoff d13C in phtoplankton2');
ncwriteatt(NC_FILE,'river_d13C_Phy2','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_Phy2','time','river_time');
% river_d13C_Zoo
nccreate(NC_FILE,'river_d13C_Zoo',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',data_num },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_Zoo','long_name','river runoff d13C in zooplankton');
ncwriteatt(NC_FILE,'river_d13C_Zoo','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_Zoo','time','river_time');
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
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = NO2(i,:);
    end
end
ncwrite(NC_FILE,'river_NO2',riv_value(1:river, :, :));



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
        riv_value( i, j, 1:data_num ) = DOC(i,:);
    end
end
ncwrite(NC_FILE,'river_DOC',riv_value(1:river, :, :));

% river_DON
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = DON(i,:);
    end
end
ncwrite(NC_FILE,'river_DON',riv_value(1:river, :, :));

% river_DOP
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = DOP(i,:);
    end
end
ncwrite(NC_FILE,'river_DOP',riv_value(1:river, :, :));

% river_POC
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = POC(i,:);
    end
end
ncwrite(NC_FILE,'river_POC',riv_value(1:river, :, :));

% river_PON
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = PON(i,:);
    end
end
ncwrite(NC_FILE,'river_PON',riv_value(1:river, :, :));

% river_POP
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = POP(i,:);
    end
end
ncwrite(NC_FILE,'river_POP',riv_value(1:river, :, :));

% river_Phy1
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = Phy1(i,:);
    end
end
ncwrite(NC_FILE,'river_Phy1',riv_value(1:river, :, :));

% river_Phy2
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = Phy2(i,:);
    end
end
ncwrite(NC_FILE,'river_Phy2',riv_value(1:river, :, :));

% river_Zoop
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = Zoop(i,:);
    end
end
ncwrite(NC_FILE,'river_Zoop',riv_value(1:river, :, :));

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
        riv_value( i, j, 1:data_num ) = d13C_DOC(i,:);
    end
end
ncwrite(NC_FILE,'river_d13C_DOC',riv_value(1:river, :, :));

% river_d13C_POC
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = d13C_POC(i,:);
    end
end
ncwrite(NC_FILE,'river_d13C_POC',riv_value(1:river, :, :));

% river_d13C_Phy1
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = d13C_Phy1(i,:);
    end
end
ncwrite(NC_FILE,'river_d13C_Phy1',riv_value(1:river, :, :));

% river_d13C_Phy2
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = d13C_Phy2(i,:);
    end
end
ncwrite(NC_FILE,'river_d13C_Phy2',riv_value(1:river, :, :));

% river_d13C_Zoo
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:data_num ) = d13C_Zoo(i,:);
    end
end
ncwrite(NC_FILE,'river_d13C_Zoo',riv_value(1:river, :, :));

%% 
% 
varData = ncread(NC_FILE,'river_transport');
% disp(varData); 
% ncdisp(NC_FILE);



