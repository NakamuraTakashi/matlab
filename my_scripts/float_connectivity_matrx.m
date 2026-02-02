%
% === Copyright (c) 2025 Takashi NAKAMURA  =====
%                
clear;
close all;

% flt='E:/COAWST_OUTPUT/Palau/Palau2_flt_offline/P2_ROMSPath_flt_srf_HTurb1.0_202301.nc'; %LTRANS/ROMSPath float
% flt='E:/COAWST_OUTPUT/Palau/Palau2_flt_offline/P2_ROMSPath_flt_srf_HTurb1.0_202303.nc'; %LTRANS/ROMSPath float
% flt='E:/COAWST_OUTPUT/Palau/Palau2_flt_offline/P2_ROMSPath_flt_srf_HTurb1.0_202306.nc'; %LTRANS/ROMSPath float
flt='E:/COAWST_OUTPUT/Palau/Palau2_flt_offline/P2_ROMSPath_flt_srf_HTurb1.0_202311.nc'; %LTRANS/ROMSPath float

polyfile = 'F:/Dropbox/Projects/Palau/Palau_personal/model/Seagrass_polygons.shp';
csvfile  = '../ROMSPath/Projects/Palau/initial_part_location_v2.csv';

% out_dirstr = 'output/figs_Palau_matrix/202301';
% out_dirstr = 'output/figs_Palau_matrix/202303';
% out_dirstr = 'output/figs_Palau_matrix/202306';
out_dirstr = 'output/figs_Palau_matrix/202311';

out_file_prefix ='connectivity_matrix';

t_start_settle = 1.0 * 86400; % seconds
t_mortality    = 20.0 * 86400; % seconds

% N_flt_per_poly = 100; % Number of floats released per polygon at each time step.

%% Create output directory
[status, msg] = mkdir( out_dirstr )

%% === Read polygon information. =====================================

S = shaperead(polyfile);
n_poly = size(S,1);
for i=1:n_poly
    S(i).Lat = rmmissing(S(i).Y);
    S(i).Lon = rmmissing(S(i).X);
    S(i).y_km = rmmissing(S(i).Y);
    S(i).x_km = rmmissing(S(i).X);
end
% Sort by id field
S2=S;
for i=1:n_poly-1
    for j=i+1:n_poly
        if S(i).id >S(j).id
            S2(i)=S(i);
            S(i)=S(j);
            S(j)=S2(i);
        end
    end
end

%% ===  Read csv initial location data. ===================================== 

T = readtable(csvfile);
lonf_ini = T{:,1};
latf_ini = T{:,2};

%% ===  Set floats information. ===================================== 

time = ncread(flt,'model_time'); % For ROMSPath
Nt = length(time);
dob = ncread(flt,'dob');
Nf = length(dob);
% Set origin of polygon for each float
originf = zeros(Nf,1);
for i=1:Nf
    for j=1:n_poly
        if (inpolygon(lonf_ini(i), latf_ini(i), S(j).Lon, S(j).Lat))
            originf(i) = j;
        end
    end
end

inpolyf = zeros(Nf, n_poly);

%% ===  Read floats data. =====================================
Nt
% for it=1:Nt
for it=1:360
    it
    lonf = ncread(flt,'lon',[1 it],[Inf 1]);
    latf = ncread(flt,'lat',[1 it],[Inf 1]);
    statusf = ncread(flt,'status',[1 it],[Inf 1]);

    dt = time(it) - time(1); % time since model start (second)

    for i=1:n_poly
        for j=1:Nf
            if (dob(j)+t_start_settle <= dt && dt <= dob(j)+t_mortality )
                if (inpolygon(lonf(j), latf(j), S(i).Lon, S(i).Lat))
                    inpolyf(j,i) = 1;
                end
            end
        end
    end
end

%% === Save connectivity matrix =====================================

connectivity_matrix = zeros(n_poly, n_poly);
for i=1:n_poly
    count = zeros(1,n_poly);
    tot = zeros(1,n_poly);
    for j=1:Nf
        if(originf(j)==i)
            count = count + inpolyf(j,:);
            tot   = tot   + ones(1,n_poly);
        end
    end
    connectivity_matrix(i,:) = count./tot;
end
save([out_dirstr '/' out_file_prefix '.mat'], 'connectivity_matrix');
% Save as CSV
csvwrite([out_dirstr '/' out_file_prefix '.csv'], connectivity_matrix);

%% === plot the matrix =====================================

load('MyColormaps')

f1=figure;
f1.Color=[1 1 1]; f1.Position=[0 0 580 500];
clims = [0 0.5];
im=imagesc(flipud(connectivity_matrix),clims);
colormap(colmap1);
hold on
% set(gca,'YDir','normal');

ylabel('Source Node');
xlabel('Sink Node');
xticks(1:n_poly)
xticklabels(1:n_poly)
yticks(1:n_poly)
yticklabels(n_poly:-1:1)
colorbar
hold off

drawnow
exportgraphics(figure(1), [out_dirstr '/' out_file_prefix '.png'] );

%% End of float_connectivity_matrx.m

load('output/figs_Palau_matrix/202301/connectivity_matrix.mat');
cmtrx01 = connectivity_matrix;
load('output/figs_Palau_matrix/202303/connectivity_matrix.mat');
cmtrx03 = connectivity_matrix;
load('output/figs_Palau_matrix/202306/connectivity_matrix.mat');
cmtrx06 = connectivity_matrix;
load('output/figs_Palau_matrix/202311/connectivity_matrix.mat');
cmtrx11 = connectivity_matrix;

cmtrx = cmtrx01 + cmtrx03 + cmtrx06 + cmtrx11;
cmtrx = cmtrx/4;
n_poly = size(cmtrx,1);

save('output/figs_Palau_matrix/connectivity_matrix_all.mat', 'cmtrx');
% Save as CSV
csvwrite('output/figs_Palau_matrix/connectivity_matrix_all.csv', cmtrx);

% === plot the matrix =====================================

load('MyColormaps')

f1=figure;
f1.Color=[1 1 1]; f1.Position=[0 0 580 500];
clims = [0 0.5];
im=imagesc(flipud(cmtrx),clims);
colormap(colmap1);
hold on
% set(gca,'YDir','normal');

ylabel('Source Node');
xlabel('Sink Node');
xticks(1:n_poly)
xticklabels(1:n_poly)
yticks(1:n_poly)
yticklabels(n_poly:-1:1)
colorbar
hold off

drawnow
exportgraphics(figure(1), 'output/figs_Palau_matrix/connectivity_matrix_all.png' );
