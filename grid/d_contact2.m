% if the case of YAEYAMA series, 
%   set "spherical = 0" at line 170 in get_roms_grid.m
% otherwise
%   comentout the line 170 in get_roms_grid.m

% Input grid file name
% Gname1='F:/COAWST_DATA/Yaeyama/Fukido2/Grid/Fukido2_20m_grd_v6.7.nc';
% Gname2='F:/COAWST_DATA/Yaeyama/Fukido3/Grid/Fukido3_4m_grd_v4.1.nc';
Gname1='F:/COAWST_DATA/Yaeyama/Yaeyama1/Grid/Yaeyama1_grd_v10.nc';
Gname2='F:/COAWST_DATA/Yaeyama/Yaeyama2/Grid/Yaeyama2_grd_v11.1.nc';
Gname3='F:/COAWST_DATA/Yaeyama/Yaeyama3/Grid/Yaeyama3_grd_v12.2.nc';
% Gname1='F:/COAWST_DATA/TokyoBay/TokyoBay2/Grid/TokyoBay2_grd_v2.0.nc';
% Gname2='F:/COAWST_DATA/TokyoBay/TokyoBay3/Grid/TokyoBay3_grd_v1.0.nc';

% Cname='Berau_ngc_2g_CTB1_v1.0.nc';  %% for single nesting
% Cname='Fukido_ngc_2g_F2F3_v5.0.nc';  %% for single nesting
% Cname='Yaeyama_ngc_2g_Y1Y2_v1.2.nc';  %% for single nesting
% Cname='Yaeyama_ngc_2g_Y2Y3_v1.0.nc';  %% for single nesting
Cname='Yaeyama_ngc_3g_Y1Y2Y3_v1.0.nc';  %% for single nesting
% Cname='TokyoBay_ngc_2g_T2T3_v3.0.nc';  %% for single nesting

% Select 1 of 3
% Gnames ={Gname1, Gname2};  %% for single nesting
% Gnames ={Gname2, Gname3};  %% for single nesting
Gnames ={Gname1, Gname2, Gname3};  %% for double nesting

% Select 1 of 2
[S,G] = contact(Gnames, Cname, true, false, true);  %% for single nesting




