% 
%  Driver script to create ROMS grid file from ETOPO-1 database
%   === Copyright (c) 2017 Takashi NAKAMURA  =====
%

gebco_file = 'D:/Documents/GIS_data/GEBCO_2014_2D/GEBCO_2014_2D.nc';
% ETOPO1: 1/60 degree grid resolution
Gname = 'output/CT_0.04_grd_v3.nc'; % 1/24 degree resolution
% Gname = 'output/CT_0.08_grd_v4.nc'; % 1/12 degree resolution

%% 
% Set lat, lon at specific station. 
s_lat = -18;
e_lat = 30;
s_lon = 91;
e_lon = 156;
% Set ROMS grid resolution
RESOLUTION = 24; % 1/24 degree resolution
% RESOLUTION = 12; % 1/12 degree resolution

%% Read ETOPO1 grid coordinate
lon = ncread(gebco_file, 'lon');
lat = ncread(gebco_file, 'lat');
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
h_etopo = ncread(gebco_file, 'elevation',[id_s_lon-1 id_s_lat-1], [c_lon+2 c_lat+2]);
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

%% Compute grid parameters

G.spherical = 1;

rlat = s_lat:(1/RESOLUTION):e_lat;
rlon = s_lon:(1/RESOLUTION):e_lon;

%    Lp          Number of RHO-points in the XI-direction
%    Mp          Number of RHO-points in the ETA-direction
Lp = size(rlon,2);
Mp = size(rlat,2);

tmp  = movmean(rlon,2);
ulon = tmp(2:Lp); 
tmp  = movmean(rlat,2); 
vlat = tmp(2:Mp); 

% ROMS grid lat lon
G.lon_rho = zeros(Lp,Mp);
G.lat_rho = zeros(Lp,Mp);
G.lon_u   = zeros(Lp-1,Mp);
G.lat_u   = zeros(Lp-1,Mp);
G.lon_v   = zeros(Lp,Mp-1);
G.lat_v   = zeros(Lp,Mp-1);
G.lon_psi = zeros(Lp-1,Mp-1);
G.lat_psi = zeros(Lp-1,Mp-1);

for i=1:Lp
    G.lat_rho(i,:) = rlat;
    G.lat_v  (i,:) = vlat;
end
for i=1:Lp-1
    G.lat_u  (i,:) = rlat;
    G.lat_psi(i,:) = vlat;
end
for i=1:Mp
    G.lon_rho(:,i) = rlon;
    G.lon_u  (:,i) = ulon;
end
for i=1:Mp-1
    G.lon_v  (:,i) = rlon;
    G.lon_psi(:,i) = ulon;
end

% Compute ROMS Grid horizontal metrics
G.uniform = 0;
[G.pm, G.pn, G.dndx, G.dmde] = grid_metrics(G, true );

G.angle = zeros(Lp,Mp);

% Compute Coriolis parameter.
deg2rad = pi / 180.0;
omega   = 2.0 * pi * 366.25 / (24.0 * 3600.0 * 365.25);
G.f = 2.0 * omega * sin(deg2rad * G.lat_rho);

% Interporate depth for ROMS grid
G.h = interp2(lon_etopo, lat_etopo, transpose(h_etopo), G.lon_rho, G.lat_rho, 'linear')*-1;
%% 
% Compute Land mask
rmask = zeros(size(G.h));
rmask(G.h>0) = 1;
% plot figure
fig1 = figure;
fig1.Colormap=jet(128);
h1=pcolor(G.lon_rho,G.lat_rho,rmask);
h1.LineStyle='none';
ax1 = fig1.CurrentAxes;
colorbar(ax1);
ax1.CLim=[-1,1];
ax1.Title.String='mask rho';

% Remove isolated water area
rmask2 = zeros(size(G.h));
rmask2(1:2,1:2) = 1;
for k=1:1000
    count = 0;
    for j = 1:Mp
        for i = 1:Lp
            if rmask(i,j)==1 && rmask2(i,j)==0
                jp=j+1; jm=j-1; ip=i+1; im=i-1;
                if jp==Mp+1
                    jp=jm;
                end
                if jm==0
                    jm=jp;
                end
                if ip==Lp+1
                    ip=im;
                end
                if im==0
                    im=ip;
                end               
                if rmask2(im,j)==1 || rmask2(ip,j)==1 || rmask2(i,jm)==1 || rmask2(i,jp)==1
                    rmask2(i,j) = 1;
                    count = count+1;
                end
            end
        end
    end
    if count == 0
        break;
    end
