% Set global attributes.
% Input grid file name
Ginp='D:\ROMS\Data\Coral_Triangle\CT_0.08_grd_v2.nc';

Gout='Palau1_grd_v0.nc';
% Gout='Berau1_grd_v1.nc';

% For Berau1
% Imin = 313;
% Jmin = 145;
% Imax = 360;
% Jmax = 270;
% Gfactor = 5;

% For Palau1
Imin = 520;
Jmin = 290;
Imax = 545;
Jmax = 325;
Gfactor = 5;

F = coarse2fine2(Ginp,Gout,Gfactor,Imin,Imax,Jmin,Jmax);

% M=F.Mm+1;
% Mp=M+1;
% L=F.Lm+1;
% Lp=L+1;
% 
% F.lat_rho=F.y_rho;
% F.lon_rho=F.x_rho;
% F.lat_u=F.y_u;
% F.lon_u=F.x_u;
% F.lat_v=F.y_v;
% F.lon_v=F.x_v;
% F.lat_psi=F.y_psi;
% F.lon_psi=F.x_psi;
% 
% field_list = { 'lon_rho', 'lat_rho',                       ...
%                'lon_psi', 'lat_psi',                       ...
%                'lon_u',   'lat_u',                         ...
%                'lon_v',   'lat_v'};
%   
% for value = field_list,
%   field = char(value);
%   status = nc_write (Gout, field, F.(field));
%   if (status ~= 0), return, end
% end
