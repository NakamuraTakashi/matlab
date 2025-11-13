
clear
close all

% -------------------------------------------------------------------------
% Map ROMS output of cross-section along a map_transect
% -------------------------------------------------------------------------

% --- Import functions

% --- Configurations

% --- Grid and his file --- %
grid_file    = 'Bolinao2_grd_v8.1.nc'; 
name_case    = 'HYCOMpNAO_fish_farm_grd_v8.1_cd1.5_zob0.03_riv2';
period_case  = '201210_01';
% --- Color map option --- %
% cm_op        = 'magma';
cm_op        = 'inferno';
% cm_op        = 'viridis';
% cm_op        = 'plasma';
% --- Variables to visualize --- %
plot_op      = 'temp';
% plot_op      = 'rho';
% --- Range for color map --- %
temp_range   = [27 31];
rho_range    = [20.5 22];
% --- Other figure parameters --- %
font_size    = 10;
y_range      = [-50 2];
dy           = 5;
dx           = 2;
xsize        = 800;
ysize        = 300;
% --- Plotting period --- %
min_date     = datenum(2012,10,22,0,0,0);
max_date     = datenum(2012,10,28,0,0,0);
ref_date     = datenum(2000,1,1,8,0,0);  % for Local time of Bolinao
% --- Transect for contour --- %
map_transect = xlsread('transect.xlsx', 'I3:J50');
out_dir      = 'offshore_t1_v_figs_png';
% ------------------------ %

his = ['I:/COAWST_Bolinao2/Bolinao2_', name_case, '_his_', period_case, '.nc'];

% --- Load new colormaps

m=100;
cm_magma=magma(m);
cm_inferno=inferno(m);
cm_plasma=plasma(m);
cm_viridis=viridis(m);
switch cm_op
    case 'magma'
        cm = cm_magma;
    case 'inferno'
        cm = cm_inferno;
    case 'plasma'
        cm = cm_plasma;
    case 'viridis'
        cm = cm_viridis;
end

% --- Variable to plot

switch plot_op
    case 'temp'
        var_name = 'temp';
        color_axis = [temp_range(1) temp_range(2)];
    case 'rho'
        var_name = 'rho';
        color_axis = [rho_range(1) rho_range(2)];
end

% --- Read ocean time

ocean_time = ncread(his, 'ocean_time');
nt = length(ocean_time);

% --- Read grid parameters

nz = length(ncread(his, 's_rho'));  % Number of vertical layers
grid_h = ncread(grid_file, 'h');    % Bathymetry (m)
hc = ncread(his, 'hc');             % 'S-coordinate parameter, critical depth'
sc_r = ncread(his, 's_rho');        % 'S-coordinate at RHO-points'
Cs_r = ncread(his, 'Cs_r');         % 'S-coordinate stretching curves at RHO-points'
sc_w = ncread(his, 's_w');          % 'S-coordinate at W-points'
Cs_w = ncread(his, 'Cs_w');         % 'S-coordinate stretching curves at W-points'
Vtransform = ncread(his, 'Vtransform');
Vstretching = ncread(his, 'Vstretching');

if Vtransform~=2 || Vstretching~=4
    error('Not applicable: Vtransform & Vstretching')
end

% --- Prepare for figure

n_p = length(map_transect(:,1));  % Number of grid cells overlying map_transect
cont_x = nan(nz+2, n_p);
for k = 1 : nz+2
    cont_x(k,:) = 1:1:n_p;
end
cont_y = cont_x;
cont_z = cont_x;
date = ref_date + ocean_time(1)/24/60/60;
date_str = datestr(date,'dd-mmm-yyyy HH:MM:SS');
[h_surf,h_annot] = createmap(cont_x, cont_y, cont_z, cm, date_str, ...
                             font_size, y_range, dy, dx, color_axis, ...
                             xsize, ysize);

% --- Make figure

for t = 1 : nt
    
    date = ref_date + ocean_time(t)/24/60/60;
    date_str = datestr(date,'dd-mmm-yyyy HH:MM:SS');
    
    cont_z = nan(nz+2, n_p);

    if date >= min_date && date <= max_date
        for p = 1 : n_p
            i = map_transect(p,1); j = map_transect(p,2);
            h = grid_h(i,j);
            zeta = ncread(his,'zeta',[i j t],[1 1 1]);
            temp = ncread(his, var_name, [i j 1 t], [1 1 Inf 1]);
            temp = squeeze(temp);

            % for bottom
            z0 = (hc*sc_w(1)+Cs_w(1)*h)/(hc+h);
            cont_y(1,p) = zeta+(zeta+h)*z0;
            cont_z(1,p) = temp(1);

            % for surface
            z0 = (hc*sc_w(nz+1)+Cs_w(nz+1)*h)/(hc+h);
            cont_y(nz+2,p) = zeta+(zeta+h)*z0;
            cont_z(nz+2,p) = temp(nz);

            % for rho points
            for k = 1 : nz
                z0 = (hc*sc_r(k)+Cs_r(k)*h)./(hc+h);
                cont_y(k+1,p) = zeta+(zeta+h)*z0;
            end
            cont_z(2:nz+1,p) = temp;
        end
        
        set(h_surf,'YData',cont_y)
        set(h_surf,'Cdata',cont_z)
        set(h_annot,'String',date_str)
        drawnow
        
    end
end


function [h_surf,h_annot] = createmap(cont_x, cont_y, cont_z, cm, date_str, ...
                                      font_size, y_range, dy, dx, color_axis, ...
                                      xsize, ysize)

figure1 = figure('Position',[0 100 xsize ysize],...
    'Color',[1 1 1]);
axes1 = axes('Parent',figure1,...
    'YTick', y_range(1):dy:y_range(2),...
    'XTick', min(cont_x(:)):dx:max(cont_x(:)),...
    'FontSize',11,...
    'FontName','Arial',...
    'CLim',color_axis,...
    'Box','on');

xlim(axes1,[min(cont_x(:)) max(cont_x(:))]);
ylim(axes1,[y_range(1) y_range(2)]);
hold(axes1,'all');

h_surf = surface(cont_x,cont_y,cont_z, 'LineStyle', 'none');
colormap(cm);
colorbar
xlabel('X','FontName','Arial');
ylabel('Elevation (m)','FontName','Arial');
title('Temperature (degree C)','FontSize',font_size,'FontName','Arial', 'FontWeight', 'normal');

h_annot=annotation('textbox',...
        [0.120000002905725 0.918231553851651 0.216249997094275 0.0899999983112018],...
        'HorizontalAlignment', 'center',...
        'String',date_str,...
        'FontName','Arial',...
        'FontSize',11,...
        'FitBoxToText','on',...
        'LineStyle','none');

end