end

%  Grid specific modification !!!!!!!!!!!!!!!!!!!!!!!!!!!!
% rmask2(570:Lp,1)=0; % for 1/24 degree resolution
% rmask2(1,590:600)=0; % for 1/24 degree resolution
% rmask2(1:4,427:429)=0; % for 1/24 degree resolution

% rmask2(290:Lp,1)=0; % for 1/12 degree resolution
% rmask2(185,342) = 0; % for 1/12 degree resolution
% rmask2(164,311) = 0; % for 1/12 degree resolution
% rmask2(193,338) = 0; % for 1/12 degree resolution
% rmask2(189,337) = 0; % for 1/12 degree resolution
% rmask2(1,213) = 0; % for 1/12 degree resolution
% rmask2(1,214) = 0; % for 1/12 degree resolution
% rmask2(1,298) = 0; % for 1/12 degree resolution
% rmask2(480,105) = 0; % for 1/12 degree resolution
% rmask2(480,106) = 0; % for 1/12 degree resolution
% rmask2(355,105) = 0; % for 1/12 degree resolution
% rmask2(334,159) = 0; % for 1/12 degree resolution
% rmask2(327,110) = 0; % for 1/12 degree resolution
% % rmask2(188,393) = 0; % for 1/12 degree resolution
% % rmask2(180,391) = 0; % for 1/12 degree resolution

G.mask_rho = rmask2;
[G.mask_u, G.mask_v, G.mask_psi] = uvp_masks(G.mask_rho);

% plot figure
fig1 = figure;
fig1.Colormap=jet(128);
h1=pcolor(G.lon_rho,G.lat_rho,rmask2);
h1.LineStyle='none';
ax1 = fig1.CurrentAxes;
colorbar(ax1);
ax1.CLim=[-1,1];
ax1.Title.String='mask rho';

%% Bathymetry smoothing
G.h(G.h<5) = 5;

% h2 = smooth_bath(G.h, G.mask_rho, order, rlim, npass );
h2 = smooth_bath(G.h, G.mask_rho, 8, 0.35, 50 );
G.h = h2;

%% Write netCDF grid file
c_grid(Lp, Mp, Gname, true, true);

nc_write (Gname, 'spherical',G.spherical);
nc_write (Gname, 'angle',G.angle);
nc_write (Gname, 'pm', G.pm);
nc_write (Gname, 'pn', G.pn);
nc_write (Gname, 'dmde', G.dmde);
nc_write (Gname, 'dndx', G.dndx);
nc_write (Gname, 'f', G.f);
nc_write (Gname, 'h', G.h);
nc_write (Gname, 'lon_rho',  G.lon_rho);
nc_write (Gname, 'lat_rho',  G.lat_rho);
nc_write (Gname, 'lon_u',    G.lon_u);
nc_write (Gname, 'lat_u',    G.lat_u);
nc_write (Gname, 'lon_v',    G.lon_v);
nc_write (Gname, 'lat_v',    G.lat_v);
nc_write (Gname, 'lon_psi',  G.lon_psi);
nc_write (Gname, 'lat_psi',  G.lat_psi);
nc_write (Gname, 'mask_rho', G.mask_rho);
nc_write (Gname, 'mask_psi', G.mask_psi);
nc_write (Gname, 'mask_u',   G.mask_u);
nc_write (Gname, 'mask_v',   G.mask_v);

%% plot figure
h2 = G.h;
h2(G.mask_rho==0) = nan;

fig1 = figure;
% fig1.Colormap=jet(128);
fig1.Colormap=flipud(jet(128));
h1=pcolor(G.lon_rho,G.lat_rho,h2);
h1.LineStyle='none';
ax1 = fig1.CurrentAxes;
colorbar(ax1);
ax1.CLim=[0,6000];
ax1.Title.String='Depth (m)';

