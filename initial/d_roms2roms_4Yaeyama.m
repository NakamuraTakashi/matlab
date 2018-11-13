%
%  D_ROMS2ROMS:  Driver script to create a ROMS initial conditions
%
%  This a user modifiable script that can be used to prepare ROMS
%  initial conditions NetCDF file from another ROMS application. It
%  sets-up all the necessary parameters and variables. USERS can use
%  this as a prototype for their application.
%

% svn $Id$
%=========================================================================%
%  Copyright (c) 2002-2015 The ROMS/TOMS Group                            %
%    Licensed under a MIT/X style license                                 %
%    See License_ROMS.txt                           Hernan G. Arango      %
%=========================================================================%

%==========================================================================
% This script creates initial conditions from ROMS NWA dataset.
%==========================================================================

% Set file names.

% NWAdata = 'D:\ROMS\Yaeyama\Y1_pNAO_13_2\ocean_his_Yaeyama1_NAO_130427.nc';
% NWAgrid = 'D:\ROMS\Yaeyama\Data\Yaeyama1_grd_v8.nc';
%NWAdata = 'D:\ROMS\Yaeyama\output\ocean_his_Yaeyama2_1g.nc';
%NWAgrid = 'D:\ROMS\Yaeyama\Data\Yaeyama2_grd_v8.nc';
% NWAdata = 'O:\ROMS\Yaeyama\Y1_13v7\Yaeyama1_his_130410.nc';
NWAdata = 'D:\ROMS\output\Yaeyama\test\Yaeyama2_his_14_Pup_Ckeep.nc';
NWAgrid = 'D:\ROMS\Data\Yaeyama\Yaeyama2_grd_v9.3.nc';

GRDname = 'D:\ROMS\Data\Yaeyama\Yaeyama3_grd_v10_1227.nc';
INIname = 'D:\ROMS\Data\Yaeyama\Yaeyama3_ini_Nz15_ROMS_140801.nc';

CREATE = true;                   % logical switch to create NetCDF
report = false;                  % report vertical grid information

IniRec = 1;                    % NWA time record for initialization

%--------------------------------------------------------------------------
%  Set application parameters in structure array, S.
%--------------------------------------------------------------------------

[Lr,Mr] = size(nc_read(GRDname,'h'));

Lu = Lr-1;
Lv = Lr;
Mu = Mr;
Mv = Mr-1;

S.ncname      = INIname;    % output NetCDF file

S.spherical   = 1;          % spherical grid

S.Lm          = Lr-2;       % number of interior RHO-points, X-direction
S.Mm          = Mr-2;       % number of interior RHO-points, Y-direction
S.N           = 15;         % number of vertical levels at RHO-points
S.NT          = 2;          % total number of tracers

S.Vtransform  = 2;          % vertical transfomation equation
S.Vstretching = 4;          % vertical stretching function

S.theta_s     = 7.0;        % S-coordinate surface control parameter
S.theta_b     = 0.1;        % S-coordinate bottom control parameter
S.Tcline      = 200.0;      % S-coordinate surface/bottom stretching width
S.hc          = S.Tcline;   % S-coordinate stretching width

%--------------------------------------------------------------------------
% Set variables to process.
%--------------------------------------------------------------------------

VarGrd  = {'spherical',                                               ...
           'Vtransform', 'Vstretching',                               ...
           'theta_s', 'theta_b', 'Tcline', 'hc',                      ...
           's_rho', 'Cs_r', 's_w', 'Cs_w', 'h'};

if (S.spherical),
  VarGrd = [VarGrd, 'lon_rho', 'lat_rho',                             ...
                    'lon_u', 'lat_u', 'lon_v', 'lat_v'];
else
  VarGrd = [VarGrd, 'x_rho', 'y_rho',                                 ...
                    'x_u', 'y_u', 'x_v', 'y_v'];
end

VarIni = {'zeta', 'ubar', 'vbar', 'u', 'v', 'temp', 'salt'};

%  Set intepolation parameters.

% method = 'linear';             % linear interpolation
method = 'natural';             % linear interpolation
offset = 10;                   % number of extra points for sampling
RemoveNaN = true;              % remove NaN with nearest-neighbor
Rvector = true;                % interpolate vectors to RHO-points

%--------------------------------------------------------------------------
%  Get parent and target grids structures. The depths are for an
%  unperturbed state (zeta = 0).
%--------------------------------------------------------------------------

