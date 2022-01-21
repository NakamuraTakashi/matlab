N = 15;
Vtransform  = 2;    % transformation equation
Vstretching = 4;    % stretching function
THETA_S = 7.0;      % surface stretching parameter
THETA_B = 0.1;      % bottom  stretching parameter
TCLINE  = 200.0;    % critical depth (m)

%  Depth grid type logical switch:
kgrid = 0;        % depths of RHO-points
% kgrid = 1;        % depths of W-points

%    column        Grid direction logical switch:
column = 1;     %  column section
% column = 0;       row section

%    index         Column or row to compute (scalar)
%                    if column = 1,    then   1 <= index <= Lp
%                    if column = 0,    then   1 <= index <= Mp
index = 147;

%    plt           Switch to plot scoordinate (scalar):
% plt = 0;         % do not plot
plt = 2;         % plot
% plt = 2;         % plot 2 pannels with zoom

Zzoom =200;       % If plt=2, maximum depth of the zoom in upper pannel

%    igrid         Staggered grid C-type (integer):
%                    igrid=1  => density points
%                    igrid=2  => streamfunction points
%                    igrid=3  => u-velocity points
%                    igrid=4  => v-velocity points
%                    igrid=5  => w-velocity points
igrid=1;
%    report        Flag to report detailed information (OPTIONAL):
%                    report = 0,       do not report
%                    report = 1,       report information
report=0;


grd='F:/COAWST_DATA/Yaeyama/Yaeyama2/Grid/Yaeyama2_grd_v11.2.nc';

h = ncread(grd, 'h');
rmask = ncread(grd, 'mask_rho');
lonr = ncread(grd, 'lon_rho');
latr = ncread(grd, 'lat_rho');
zeta = zeros(size(h));

i = 147; j = 136;  % YAEYAMA2; Monitouring buoy (24.3297, 124.03705) 


[z2,s,C]=scoord(h, lonr, latr, Vtransform, Vstretching, ...
               THETA_S, THETA_B, TCLINE,             ...
               N, kgrid, column, index, plt, Zzoom);
           
[z]=set_depth(Vtransform, Vstretching, ...
              THETA_S, THETA_B, TCLINE, N, ...
              igrid, h, zeta, report);
          
% [z]=set_depth(Vtransform, Vstretching, ...
%               THETA_S, THETA_B, TCLINE, N, ...
%               igrid, h(i,j), zeta(i,j), report);
          