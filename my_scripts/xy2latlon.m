%Fukido
% grd='D:\cygwin64\home\Takashi\COAWST\Projects\Fukido_reef\Fukido3_grd_v0.1.nc';
grd='D:\cygwin64\home\Takashi\COAWST\Data\Yaeyama\Yaeyama2_grd_v10.nc';

UTM_zone = '51 R';          % UTM zone, e.g. '30 T', '32 T', '11 S', '28 R', '15 S', '51 R'

x_r = ncread(grd, 'x_rho');
y_r = ncread(grd, 'y_rho');
M=size(x_r,1);
L=size(x_r,2);

%% Calc. x_r, y_r to x_u,x_v.x_p, y_u, y_v, and y_p
for j = 1:L
    for i = 1:M-1
        x_u(i,j) = (x_r(i,j)+x_r(i+1,j))/2;
        y_u(i,j) = (y_r(i,j)+y_r(i+1,j))/2;
    end
end
for j = 1:L-1
    for i = 1:M
        x_v(i,j) = (x_r(i,j)+x_r(i,j+1))/2;
        y_v(i,j) = (y_r(i,j)+y_r(i,j+1))/2;
    end
end
for j = 1:L-1
    for i = 1:M-1
        x_p(i,j) = (x_r(i,j)+x_r(i+1,j+1))/2;
        y_p(i,j) = (y_r(i,j)+y_r(i+1,j+1))/2;
    end
end
ncwrite(grd,'x_u',x_u);
ncwrite(grd,'y_u',y_u);
ncwrite(grd,'x_v',x_v);
ncwrite(grd,'y_v',y_v);
ncwrite(grd,'x_psi',x_p);
ncwrite(grd,'y_psi',y_p);

%% x,y to lat, lon
for j = 1:L
    for i = 1:M
        [lat_r(i,j), lon_r(i,j)] = utm2deg(x_r(i,j),y_r(i,j),UTM_zone);
    end
end
ncwrite(grd,'lon_rho',lon_r);
ncwrite(grd,'lat_rho',lat_r);

x_u = ncread(grd, 'x_u');
y_u = ncread(grd, 'y_u');
for j = 1:L
    for i = 1:M-1
        [lat_u(i,j), lon_u(i,j)] = utm2deg(x_u(i,j),y_u(i,j),UTM_zone);
    end
end
ncwrite(grd,'lon_u',lon_u);
ncwrite(grd,'lat_u',lat_u);

x_v = ncread(grd, 'x_v');
y_v = ncread(grd, 'y_v');
for j = 1:L-1
    for i = 1:M
        [lat_v(i,j), lon_v(i,j)] = utm2deg(x_v(i,j),y_v(i,j),UTM_zone);
    end
end
ncwrite(grd,'lon_v',lon_v);
ncwrite(grd,'lat_v',lat_v);

x_p = ncread(grd, 'x_psi');
y_p = ncread(grd, 'y_psi');
for j = 1:L-1
    for i = 1:M-1
        [lat_p(i,j), lon_p(i,j)] = utm2deg(x_p(i,j),y_p(i,j),UTM_zone);
    end
end
ncwrite(grd,'lon_psi',lon_p);
ncwrite(grd,'lat_psi',lat_p);

%% Compute Coriolis parameter.

deg2rad = pi / 180.0;
omega   = 2.0 * pi * 366.25 / (24.0 * 3600.0 * 365.25);
f = 2.0 * omega * sin(deg2rad * lat_r);
ncwrite(grd,'f',f);

%% Land masking
h = ncread(grd, 'h');
% rmask = zeros(size(h));
rmask = (h>-90);
[umask, vmask, pmask] = uvp_masks(rmask);
ncwrite(grd,'mask_rho',rmask);
ncwrite(grd,'mask_u',  umask);
ncwrite(grd,'mask_v',  vmask);
ncwrite(grd,'mask_psi',pmask);
