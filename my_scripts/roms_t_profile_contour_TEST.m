
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
grid_file   = 'F:\COAWST_DATA\Shizugawa\Shizugawa3\Grid\Shizugawa3_grd_v0.0.nc';
% --- Other figure parameters --- %
font_size    = 11;
y_range      = [-55 2];  % Y-axis range (m)
dy           = 5;        % Y-axis interval (m)
dx           = 2;        % X-axis interval
xsize        = 700;      % Figure x-size
ysize        = 300;      % Figure y-size
% --- Plotting period --- %
min_date    = datenum(2021,8,3,0,0,0);  % Period 4 start
max_date    = datenum(2021,11,1,0,0,0);  % Period 4 end
ref_date     = datenum(2000,1,1,8,0,0);  % for Local time of Bolinao
% --- Transect for contour --- %
map_transect = xlsread('transect_SZ.xlsx', 'A3:B141');
fig_save     = 0;  % 1: yes, otherwise: no
out_dir      = 'test/offshore_t1_v_figs_png';
% ------------------------ %

his         = ['E:\COAWTS_OUTPUT\Shizugawa3\Shizugawa3_his_20210104.nc'];
out_dirstr = 'output/figs_png_S3prof';
ncname='temp'
[status, msg] = mkdir( out_dirstr )

LOCAL_TIME=' (UTC)';
%LOCAL_TIME=' (JST)';
%LOCAL_TIME=' (UTC+9)';
% LOCAL_TIME='';

% --- Load new colormaps

load('MyColormaps')
colormap6=superjet(128,'NuvibZctgyorWq');

% --- Variable to plot

title='Temperature (^oC)'; cmin=15; cmax=30; colmap=colormap6; ncname='temp';

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
[h_surf,h_annot] = createmap(cont_x, cont_y, cont_z, colmap, date_str, ...
                             font_size, y_range, dy, dx, [cmin cmax], ...
                             xsize, ysize, title);

% --- Make figure

for t = 1 : nt
    
    date = ref_date + ocean_time(t)/24/60/60;
    date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);
    
    cont_z = nan(nz+2, n_p);

    if date >= min_date && date <= max_date
        for p = 1 : n_p
            i = map_transect(p,1); j = map_transect(p,2);
            h = grid_h(i,j);
            zeta = ncread(his,'zeta',[i j t],[1 1 1]);
            temp = ncread(his, ncname, [i j 1 t], [1 1 Inf 1]);
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
        
        if fig_save == 1
            fname = strcat( ncname, datestr(date,'_yyyymmddHHMM') );
            hgexport(figure(1), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');
        end

        
    end
end

% ------------------------------------------------------------------------------------
function [h_surf,h_annot] = createmap(cont_x, cont_y, cont_z, cm, date_str, ...
                                      font_size, y_range, dy, dx, color_axis, ...
                                      xsize, ysize, title_str)

figure1 = figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'Colormap',cm,...
    'GraphicsSmoothing','off',...
    'Position',[0 0 xsize ysize]);
axes1 = axes('Parent',figure1,...
    'YTick', y_range(1):dy:y_range(2),...
    'XTick', min(cont_x(:)):dx:max(cont_x(:)),...
    'FontSize',10,...
    'FontName','Arial',...
    'CLim',color_axis,...
    'Box','on');

xlim(axes1,[min(cont_x(:)) max(cont_x(:))]);
xticks('auto')
ylim(axes1,[y_range(1) y_range(2)]);
hold(axes1,'all');

h_surf = surface(cont_x,cont_y,cont_z, 'LineStyle', 'none');
% colormap(cm);
colorbar
xlabel('Distance (km)','FontName','Arial');
ylabel('Elevation (m)','FontName','Arial');
title(title_str,'FontSize',font_size,'FontName','Arial', 'FontWeight', 'normal');

h_annot=annotation(figure1,'textbox',...
    [0.15 0.25 0.6 0.01],...
    'HorizontalAlignment', 'left',...
    'String',date_str,...
    'FontName','Arial',...
    'FontSize',11,...
    'FitBoxToText','on',...
    'LineStyle','none');


end
