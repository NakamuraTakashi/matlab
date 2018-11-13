% Input grid file name
Gname1='D:\ROMS\Data\Yaeyama\Yaeyama1_grd_v10.nc';
Gname2='D:\ROMS\Data\Yaeyama\Yaeyama2_grd_v9.4.nc';
Gname3='D:\ROMS\Data\Yaeyama\Yaeyama3_grd_v11.nc';

% Select 1 of 3
%Cname='Yaeyama_ngc_2g_Y1Y2_v6.nc';  %% for single nesting
Cname='Yaeyama_ngc_2g_Y2Y3_v3.nc';  %% for single nesting
% Cname='Yaeyama_ngc_3g_Y1Y2Y3_v7.nc';  %% for double nesting

% Select 1 of 3
%Gnames ={Gname1, Gname2};  %% for single nesting
Gnames ={Gname2, Gname3};  %% for single nesting
% Gnames ={Gname1, Gname2, Gname3};  %% for double nesting

% Select 1 of 2
[S,G] = contact(Gnames, Cname);  %% for single nesting
% [S,G] = contact2(Gnames, Cname, true);  %% for double nesting



