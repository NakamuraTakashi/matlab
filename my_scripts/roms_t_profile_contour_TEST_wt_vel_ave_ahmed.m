
clear
close all

% -------------------------------------------------------------------------
% Map ROMS output of cross-section along a map_transect
% -------------------------------------------------------------------------

% Note:
% If his_file does not have a variable "hc", give a value of TCLINE 
% specified in the ROMS input file (.in)

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
% --- Velocity quiver plot --- %
quiver_op    = 1;        % 1: yes, otherwise: no
s_interval   = 1;        % Spacing interval
u_scale      = 10;       % Scaling factor for horizontal velocity
w_scale      = 1000;     % Scaling factor for vertical velocity
% --- Running averaging option --- %
Rho_t1       = 11;        %  Averaging at t=t0  |<------ averaging -------->|
Rho_t2       = 12;        %  t = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12,13,14,15,16,17
vel_t1       = 11;        %                     |<---------->|<------------>|
vel_t2       = 12;        %                         t1=4    t0     t2 = 5
% --- Other figure parameters --- %
font_size    = 10;
y_range      = [-50 2];  % Y-axis range (m)
dy           = 5;        % Y-axis interval (m)
dx           = 2;        % X-axis interval
xsize        = 800;      % Figure x-size
ysize        = 300;      % Figure y-size
% --- Plotting period --- %
min_date     = datenum(2002,10,22,0,0,0);
max_date     = datenum(2022,11,30,0,0,0);
ref_date     = datenum(2000,1,1,8,0,0);  % for Local time of Bolinao
% --- Transect for contour --- %
map_transect = xlsread('transect.xlsx', 'I3:J50');
fig_save     = 0;  % 1: yes, otherwise: no
out_dir      = 'test/offshore_t1_v_figs_png';
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
[Im, Jm] = size(cont_x);
cont_x2 = cont_x(1:s_interval:Im,1:s_interval:Jm);
cont_y2 = cont_x2;
vel_hor2 = cont_x2;
vel_ver2 = cont_x2;
date = ref_date + ocean_time(1)/24/60/60;
date_str = datestr(date,'dd-mmm-yyyy HH:MM:SS');
[h_quiver,h_surf,h_annot] = createmap(cont_x, cont_y, cont_z, cm, date_str, ...
                                      font_size, y_range, dy, dx, color_axis, ...
                                      xsize, ysize, cont_x2, cont_y2, vel_hor2, ...
                                      vel_ver2);

% For velocity vectors

vel_hor = nan(nz+2, n_p);
vel_ver = nan(nz+2, n_p);
vel_rad = nan(n_p,1);
for p = 1 : n_p-1
    p1 = map_transect(p,:);
    p2 = map_transect(p+1,:);
    vel_rad(p,1) = atan2(p2(2)-p1(2), p2(1)-p1(1));
    
end
vel_rad(n_p,1) = vel_rad(n_p-1,1);

% --- Make figure

t1_max = max(Rho_t1, vel_t1);
t2_max = max(Rho_t2, vel_t2);

