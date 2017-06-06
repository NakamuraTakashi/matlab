% Set global attributes.
% Input grid file name
Ginp='D:\ROMS\Yaeyama\Data\Yaeyama1_grd_ver2.nc';
%Ginp='D:\ROMS\Yaeyama\Data\Yaeyama2_grd_ver4.nc';

Gout='Yaeyama2_grd_ver3.nc';
%Gout='Yaeyama3_grd_ver2.nc';

UTM_zone = '51 R';          % UTM zone, e.g. '30 T', '32 T', '11 S', '28 R', '15 S', '51 R'

% For YAEYAMA2
Imin = 155;
Jmin = 60;
Imax = 215;
Jmax = 120;
Gfactor = 5;

% For YAEYAMA3
%Imin = 91;
%Jmin = 84;
%Imax = 211;
%Jmax = 174;
%Gfactor = 3;

F = coarse2fine(Ginp,Gout,Gfactor,Imin,Imax,Jmin,Jmax);

M=F.Mm+1;
Mp=M+1;
L=F.Lm+1;
Lp=L+1;

F.lat_rho=F.x_rho;
F.lon_rho=F.x_rho;
F.lat_u=F.x_u;
F.lon_u=F.x_u;
F.lat_v=F.x_v;
F.lon_v=F.x_v;

    for j = 1:Mp;
        for i = 1:Lp;
            [F.lat_rho(i,j), F.lon_rho(i,j)] = utm2deg(F.x_rho(i,j),F.y_rho(i,j),UTM_zone);
        end
    end

    for j = 1:Mp;
        for i = 1:L;
            [F.lat_u(i,j), F.lon_u(i,j)] = utm2deg(F.x_u(i,j),F.y_u(i,j),UTM_zone);
        end
    end
    
    for j = 1:M;
        for i = 1:Lp;
            [F.lat_v(i,j), F.lon_v(i,j)] = utm2deg(F.x_v(i,j),F.y_v(i,j),UTM_zone);
        end
    end
    
    for j = 1:M;
        for i = 1:L;
            [F.lat_psi(i,j), F.lon_psi(i,j)] = utm2deg(F.x_psi(i,j),F.y_psi(i,j),UTM_zone);
        end
    end

field_list = { 'lon_rho', 'lat_rho',                       ...
               'lon_psi', 'lat_psi',                       ...
               'lon_u',   'lat_u',                         ...
               'lon_v',   'lat_v'};
  
for value = field_list,
  field = char(value);
  status = nc_write (Gout, field, F.(field));
  if (status ~= 0), return, end
end
