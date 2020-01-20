%Fukido
grd='D:\cygwin64\home\Takashi\COAWST\Projects\Fukido_reef\Fukido3_grd_v0.nc';

UTM_zone = '51 R';          % UTM zone, e.g. '30 T', '32 T', '11 S', '28 R', '15 S', '51 R'

x_r = ncread(grd, 'x_rho');
y_r = ncread(grd, 'y_rho');
for j = 1:size(x_r,2)
    for i = 1:size(x_r,1)
        [lat_r(i,j), lon_r(i,j)] = utm2deg(x_r(i,j),y_r(i,j),UTM_zone);
    end
end
ncwrite(grd,'lon_rho',lon_r);
ncwrite(grd,'lat_rho',lat_r);

x_u = ncread(grd, 'x_u');
y_u = ncread(grd, 'y_u');
for j = 1:size(x_u,2)
    for i = 1:size(x_u,1)
        [lat_u(i,j), lon_u(i,j)] = utm2deg(x_u(i,j),y_u(i,j),UTM_zone);
    end
end
ncwrite(grd,'lon_u',lon_u);
ncwrite(grd,'lat_u',lat_u);

x_v = ncread(grd, 'x_v');
y_v = ncread(grd, 'y_v');
for j = 1:size(x_v,2)
    for i = 1:size(x_v,1)
        [lat_v(i,j), lon_v(i,j)] = utm2deg(x_v(i,j),y_v(i,j),UTM_zone);
    end
end
ncwrite(grd,'lon_v',lon_v);
ncwrite(grd,'lat_v',lat_v);

x_p = ncread(grd, 'x_psi');
y_p = ncread(grd, 'y_psi');
for j = 1:size(x_p,2)
    for i = 1:size(x_p,1)
        [lat_p(i,j), lon_p(i,j)] = utm2deg(x_p(i,j),y_p(i,j),UTM_zone);
    end
end
ncwrite(grd,'lon_psi',lon_p);
ncwrite(grd,'lat_psi',lat_p);
