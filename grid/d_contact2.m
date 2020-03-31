% Input grid file name
Gname1='D:\cygwin64\home\Takashi\COAWST\Data\Fukido_reef\Fukido2_20m_grd_v1.nc';
Gname2='D:\cygwin64\home\Takashi\COAWST\Data\Fukido_reef\Fukido3_4m_mangrove_grd_v0.2.nc';

% Cname='Berau_ngc_2g_CTB1_v1.0.nc';  %% for single nesting
Cname='Fukido_ngc_2g_v1.0.nc';  %% for single nesting

% Select 1 of 3
Gnames ={Gname1, Gname2};  %% for single nesting
% Gnames ={Gname2, Gname3};  %% for single nesting
% Gnames ={Gname1, Gname2, Gname3};  %% for double nesting

% Select 1 of 2
[S,G] = contact(Gnames, Cname, true, false);  %% for single nesting
% [S,G] = contact2(Gnames, Cname, true);  %% for double nesting



