
clear
close all

% -------------------------------------------------------------------------
% 
% -------------------------------------------------------------------------

% --- Import functions

% --- Configurations

grid_file   = 'Bolinao2_grd_v8.1.nc'; 
name_case   = 'HYCOMpNAO_fish_farm_grd_v8.1_cd1.5_zob0.03_riv2';
period_case = '201210_01';
% transect    = xlsread('transect.xlsx', 'A3:B34');  % Transect 1
% transect    = xlsread('transect.xlsx', 'C3:D49');  % Transect 2
transect    = xlsread('transect.xlsx', 'E3:F50');  % Transect 3
temp_range  = [27 31];  % Range of temperature for plot
nz          = 10;       % Number of vertical layers
wll_max     = 2;        % Maximum water level (m)
h_min       = -18;      % Elevation of first layer (m)
dz          = 0.1;      % Vertical resolution of contour (m)
% min_date    = datenum(2012,10,8,0,0,0);   % Period 1 start
% max_date    = datenum(2012,10,17,0,0,0);  % Period 1 end
% out_dir     = 't3_contour_p1_figs_png';   % Period 1
% min_date    = datenum(2012,10,22,0,0,0);  % Period 2 start
% max_date    = datenum(2012,11,3,0,0,0);   % Period 2 end
% out_dir     = 't3_contour_p2_figs_png';   % Period 2
% min_date    = datenum(2012,12,4,0,0,0);   % Period 3 start
% max_date    = datenum(2012,12,14,0,0,0);  % Period 3 end
% out_dir     = 't3_contour_p3_figs_png';   % Period 3
min_date    = datenum(2012,12,20,0,0,0);  % Period 4 start
max_date    = datenum(2012,12,31,0,0,0);  % Period 4 end
out_dir     = 't3_contour_p4_figs_png';   % Period 4

ref_date    = datenum(2000,1,1,8,0,0);    % for Bolinao
his         = ['I:/COAWST_Bolinao2/Bolinao2_', name_case, '_his_', period_case, '.nc'];

% --- Variables to be derived

n_point        = size(transect, 1);  % Number of grid cells overlying transect
transect_z     = zeros(1, n_point);  % Bathymetry of each grid cell

% --- Read bathymetry

grid_h = ncread(grid_file, 'h');
for i = 1 : n_point
    x = transect(i,1);
    y = transect(i,2);
    z = grid_h(x,y);
    transect_z(1,i) = z;
end

% --- Define grid for mapping

n_zgrid = (wll_max - h_min) / dz;   % Number of vertical layers
grid_elev = nan(n_zgrid, n_point);  % Grid elevation of upper boundary of each cell
grid_x    = nan(n_zgrid, n_point);
for z = 1 : n_zgrid
    grid_elev(z,:) = h_min + z*dz;
    grid_x(z,:) = 1:1:n_point;
end

% --- Read ocean time

ocean_time = ncread(his, 'ocean_time');
nt = length(ocean_time);
layer_elev = nan(nz, 1);            % Elevation of upper boundary of each layer
grid_temp = nan(n_zgrid, n_point);  % Temperature map

for t = 1 : nt
    
    date = ref_date + ocean_time(t)/24/60/60;
    date_str=strcat(datestr(date));
    
    if date >= min_date && date <= max_date
    
        grid_temp = NaN * grid_temp;

        % Read variables for each grid cell

        for i = 1 : n_point

            x = transect(i,1);
            y = transect(i,2);
            zeta = ncread(his, 'zeta', [x y t], [1 1 1]);        % Water level (m)
            temp = ncread(his, 'temp', [x y 1 t], [1 1 Inf 1]);  % Vertical profile of temperature
            temp = squeeze(temp);
            w_dep = transect_z(i) + zeta;  % Water depth (m)
            thickness = w_dep / nz;        % Layer thickness (m)
            for z = 1 : nz
                layer_elev(z) = -1*transect_z(i) + thickness*z;  % Elevation of upper boundary of each layer
            end
            for j = 1 : n_zgrid
                target_layer = NaN;
                if grid_elev(j,i) > -1*transect_z(i) && grid_elev(j,i) < layer_elev(nz)
                    for z = 1 : nz
                        if z == 1
                            if grid_elev(j,i) <= layer_elev(z)
                                target_layer = z;
                            end
                        else
                            if grid_elev(j,i) > layer_elev(z-1) && grid_elev(j,i) <= layer_elev(z)
                                target_layer = z;
                            end
                        end
                    end
                    grid_temp(j,i) = temp(target_layer);
                end
            end
        end

        figure (1)

        contourf(grid_x, grid_elev, grid_temp, 'LineStyle', 'none', 'LevelStep', 0.01)
        colormap('jet');
        colorbar
        caxis([temp_range(1) temp_range(2)]);
        set(gcf,'Position',[100 100 800 300])
        xlabel('X','FontName','Arial');
        ylabel('Elevation (m)','FontName','Arial');
        title('Temperature (degree C)','FontSize',12,'FontName','Arial', 'FontWeight', 'normal');
        annotation('textbox',...
        [0.120000002905725 0.918231553851651 0.216249997094275 0.0899999983112018],...
        'HorizontalAlignment', 'center',...
        'String',date_str,...
        'FontName','Arial',...
        'FontSize',11,...
        'FitBoxToText','on',...
        'LineStyle','none');

        hgexport(figure(1), strcat(['output/',name_case,'/',out_dir,'/v01_'],num2str(t,'%0.4u'),'.png'),hgexport('factorystyle'),'Format','png');
        close(figure(1))
    end
end



