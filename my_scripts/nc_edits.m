% === Copyright (c) 2024 Takashi NAKAMURA  =====

NC_FILE = 'Shizugawa3_noaq_grd_v0.3b.nc';
ncdisp(NC_FILE)
%% 
% NC_VAR = 'aquaculture_01';
% NC_VAR = 'aquaculture_02';
% NC_VAR = 'aquaculture_03';
% NC_VAR = 'aquaculture_04';
NC_VAR = 'aquaculture_05';
ncdata = ncread(NC_FILE,NC_VAR);

ncdata2= zeros(size(ncdata));
%% 
ncwrite(NC_FILE,NC_VAR,ncdata2);
