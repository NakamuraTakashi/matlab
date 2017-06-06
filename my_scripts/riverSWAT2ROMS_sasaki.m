% === ver 2017/02/02   Copyright (c) 2015-2017 Takashi NAKAMURA  =====

% xlfile='C:\cygwin64\home\Takashi\ROMS\matlab\data\sasaki\present.xlsx';
% xlfile='C:\cygwin64\home\Takashi\ROMS\matlab\data\sasaki\pop_up_conn_nomal.xlsx';
% xlfile='C:\cygwin64\home\Takashi\ROMS\matlab\data\sasaki\pop_up_conn_100.xlsx';
xlfile='C:\cygwin64\home\Takashi\ROMS\matlab\data\sasaki\treated_pop_up_conn_100.xlsx';
SHEET_NAME = {'1';'2';'3'; '4'; '5'; '6'; '7'; '8'; '9'; '10'; '11'; 'arakawa'};
           
%% 

date_start = '2000/01/01';
LOCAL_TIME = 9; % hours: UTC+9 (JST) 

riv_D = [  1,  1,  0,  1,  1,  1,  1,  1,  1,  1,  0,  0 ];  % east<->west:0,  south<->north:1
riv_D2= [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  1, -1 ];  % west->east or south-> north: 1,  east->west or north-> south:-1

% % Yaeyama1 grid
% NC_FILE = 'D:/ROMS/Yaeyama/Data/Yaeyama1_river_Nz30_13_14.nc';
% xi_u = 309 ;
% eta_v = 279 ;
% s_rho = 30 ;
% river = 5 ;
% riv_X = [ 74, 191, 191, 196, 199 ];
% riv_Y = [ 82,  91,  87,  89,  91 ];

% Yaeyama2 grid
% NC_FILE = 'D:/ROMS/Yaeyama/Data/Yaeyama2_river_Nz15_arakawa_present_14.nc';
% NC_FILE = 'D:/ROMS/Yaeyama/Data/Yaeyama2_river_Nz15_arakawa_pop_up_conn_nomal_14.nc';
% NC_FILE = 'D:/ROMS/Yaeyama/Data/Yaeyama2_river_Nz15_arakawa_pop_up_conn_100_14.nc';
NC_FILE = 'D:/ROMS/Yaeyama/Data/Yaeyama2_river_Nz15_arakawa_treated_pop_up_conn_100_14.nc';
xi_u = 301 ;
eta_v = 301 ;
s_rho = 15 ;
river = 12 ;
riv_X_rho = [177, 181, 183, 185, 186, 188, 190, 192, 196, 199, 201, 182 ]; % Ncview の読み取り値(i)
riv_Y_rho = [144, 143, 139, 138, 137, 136, 135, 135, 135, 137, 139, 142 ]; % Ncview の読み取り値(j)


%% 

% % Yaeyama3 grid
% NC_FILE = 'D:/ROMS/Yaeyama/Data/Yaeyama3_river_Nz15_13_14.nc';
% xi_u = 361 ;
% eta_v = 271 ;
% s_rho = 15 ;
% river = 4 ;
% riv_X = [  4, 275, 276, 347 ];
% riv_Y = [105, 233, 179, 186 ];

%% 

riv_X =riv_X_rho;
riv_Y =riv_Y_rho;
riv_X(riv_D==0 & riv_D2==-1) = riv_X_rho(riv_D==0 & riv_D2==-1)+1;
riv_Y(riv_D==1 & riv_D2==-1) = riv_Y_rho(riv_D==1 & riv_D2==-1)+1;
%% 

for i=1:river
     num = xlsread(xlfile,SHEET_NAME{i});
     flow(i,:)= num(:,2)*0.001; % L/s -> m3/s
     PO4(i,:) = num(:,3)/94.97*1000; % mg/L -> umol/L
     NO3(i,:) = num(:,4)/62.00*1000; % mg/L -> umol/L
     NH4(i,:) = num(:,5)/18.04*1000; % mg/L -> umol/L
     NO2(i,:) = num(:,6)/46.01*1000; % mg/L -> umol/L
