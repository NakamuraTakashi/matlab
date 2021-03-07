% Input grid file name
% Gname1='D:\ROMS\Data\Yaeyama\Yaeyama1_grd_v10.nc';
% Gname2='D:\ROMS\Data\Yaeyama\Yaeyama2_grd_v9.4.nc';
% Gname3='D:\ROMS\Data\Yaeyama\Yaeyama3_grd_v11.nc';
Gname1='D:\ROMS\Data\Coral_Triangle\CT_0.08_grd_v2.nc';
Gname2='D:\cygwin64\home\Takashi\COAWST\Data\Berau\Berau1_grd_v1.2.nc';
Gname3='D:\cygwin64\home\Takashi\COAWST\Data\Berau\Berau2_grd_v3.1.nc';
% Gname2='D:\cygwin64\home\Takashi\ROMS_prep\Projects\Palau\Palau1_grd_v1.0.nc';
% Gname3='D:\cygwin64\home\Takashi\ROMS_prep\Projects\Palau\Palau2_grd_v1.0.nc';

% Select 1 of 3
%Cname='Yaeyama_ngc_2g_Y1Y2_v6.nc';  %% for single nesting
% Cname='Yaeyama_ngc_2g_Y2Y3_v3.nc';  %% for single nesting
% Cname='Yaeyama_ngc_3g_Y1Y2Y3_v7.nc';  %% for double nesting

% Cname='Berau_ngc_2g_CTB1_v1.0.nc';  %% for single nesting
Cname='Berau_ngc_2g_B1B2_v1.1.nc';  %% for single nesting
% Cname='Palau_ngc_2g_CTP1_v1.0.nc';  %% for single nesting

% Select 1 of 3
% Gnames ={Gname1, Gname2};  %% for single nesting
Gnames ={Gname2, Gname3};  %% for single nesting
% Gnames ={Gname1, Gname2, Gname3};  %% for double nesting

% Select 1 of 2
[S,G] = contact(Gnames, Cname, true, false, true);  %% for single nesting
% [S,G] = contact2(Gnames, Cname, true);  %% for double nesting



