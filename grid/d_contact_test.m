Gname1='D:\cygwin64\home\Takashi\COAWST\Data\Fukido_reef\Fukido2_20m_grd_v0.nc';
Gname2='D:\cygwin64\home\Takashi\COAWST\Data\Fukido_reef\Fukido3_4m_mangrove_grd_v0.1.nc';

G2_Irange = 58:75;
G2_Jrange = 161:163;

parent_Imin = ncreadatt(Gname2,'/','parent_Imin');
parent_Jmin = ncreadatt(Gname2,'/','parent_Jmin');
refine_factor = ncreadatt(Gname2,'/','refine_factor');

xi_dg_r

