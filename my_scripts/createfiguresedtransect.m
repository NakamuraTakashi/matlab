function[h_surf,h_surf2,h_contour,h_core,h_annot,axes1,axes2,axes3]= createfiguresedtransect(XData1,XData2,YData1,YData2,CData1,CData2,zdata2, annot_str, title1,Cmin,Cmax, colmap, xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList,transect_Y_position,core_X_position)

figure1 = figure('PaperSize',[30 60],...
    'Color',[1 1 1],...
    'Colormap',colmap,...
    'GraphicsSmoothing','off',...
    'Position',[0 0 xsize ysize]);

plotwidth = 0.5; % 60% of page

% heatmap

dx=xmax-xmin;
dy=(ymax-ymin);
for i=0:10
    interval = 10^i;
    if(min(dx/10^i,dy/10^i)<10)
        break
    end
end  

% plotwidth = 0.6; % 60% of page
plotheight = plotwidth*xsize/dx*dy/ysize;
% axes
axes1 = axes('Parent',figure1,...
    'YTick', ymin:interval:ymax,...
    'XTick', xmin:interval:xmax,...
    'FontSize',9,...
    'FontName','Arial',...
    'CLim',[Cmin Cmax],...
    'Position',[0.1 0.3 plotwidth plotheight],...
    'Box','on');

xlim manual
ylim manual
xlim(axes1,[xmin xmax]);
ylim(axes1,[ymin ymax]);
hold on
pbaspect([dx dy 1])


% surface
%surface('Parent',axes1,'ZData',ZData1,'YData',YData1,'XData',XData1,...
%    'LineStyle','none',...
%    'CData', CData1);

h_surf=pcolor(XData1,YData1,CData1);
shading flat;
%shading interp;

% colorbar
%colormap(colmap);

% contour
h_contour=contour(XData1,YData1,zdata2,...
    'LineColor',[0.48 0.06 0.92],...
    'LevelList',LevelList,...
    'Parent',axes1,...
    'ShowText','off');

yline(transect_Y_position,'Color','magenta','LineWidth',1,'LineStyle','--');

% xlabel
if strcmp(xunit,'km')
    xl1 = xlabel('(km) ','FontName','Arial');
elseif strcmp(xunit,'m') 
    xl1 = xlabel('(m)','FontName','Arial');
elseif strcmp(xunit,'latlon')
    xl1 = xlabel('Longitude','FontName','Arial');
end

xl1.Position(2) = -0.04;

% ylabel
if strcmp(yunit,'km')
    ylabel('(km)','FontName','Arial');
elseif strcmp(yunit,'m') 
    ylabel('(m)','FontName','Arial');
elseif strcmp(yunit,'latlon')
    ylabel('Latitude','FontName','Arial');
end

% title
title('Surface layer map','FontSize',12,'FontName','Arial', 'FontWeight', 'normal');





% colorbar

colorbar('Position',[0.64 0.35 0.05 0.5],...
    'FontSize',9);






% transect plot

dx=xmax-xmin;
dz=(zmax-zmin)/axisratio;

zinterval = zmax/5;

% plotwidth = 0.6; % 60% of page
plotheight = plotwidth*xsize/dx*dz/ysize;
% axes
axes2 = axes('Parent',figure1,...
    'YTick', zmin:zinterval:zmax,...
    'XTick', xmin:interval:xmax,...
    'XTickLabel', [],...
    'FontSize',9,...
    'FontName','Arial',...
    'CLim',[Cmin Cmax],...
    'Position',[0.1 0.12 plotwidth plotheight],...
    'Box','on');

xlim manual
ylim manual
xlim(axes2,[xmin xmax]);
ylim(axes2,[zmin zmax]);
hold on
pbaspect([dx dz 1])

set(gca, 'YDir','reverse')
set(gca, 'XTickLabel', [])

h_surf2=pcolor(XData2,YData2,CData2);
shading flat;

xline(core_X_position,'Color','magenta','LineWidth',1,'LineStyle','--');


% if strcmp(xunit,'km')
%     % xlabel
%     xlabel('X (km)','FontName','Arial');
% elseif strcmp(xunit,'m') 
%     % xlabel
%     xlabel('X (m)','FontName','Arial');
% elseif strcmp(xunit,'latlon')
%     % xlabel
%     xlabel('Longitude','FontName','Arial');
% end

if strcmp(zunit,'m')
    % ylabel
    ylabel('Depth (m)','FontName','Arial');
elseif strcmp(zunit,'cm') 
    % ylabel
    ylabel('Depth (cm)','FontName','Arial');
elseif strcmp(zunit,'mm')
    % ylabel
    ylabel('Depth (mm)','FontName','Arial');
else
    % ylabel
    ylabel('missing units','FontName','Arial');
end

% title
% title('Vertical transect','FontSize',12,'FontName','Arial', 'FontWeight', 'normal');

% use xlabel as title
xl2 = xlabel('Vertical transect','FontSize',12,'FontName','Arial','FontWeight', 'normal');




Cinterval = (Cmax-Cmin)/5;

% concentration profile plot
% axes
axes3 = axes('Parent',figure1,...
    'YTick', zmin:zinterval:zmax,...
    'XTick', Cmin:Cinterval:Cmax,...
    'XLim',[Cmin Cmax],...
    'XAxisLocation','top',...
    'YTickLabels', [],...
    'FontSize',9,...
    'FontName','Arial',...
    'Position',[0.64 0.12 0.3 plotheight],...
    'Box','on');

xlim manual
ylim manual
xlim(axes3,[Cmin Cmax]);
ylim(axes3,[zmin zmax]);

grid on

set(gca, 'YTickLabel', [])

hold on

coreXindex = round(size(CData2, 1)*core_X_position/xmax);

h_core=plot(CData2(coreXindex, :), YData2(coreXindex, :), 'LineWidth',1,'Color','Magenta');

xl3 = xlabel('Core Profile','FontSize',12,'FontName','Arial','FontWeight', 'normal');
xl3.Position(2) = 1.14*zmax;






% Title textbox

annotation(figure1,'textbox',...
    [0.0 0.94 1.0 0.035],...
    'HorizontalAlignment', 'center',...
    'String',title1,...
    'FontName','Arial',...
    'FontSize',12,...
    'FitBoxToText','on',...
    'LineStyle','none');



% date time textbox

h_annot=annotation(figure1,'textbox',...
    [0.0 0.045 1.0 0.035],...
    'HorizontalAlignment', 'center',...
    'String',annot_str,...
    'FontName','Arial',...
    'FontSize',12,...
    'FitBoxToText','on',...
    'LineStyle','none');