end

river_time = size(flow(1,:),2) ;

% river_time
sta_date = datenum(date_start, 'yyyy/mm/dd');
riv_date = 1:river_time;
riv_date = (riv_date-1)*1/24 + datenum('2014/01/01', 'yyyy/mm/dd') - sta_date - LOCAL_TIME/24;

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
          'Dimensions',{'river_time',river_time},...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_time','long_name','river runoff time');
ncwriteatt(NC_FILE,'river_time','units','days since 2000-01-01 00:00:00');  %%% 変更必要!!!!!!!!!!!!!!!!!!!!!!!!!!!
% river_transport
nccreate(NC_FILE,'river_transport',...
          'Dimensions',{'river',river, 'river_time',river_time},...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_transport','long_name','river runoff vertically integrated mass transport');
ncwriteatt(NC_FILE,'river_transport','units','meter3 second-1');
ncwriteatt(NC_FILE,'river_transport','time','river_time');
% river_temp
nccreate(NC_FILE,'river_temp',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_temp','long_name','river runoff potential temperature');
ncwriteatt(NC_FILE,'river_temp','units','Celsius');
ncwriteatt(NC_FILE,'river_temp','time','river_time');
% river_salt
nccreate(NC_FILE,'river_salt',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_salt','long_name','river runoff salinity');
ncwriteatt(NC_FILE,'river_salt','time','river_time');
% river_mud_01
nccreate(NC_FILE,'river_mud_01',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_mud_01','long_name','iver runoff suspended sediment concentration');
ncwriteatt(NC_FILE,'river_mud_01','units','kilogram meter-3');
ncwriteatt(NC_FILE,'river_mud_01','time','river_time');
% river_TIC
nccreate(NC_FILE,'river_TIC',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_TIC','long_name','iver runoff TIC');
ncwriteatt(NC_FILE,'river_TIC','units','umol kg-1');
ncwriteatt(NC_FILE,'river_TIC','time','river_time');
% river_alkalinity
nccreate(NC_FILE,'river_alkalinity',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_alkalinity','long_name','river runoff alkalinity');
ncwriteatt(NC_FILE,'river_alkalinity','units','umol kg-1');
ncwriteatt(NC_FILE,'river_alkalinity','time','river_time');
% river_Oxyg
nccreate(NC_FILE,'river_Oxyg',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Oxyg','long_name','river runoff oxygen');
ncwriteatt(NC_FILE,'river_Oxyg','units','umol L-1');
ncwriteatt(NC_FILE,'river_Oxyg','time','river_time');
% river_NO3
nccreate(NC_FILE,'river_NO3',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_NO3','long_name','river runoff NO3');
ncwriteatt(NC_FILE,'river_NO3','units','umol L-1');
ncwriteatt(NC_FILE,'river_NO3','time','river_time');
% river_NO2
nccreate(NC_FILE,'river_NO2',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_NO2','long_name','river runoff NO2');
ncwriteatt(NC_FILE,'river_NO2','units','umol L-1');
ncwriteatt(NC_FILE,'river_NO2','time','river_time');
% river_NH4
nccreate(NC_FILE,'river_NH4',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_NH4','long_name','river runoff NH4');
ncwriteatt(NC_FILE,'river_NH4','units','umol L-1');
ncwriteatt(NC_FILE,'river_NH4','time','river_time');
% river_PO4
nccreate(NC_FILE,'river_PO4',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_PO4','long_name','river runoff PO4');
ncwriteatt(NC_FILE,'river_PO4','units','umol L-1');
ncwriteatt(NC_FILE,'river_PO4','time','river_time');
% river_DOC
nccreate(NC_FILE,'river_DOC',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_DOC','long_name','river runoff DOC');
ncwriteatt(NC_FILE,'river_DOC','units','umol L-1');
ncwriteatt(NC_FILE,'river_DOC','time','river_time');
% river_DON
nccreate(NC_FILE,'river_DON',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_DON','long_name','river runoff DON');
ncwriteatt(NC_FILE,'river_DON','units','umol L-1');
ncwriteatt(NC_FILE,'river_DON','time','river_time');
% river_DOP
nccreate(NC_FILE,'river_DOP',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_DOP','long_name','river runoff DOP');
ncwriteatt(NC_FILE,'river_DOP','units','umol L-1');
ncwriteatt(NC_FILE,'river_DOP','time','river_time');
% river_POC
nccreate(NC_FILE,'river_POC',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_POC','long_name','river runoff POC');
ncwriteatt(NC_FILE,'river_POC','units','umol L-1');
ncwriteatt(NC_FILE,'river_POC','time','river_time');
% river_PON
nccreate(NC_FILE,'river_PON',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_PON','long_name','river runoff PON');
ncwriteatt(NC_FILE,'river_PON','units','umol L-1');
ncwriteatt(NC_FILE,'river_PON','time','river_time');
% river_POP
nccreate(NC_FILE,'river_POP',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_POP','long_name','river runoff POP');
ncwriteatt(NC_FILE,'river_POP','units','umol L-1');
ncwriteatt(NC_FILE,'river_POP','time','river_time');
% river_Phy1
nccreate(NC_FILE,'river_Phy1',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Phy1','long_name','river runoff phytoplankton1');
ncwriteatt(NC_FILE,'river_Phy1','units','umolC L-1');
ncwriteatt(NC_FILE,'river_Phy1','time','river_time');
% river_Phy2
nccreate(NC_FILE,'river_Phy2',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Phy2','long_name','river runoff phytoplankton2');
ncwriteatt(NC_FILE,'river_Phy2','units','umolC L-1');
ncwriteatt(NC_FILE,'river_Phy2','time','river_time');
% river_Zoop
nccreate(NC_FILE,'river_Zoop',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_Zoop','long_name','river runoff zooplankton');
ncwriteatt(NC_FILE,'river_Zoop','units','umolC L-1');
ncwriteatt(NC_FILE,'river_Zoop','time','river_time');
% river_d13C_TIC
nccreate(NC_FILE,'river_d13C_TIC',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_TIC','long_name','river runoff d13C in DIC');
ncwriteatt(NC_FILE,'river_d13C_TIC','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_TIC','time','river_time');
% river_d13C_DOC
nccreate(NC_FILE,'river_d13C_DOC',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_DOC','long_name','river runoff d13C in DOC');
ncwriteatt(NC_FILE,'river_d13C_DOC','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_DOC','time','river_time');
% river_d13C_POC
nccreate(NC_FILE,'river_d13C_POC',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_POC','long_name','river runoff d13C in POC');
ncwriteatt(NC_FILE,'river_d13C_POC','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_POC','time','river_time');
% river_d13C_Phy1
nccreate(NC_FILE,'river_d13C_Phy1',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_Phy1','long_name','river runoff d13C in phtoplankton1');
ncwriteatt(NC_FILE,'river_d13C_Phy1','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_Phy1','time','river_time');
% river_d13C_Phy2
nccreate(NC_FILE,'river_d13C_Phy2',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_Phy2','long_name','river runoff d13C in phtoplankton2');
ncwriteatt(NC_FILE,'river_d13C_Phy2','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_Phy2','time','river_time');
% river_d13C_Zoo
nccreate(NC_FILE,'river_d13C_Zoo',...
          'Dimensions',{'river',river, 's_rho',s_rho, 'river_time',river_time },...
          'Datatype','double')
ncwriteatt(NC_FILE,'river_d13C_Zoo','long_name','river runoff d13C in zooplankton');
ncwriteatt(NC_FILE,'river_d13C_Zoo','units','permil VPDB');
ncwriteatt(NC_FILE,'river_d13C_Zoo','time','river_time');
% global attributes
ncwriteatt(NC_FILE,'/','type','ROMS FORCING file');
ncwriteatt(NC_FILE,'/','title','YAEYAMA River Forcing');
ncwriteatt(NC_FILE,'/','grd_file','Yaeyama2_grd_v9.3.nc');
% ncwriteatt(NC_FILE,'/','rivers','(1)Nakama river, (2) Nagura river, (3) Arakawa river, (4) Miyara river, (5) Todoroki river');
ncwriteatt(NC_FILE,'/','rivers','(1) 1, (2) 2, (3) 3, (4) 4, (5) 5, (6) 6, (7) 7, (8) 8, (9) 9, (10) 10, (11) 11, (12) Arakawa river');

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
        riv_value( i, j, 1:river_time ) = PO4(i,:);
    end
end
ncwrite(NC_FILE,'river_PO4',riv_value(1:river, :, :));

% river_NO3
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:river_time ) = NO3(i,:);
    end
end
ncwrite(NC_FILE,'river_NO3',riv_value(1:river, :, :));

% river_NH4
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:river_time ) = NH4(i,:);
    end
end
ncwrite(NC_FILE,'river_NH4',riv_value(1:river, :, :));

% river_NO2
for i=1:river
    for j=1:s_rho
        riv_value( i, j, 1:river_time ) = NO2(i,:);
    end
end
ncwrite(NC_FILE,'river_NO2',riv_value(1:river, :, :));



% river_temp
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 25.0;
end
ncwrite(NC_FILE,'river_temp',riv_value(1:river, :, :));

% river_salt
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 3;
end
ncwrite(NC_FILE,'river_salt',riv_value(1:river, :, :));

% river_mud_01
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 0;
end
ncwrite(NC_FILE,'river_mud_01',riv_value(1:river, :, :));

% river_TIC
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 1600;
end
ncwrite(NC_FILE,'river_TIC',riv_value(1:river, :, :));

% river_alkalinity
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 1960;
end
ncwrite(NC_FILE,'river_alkalinity',riv_value(1:river, :, :));

% river_Oxyg
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 200;
end
ncwrite(NC_FILE,'river_Oxyg',riv_value(1:river, :, :));

% river_DOC
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 363;
end
ncwrite(NC_FILE,'river_DOC',riv_value(1:river, :, :));

% river_DON
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 21;
end
ncwrite(NC_FILE,'river_DON',riv_value(1:river, :, :));

% river_DOP
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 1.9;
end
ncwrite(NC_FILE,'river_DOP',riv_value(1:river, :, :));

% river_POC
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 0;
end
ncwrite(NC_FILE,'river_POC',riv_value(1:river, :, :));

% river_PON
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 0;
end
ncwrite(NC_FILE,'river_PON',riv_value(1:river, :, :));

% river_POP
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 0;
end
ncwrite(NC_FILE,'river_POP',riv_value(1:river, :, :));

% river_Phy1
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 0;
end
ncwrite(NC_FILE,'river_Phy1',riv_value(1:river, :, :));

% river_Phy2
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 0;
end
ncwrite(NC_FILE,'river_Phy2',riv_value(1:river, :, :));

% river_Zoop
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = 0;
end
ncwrite(NC_FILE,'river_Zoop',riv_value(1:river, :, :));

% river_d13C_TIC
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = -8.4;
end
ncwrite(NC_FILE,'river_d13C_TIC',riv_value(1:river, :, :));

% river_d13C_DOC
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = -25;
end
ncwrite(NC_FILE,'river_d13C_DOC',riv_value(1:river, :, :));

% river_d13C_POC
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = -25;
end
ncwrite(NC_FILE,'river_d13C_POC',riv_value(1:river, :, :));

% river_d13C_Phy1
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = -25;
end
ncwrite(NC_FILE,'river_d13C_Phy1',riv_value(1:river, :, :));

% river_d13C_Phy2
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = -25;
end
ncwrite(NC_FILE,'river_d13C_Phy2',riv_value(1:river, :, :));

% river_d13C_Zoo
for i=1:river
    riv_value( i, 1:s_rho, 1:river_time ) = -25;
end
ncwrite(NC_FILE,'river_d13C_Zoo',riv_value(1:river, :, :));

%% 
% 
varData = ncread(NC_FILE,'river_transport');
disp(varData); 
% ncdisp(NC_FILE);



