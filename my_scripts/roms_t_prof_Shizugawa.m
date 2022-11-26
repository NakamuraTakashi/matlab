
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
grd   = 'F:\COAWST_DATA\Shizugawa\Shizugawa3\Grid\Shizugawa3_grd_v0.0.nc';
% --- Other figure parameters --- %
font_size    = 11;
y_range      = [-2 55];  % Y-axis range (m)
xsize        = 600;      % Figure x-size
ysize        = 250;      % Figure y-size
% --- Plotting period --- %
min_date    = datenum(2021,6,1,0,0,0);  % Period 4 start
max_date    = datenum(2021,11,1,0,0,0);  % Period 4 end
ref_date     = datenum(2000,1,1,0,0,0);  % 
% --- Transect for contour --- %
% map_transect = xlsread('transect_SZ.xlsx', 'A3:B141');
map_transect = xlsread('transect_SZ.xlsx', 'C3:D138');
fig_save     = 1;  % 1: yes, otherwise: no

unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

% ------------------------ %

% his         = ['E:\COAWTS_OUTPUT\Shizugawa3\Shizugawa3_his_20210104.nc'];
his         = ["E:\COAWTS_OUTPUT\Shizugawa3\Shizugawa3_his_20210824.nc"];
out_dirstr = 'output/figs_png_S3prof';
[status, msg] = mkdir( out_dirstr )

LOCAL_TIME=' (UTC)';
%LOCAL_TIME=' (JST)';
%LOCAL_TIME=' (UTC+9)';
% LOCAL_TIME='';
LevelList = [-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130];

% --- Load new colormaps

load('MyColormaps')
colormap6=superjet(128,'NuvibZctgyorWq');
colormap7=superjet(128,'qhaoGUDylggtttZZZZbbbbiiiiiuuuuuuuuA');

% --- Variable to plot

title='Temperature (^oC)'; cmin=5; cmax=30; colmap=colormap6; ncname='temp';
% title='Salinity (psu)'; cmin=33; cmax=35; colmap=colormap6; ncname='salt';
% title='DO (umol/L)'; cmin=0; cmax=300; colmap=colormap6; ncname='oxygen';

% --- Read ocean time

ocean_time = ncread(his, 'ocean_time');
nt = length(ocean_time);

% --- Read grid parameters

nz = length(ncread(his, 's_rho'));  % Number of vertical layers
grid_h = ncread(grd, 'h');    % Bathymetry (m)
% latr = ncread(grd, 'lat_rho');    % lat
% lonr = ncread(grd, 'lon_rho');    % lon
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

if strcmp(unit,'latlon')
    y_rho    = ncread(grd,'lat_rho');
    x_rho    = ncread(grd,'lon_rho');
elseif strcmp(unit,'m')
    x_rho      = ncread(grd,'x_rho');
    y_rho      = ncread(grd,'y_rho');
    x_rho=x_rho-min(min(x_rho));
    y_rho=y_rho-min(min(y_rho));
elseif strcmp(unit,'km')
    x_rho      = ncread(grd,'x_rho');
    y_rho      = ncread(grd,'y_rho');
    x_rho=(x_rho-min(min(x_rho)))/1000; % m->km
    y_rho=(y_rho-min(min(y_rho)))/1000; % m->km
end


% --- Prepare for figure

n_p = length(map_transect(:,1));  % Number of grid cells overlying map_transect

if strcmp(unit,'latlon')
    lonp=zeros(1,n_p);latp=zeros(1,n_p);
    for p = 1 : n_p
        i = map_transect(p,1);   j = map_transect(p,2);
        lonp(p)=x_rho(i,j); latp(p)=y_rho(i,j);
    end
    [xp,yp,utmzone] = deg2utm(latp,lonp);
else
    xp=zeros(1,n_p);yp=zeros(1,n_p);
    for p = 1 : n_p
        i = map_transect(p,1);   j = map_transect(p,2);
        xp(p)=x_rho(i,j); yp(p)=y_rho(i,j);
    end
end


%% 
mask_u   = ncread(grd,'mask_u');
mask_v   = ncread(grd,'mask_v');
mask_rho   = ncread(grd,'mask_rho');
mask_u = mask_u ./mask_u;
mask_v = mask_v ./mask_v;
mask_rho = mask_rho ./mask_rho;

% xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
xmin=0.7;   xmax=11.5;  ymin=1.5;   ymax=11;
xsize2=620; ysize2=500;
tmp=grid_h.*mask_rho;

createplot(x_rho,y_rho,tmp,grid_h,'Transect',0,60,colmap2,xsize2,ysize2,xmin,xmax,ymin,ymax,unit,LevelList);
hold on
if strcmp(unit,'latlon')
    p=plot(lonp,latp);
else
    p=plot(xp,yp);
end
p.LineStyle = "-";
p.LineWidth = 1;
p.Color = "red";
p.Marker = "o";
p.MarkerSize=5;
hold off
%% 
cont_x = nan(nz+2, n_p);
cont_x(:,1) = 0;
for p = 2 : n_p
    d=sqrt((xp(p)-xp(p-1))^2+(yp(p)-yp(p-1))^2);
    cont_x(:,p) = cont_x(:,p-1)+d;