for t = 1+t1_max : nt-t2_max
    
    date = ref_date + ocean_time(t)/24/60/60;
    date_str = datestr(date,'dd-mmm-yyyy HH:MM:SS');
    
    % NaN-out
    cont_z = nan(nz+2, n_p);
    vel_hor = nan(nz+2, n_p);
    vel_ver = nan(nz+2, n_p);

    if date >= min_date && date <= max_date
        for p = 1 : n_p
            
            % --- Coordinates of points
            i = map_transect(p,1); j = map_transect(p,2);
            h = grid_h(i,j);
            zeta = ncread(his,'zeta',[i j t],[1 1 1]);
            
            % --- Rho-variables
            temp = ncread(his,var_name,[i j 1 t-Rho_t1],[1 1 Inf Rho_t1+Rho_t2+1]);
            temp = squeeze(temp);
            temp = mean(temp,2,'omitnan');  % Running average between t1-t2
                        
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

            if quiver_op == 1
                % Horizontal velocity
                u1 = ncread(his,'u',[i j 1 t-vel_t1],[1 1 Inf vel_t1+vel_t2+1]);
                u2 = ncread(his,'u',[i-1 j 1 t-vel_t1],[1 1 Inf vel_t1+vel_t2+1]);
                u1 = squeeze(u1); u2 = squeeze(u2);
                u1_ave = mean(u1,2,'omitnan');    % Running average for (i j)
                u2_ave = mean(u2,2,'omitnan');    % Running average for (i-1 j)
                u_ave = horzcat(u1_ave, u2_ave);
                u_ave = mean(u_ave,2,'omitnan');  % Average of (i j) and (i-1 j)
                
                v1 = ncread(his,'v',[i j 1 t-vel_t1],[1 1 Inf vel_t1+vel_t2+1]);
                v2 = ncread(his,'v',[i j-1 1 t-vel_t1],[1 1 Inf vel_t1+vel_t2+1]);
                v1 = squeeze(v1); v2 = squeeze(v2);
                v1_ave = mean(v1,2,'omitnan');    % Running average for (i j)
                v2_ave = mean(v2,2,'omitnan');    % Running average for (i j-1)
                v_ave = horzcat(v1_ave, v2_ave);
                v_ave = mean(v_ave,2,'omitnan');  % Average of (i j) and (i j-1)
                
                vel_hor(2:nz+1,p) = cos(vel_rad(p,1)).*u_ave+sin(vel_rad(p,1)).*v_ave;
                
                % Vertical velocity
                w = ncread(his,'w',[i j 1 t-vel_t1],[1 1 Inf vel_t1+vel_t2+1]);
                w = squeeze(w);
                w = mean(w,2,'omitnan');  % Running average between t1-t2
                w2 = nan(nz,1);
                for k = 1 : nz
                    w2(k,1) = 0.5*(w(k)+w(k+1));
                end
                w3 = vertcat(NaN,w2,NaN);
                vel_ver(:,p) = w3;
            end

        end
        
        cont_y2 = cont_y(1:s_interval:Im,1:s_interval:Jm);
        vel_hor2 = vel_hor(1:s_interval:Im,1:s_interval:Jm);
        vel_ver2 = vel_ver(1:s_interval:Im,1:s_interval:Jm);

        set(h_surf,'YData',cont_y)
        set(h_surf,'CData',cont_z)
        if quiver_op == 1
            set(h_quiver,'YData',cont_y2)
            set(h_quiver,'UData',vel_hor2.*u_scale)
            set(h_quiver,'VData',vel_ver2.*w_scale)
        end
        set(h_annot,'String',date_str)
        drawnow
        
        if fig_save == 1
            hgexport(figure(1), strcat([out_dir,'/v01_'],num2str(t,'%0.4u'),'.png'),hgexport('factorystyle'),'Format','png');
        end
        
    end
end


function [h_quiver,h_surf,h_annot] = createmap(cont_x, cont_y, cont_z, cm, date_str, ...
                                      font_size, y_range, dy, dx, color_axis, ...
                                      xsize, ysize, cont_x2, cont_y2, vel_hor2, ...
                                      vel_ver2)

figure1 = figure('Position',[0 100 xsize ysize],...
    'Color',[1 1 1]);
axes1 = axes('Parent',figure1,...
    'YTick', y_range(1):dy:y_range(2),...
    'XTick', min(cont_x(:)):dx:max(cont_x(:)),...
    'FontSize',font_size,...
    'FontName','Arial',...
    'CLim',color_axis,...
    'Box','on');

xlim(axes1,[min(cont_x(:))-1 max(cont_x(:))+1]);
ylim(axes1,[y_range(1) y_range(2)]);
hold(axes1,'all');

h_surf = surface(cont_x,cont_y,cont_z, 'LineStyle', 'none');
colormap(cm);
colorbar
set(h_surf,'ZData',-1+zeros(size(cont_z)))

h_quiver = quiver(cont_x2,cont_y2,vel_hor2,vel_ver2,...
                 'Color', 'w',...
                 'AutoScale','off');

xlabel('X','FontName','Arial','FontSize',font_size);
ylabel('Elevation (m)','FontName','Arial','FontSize',font_size);
title('Temperature (degree C)','FontSize',font_size,'FontName','Arial', 'FontWeight', 'normal');

h_annot=annotation('textbox',...
        [0.120000002905725 0.918231553851651 0.216249997094275 0.0899999983112018],...
        'HorizontalAlignment', 'center',...
        'String',date_str,...
        'FontName','Arial',...
        'FontSize',font_size,...
        'FitBoxToText','on',...
        'LineStyle','none');

end