%  Get Parent grid structure, P.

P = get_roms_grid(NWAgrid, NWAdata);

%  Set surface-depths to zero to bound surface interpolation. This is
%  specific for this application.

N = P.N;

P.z_r(:,:,N) = 0;
P.z_u(:,:,N) = 0;
P.z_v(:,:,N) = 0;

%  Get Target grid structure, T.

T = get_roms_grid(GRDname, S);

%  If vector rotation is required in the parent grid, interpolate
%  rotation angle (parent to target) and add it to target grid
%  structure.

T.parent_angle = roms2roms(NWAgrid, P, T, 'angle', [], Rvector,       ...
                           method, offset, RemoveNaN);

%--------------------------------------------------------------------------
%  Interpolate initial conditions from source data to application grid.
%--------------------------------------------------------------------------

disp(' ')
disp(['***********************************************************']);
disp(['** Interpolating initial conditions from NWA to GOM grid **']);
disp(['***********************************************************']);

%  The NWA data has a time coordinate in seconds, which starts
%  on 1-Jan-1900.

time = nc_read(NWAdata,'ocean_time',IniRec);
epoch = datenum('1-Jan-2000');
mydate = datestr(epoch+time/86400);

disp(' ')
disp(['** Processing: ',mydate,' **']);
disp(' ')

%  Set initial conditions time (seconds). The time coordinate for this
%  ROMS application is "seconds since 2000-01-01 00:00:00".

%I.ocean_time = time/86400-(datenum('1-Apr-2014')-datenum('1-Apr-2014'));
I.ocean_time = time-(datenum('1-Jan-2000')-datenum('1-Jan-2000'))*86400;

%  Interpolate initial conditions.

for var = VarIni
  field = char(var);
  I.(field) = roms2roms(NWAdata, P, T, field, IniRec, Rvector,        ...
                        method, offset, RemoveNaN);
end

%  Rotate interpolated 3D velocity at RHO-points to TRUE North and East.
%  Need to interpolate Parent grid rotation angle to Target grid.

irotate = 1;               % rotate for (XI,ETA) to (lon,lat)

[Urho,Vrho] = rotate_vec(I.u, I.v, T.parent_angle, irotate);

%  Rotate resulting 3D velocity (RHO-points) to target grid angle and
%  average to staggered C-grid locations.

[I.u,I.v] = roms_vectors(Urho, Vrho, T.angle, T.mask_u, T.mask_v);

%  Compute barotropic velocities by vertically integrating (u,v).
Hz2 = T.Hz;                                      %%%%%%%%%%%%%%%%% TN :add, error handling
Hz2(T.Hz < 0.1) = 0.1;                           %%%%%%%%%%%%%%%%% TN :add, error handling
% [I.ubar,I.vbar] = uv_barotropic(I.u, I.v, T.Hz);
[I.ubar,I.vbar] = uv_barotropic(I.u, I.v, Hz2);  %%%%%%%%%%%%%%%%% TN :add, error handling

%--------------------------------------------------------------------------
%  Create initial condition Netcdf file.
%--------------------------------------------------------------------------

if (CREATE),
  [status] = c_initial(S);

%  Set attributes for "ocean_time".

  avalue = 'seconds since 2000-01-01 00:00:00';
  [status] = nc_attadd(INIname,'units',avalue,'ocean_time');
  
  avalue = 'gregorian';
  [status] = nc_attadd(INIname,'calendar',avalue,'ocean_time');

%  Set global attributes.

  avalue = 'YAEYAMA2, 300 m resolution, Grid';
  [status] = nc_attadd(INIname,'title',avalue);

  avalue = 'ROMS YAEYAMA1 application';
  [status] = nc_attadd(INIname,'data_source',avalue);

  [status] = nc_attadd(INIname,'grd_file',GRDname);
end,

%--------------------------------------------------------------------------
%  Write out initial conditions.
%--------------------------------------------------------------------------

if (CREATE),
  disp(' ')
  disp(['** Writing initial conditions **']);
  disp(' ')

  for var = VarGrd,
    field = char(var);
    [status] = nc_write(INIname, field, T.(field));
  end
  
  IniRec = 1;

  field = 'ocean_time';
  [err.(field)] = nc_write(INIname, field, I.(field), IniRec);

  for var = VarIni
    field = char(var);
    [err.(field)] = nc_write(INIname, field, I.(field), IniRec);
  end
end