end
cont_y = cont_x;
cont_z = cont_x;

date = ref_date + ocean_time(1)/24/60/60;
date_str = datestr(date,'dd-mmm-yyyy HH:MM:SS');
[h_surf,h_annot] = createmap(cont_x, cont_y, cont_z, colmap, date_str, ...
                             font_size, y_range, [cmin cmax], ...
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
        
        set(h_surf,'YData',-cont_y)
        set(h_surf,'Cdata',cont_z)
        set(h_annot,'String',date_str)
        drawnow
        
        if fig_save == 1
            fname = strcat( ncname, datestr(date,'_yyyymmddHHMM') );
            hgexport(figure(2), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');
        end

        
    end
end

% ------------------------------------------------------------------------------------
function[h_surf,h_contour]=  createplot(XData1,YData1,CData1,zdata2, title1,Cmin,Cmax, colmap, xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList)
%CREATEFIGURE(ZDATA1,YDATA1,XDATA1,CDATA1,ZDATA2)
%  ZDATA1:  surface zdata
%  YDATA1:  surface ydata
%  XDATA1:  surface xdata
%  CDATA1:  surface cdata
%  ZDATA2:  contour z

figure1 = figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'Colormap',colmap,...
    'GraphicsSmoothing','off',...
    'Position',[600 0 xsize ysize]);

dx=xmax-xmin;
dy=ymax-ymin;
for i=0:10
    interval = 10^i;
    if(min(dx/10^i,dy/10^i)<10)
        break
    end
end

if strcmp(unit,'latlon')
    lat_m=median(YData1,'all');
    aspr=1/cos(lat_m/180*pi);
else
    aspr=1;
end

% axes
axes1 = axes('Parent',figure1,...
    'YTick', ymin:interval:ymax,...
    'XTick', xmin:interval:xmax,...
    'FontSize',9,...
    'FontName','Arial',...
    'CLim',[Cmin Cmax],...
    'Box','on');

% Axes
 xlim(axes1,[xmin xmax]);
 xticks('auto')
% Axes
 ylim(axes1,[ymin ymax]);
% ylim auto
yticks('auto')
hold(axes1,'all');
pbaspect([dx dy*aspr 1])


% surface

% colorbar
colorbar('peer',axes1,...
    'FontSize',9,'FontName','Arial');

h_surf=pcolor(XData1,YData1,CData1);
shading flat;
% shading interp;

% contour
h_contour=contour(XData1,YData1,zdata2,...
    'LineColor',[0.48 0.06 0.92],...
    'LevelList',LevelList,...
    'Parent',axes1,...
    'ShowText','off');

if strcmp(unit,'km')
    % xlabel
    xlabel('X (km)','FontSize',9,'FontName','Arial');
    % ylabel
    ylabel('Y (km)','FontSize',9,'FontName','Arial');
elseif strcmp(unit,'m') 
    % xlabel
    xlabel('X (m)','FontSize',9,'FontName','Arial');
    % ylabel
    ylabel('Y (m)','FontSize',9,'FontName','Arial');
elseif strcmp(unit,'latlon')
    % xlabel
    xlabel('Longitude','FontSize',9,'FontName','Arial');
    % ylabel
    ylabel('Latitude','FontSize',9,'FontName','Arial');
end

% title
title(title1,'FontSize',12,'FontName','Arial', 'FontWeight', 'normal');

% colorbar
%colormap(colmap);
%colorbar('peer',axes1);

end

% --------------------------------------------------------------------------
function [h_surf,h_annot] = createmap(cont_x, cont_y, cont_z, cm, date_str, ...
                                      font_size, y_range, color_axis, ...
                                      xsize, ysize, title_str)

figure1 = figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'Colormap',cm,...
    'GraphicsSmoothing','off',...
    'Position',[0 0 xsize ysize]);
axes1 = axes('Parent',figure1,...
    'YTick', y_range(1):1:y_range(2),...
    'YDir', 'reverse',...
    'XTick', min(cont_x(:)):1:max(cont_x(:)),...
    'FontSize',10,...
    'FontName','Arial',...
    'CLim',color_axis,...
    'Box','on');

xlim(axes1,[min(cont_x(:)) max(cont_x(:))]);
xticks('auto')
ylim(axes1,[y_range(1) y_range(2)]);
yticks('auto')
hold(axes1,'all');

h_surf = surface(cont_x,cont_y,cont_z, 'LineStyle', 'none', 'FaceColor', 'interp');
% h_surf = contour(cont_x,cont_y,cont_z, 'LineStyle', 'none');

colorbar
xlabel('Distance (km)','FontName','Arial');
ylabel('Depth (m)','FontName','Arial');
title(title_str,'FontSize',font_size,'FontName','Arial', 'FontWeight', 'normal');

h_annot=annotation(figure1,'textbox',...
    [0.14 0.25 0.6 0.01],...
    'HorizontalAlignment', 'left',...
    'String',date_str,...
    'FontName','Arial',...
    'FontSize',11,...
    'FitBoxToText','on',...
    'LineStyle','none');

end
