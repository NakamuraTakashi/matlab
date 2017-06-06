etopo_file = 'C:\Users\Takashi\Desktop\ETOPO1_Bed_g_gmt4.grd\ETOPO1_Bed_g_gmt4.grd';
% ETOPO1: 1/60 degree grid resolution
Gname = 'output/coral_triangle_grd_v1.nc';

%% 
% Set lat, lon at specific station. 
s_lat = -17;
e_lat = 30;
s_lon = 99;
e_lon = 139;
% Set ROMS grid resolution
RESOLUTION = 24; % 1/24 degree

%    Lp          Number of RHO-points in the XI-direction
%    Mp          Number of RHO-points in the ETA-direction

% Lp = int64( (e_lon - s_lon) * RESOLUTION +1 );
% Mp = int64( (e_lat - s_lat) * RESOLUTION +1 );
Lp = (e_lon - s_lon) * RESOLUTION +1;
Mp = (e_lat - s_lat) * RESOLUTION +1;

lon_rho = zeros(Lp,Mp);
lat_rho = zeros(Lp,Mp);
for i=1:Mp
    lon_rho(:,i) = s_lon:(1/RESOLUTION):e_lon;
end
for i=1:Lp
    lat_rho(i,:) = s_lat:(1/RESOLUTION):e_lat;
end


%% Read ETOPO1 grid coordinate
lon = ncread(etopo_file, 'x');
lat = ncread(etopo_file, 'y');
%% 

% Serching index number of nearest grid 
[M,id_s_lon]  = min(abs(lon - s_lon));
[M,id_e_lon]  = min(abs(lon - e_lon));
[M,id_s_lat]  = min(abs(lat - s_lat));
[M,id_e_lat]  = min(abs(lat - e_lat));

% Calculate count for reading data
c_lon = id_e_lon - id_s_lon +1;
c_lat = id_e_lat - id_s_lat +1;

% Read topography data
h_etopo = ncread(etopo_file, 'z',[id_s_lon-1 id_s_lat-1], [c_lon+2 c_lat+2]);
lat_etopo = lat(id_s_lat-1:id_e_lat+1);
lon_etopo = lon(id_s_lon-1:id_e_lon+1);

%% plot figure
tmp = transpose(h_etopo);
tmp(tmp>-1) = nan;

fig1 = figure;
fig1.Colormap=jet(128);
h1=pcolor(lon_etopo,lat_etopo,tmp);
h1.LineStyle='none';
ax1 = fig1.CurrentAxes;
colorbar(ax1);
ax1.CLim=[-6000,0];
ax1.Title.String='Depth (m)';
%% 
h = interp2(lon_etopo, lat_etopo, transpose(h_etopo), lon_rho, lat_rho, 'linear')*-1;

%% plot figure
% tmp = transpose(h_etopo);
h2 = h;
h2(h2<1) = nan;

fig1 = figure;
% fig1.Colormap=jet(128);
fig1.Colormap=flipud(magma);
h1=pcolor(lon_rho,lat_rho,h2);
h1.LineStyle='none';
ax1 = fig1.CurrentAxes;
colorbar(ax1);
ax1.CLim=[0,6000];
ax1.Title.String='Depth (m)';

%% Write netCDF grid file

c_grid(Lp, Mp, Gname, true, true);
% nc_write(Gname,'hraw',h);
nc_write(Gname,'h',h);
nc_write(Gname,'lon_rho',lon_rho);
nc_write(Gname,'lat_rho',lat_rho);

