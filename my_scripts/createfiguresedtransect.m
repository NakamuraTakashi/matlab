function[h_surf,h_surf2,h_contour,h_core1,h_core2,h_annot,axes1,axes2,axes3,axes4] ...
    = createfiguresedtransect(XData1,XData2,YData1,YData2,CData1,CData2,zdata2, ...
    annot_str, title1, units, Cmin,Cmax, colmap, marker_color,...
    xsize,ysize,xmin,xmax,ymin,ymax,zmin,zmax,xunit,yunit,zunit,axisratio,LevelList, ...
    transect_Y_position,core_X_position)

figure1 = figure('PaperSize',[30 60],...
    'Color',[1 1 1],...
    'Colormap',colmap,...
    'GraphicsSmoothing','off',...
    'Position',[0 0 xsize ysize]);

plotwidth = 150/xsize;


% heatmap

dx=xmax-xmin;
dy=(ymax-ymin);
for i=0:10
    interval = 10^i;
    if(min(dx/10^i,dy/10^i)<10)
        break
    end
end  

plotheight = plotwidth*xsize/dx*dy/ysize;


% dummy axes
dummy_axes12 = axes('Parent',figure1,...
    'XTick', xmin:interval:xmax,...
    'XTickLabel', [],...
    'YTickLabel', [],...
    'Position',[40/xsize 84/ysize plotwidth 500/ysize],...
    'Box','off',...
    'XGrid','on',...
    'XColor','none',...
    'YColor','none'...
    );
xlim(dummy_axes12,[xmin xmax]);
ylim(dummy_axes12,[ymin ymax]);
hold on


% axes
axes1 = axes('Parent',figure1,...
    'YTick', ymin:interval:ymax,...
    'XTick', xmin:interval:xmax,...
    'FontSize',12,...
    'FontName','Arial',...
    'CLim',[Cmin Cmax],...
    'Position',[40/xsize 235/ysize plotwidth plotheight],...
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

yline(transect_Y_position,'Color',marker_color,'LineWidth',1,'LineStyle','--');

scatter(core_X_position,transect_Y_position,200,marker_color,"x","LineWidth",1)
scatter(core_X_position,transect_Y_position,70,marker_color,"o","LineWidth",1)

text(core_X_position+0.15, repelem(transect_Y_position+0.2,length(core_X_position)), ["C1" "C2"],"Color",marker_color,"FontSize",12)

% xlabel
if strcmp(xunit,'km')
    xl1 = xlabel('[km]','FontName','Arial');
elseif strcmp(xunit,'m') 
    xl1 = xlabel('[m]','FontName','Arial');
elseif strcmp(xunit,'latlon')
    xl1 = xlabel('Longitude','FontName','Arial');
end

xl1.Position(2) = -0.05;
xl1.Position(1) = 1.6;


% ylabel
if strcmp(yunit,'km')
    yl1 = ylabel('[km]','FontName','Arial');
elseif strcmp(yunit,'m') 
    yl1 = ylabel('[m]','FontName','Arial');
elseif strcmp(yunit,'latlon')
    yl1 = ylabel('Latitude','FontName','Arial');
end

yl1.Position(1) = xmin - 0.1*(xmax-xmin);



% title
title('Surface layer map','FontSize',14,'FontName','Arial', 'FontWeight', 'normal');






% colorbar
cb1 = colorbar('Position',[205/xsize 420/ysize 15/xsize 250/ysize],'FontSize',12);

% Units textbox
if length(units) == 1 % if not fraction use tex iterpreter
    if units == "" % if no units
        interpreter = 'tex';
        units_tex = "";
    else
        interpreter = 'tex';
        units_tex = "["+units(1)+"]";
        % interpreter = 'latex';
        % units_tex = "$$\mathsf{ \left[ "+units(1)+" \right] }$$";
    end
elseif length(units) == 2 % if fraction use latex interpreter
    interpreter = 'latex';
    units_tex = "$$\mathsf{ \left[ \frac{"+units(1)+"}{"+units(2)+"} \right] }$$";
end
annotation(figure1,'textbox',...
    [280/xsize 420/ysize 250/xsize 15/ysize],...
    'HorizontalAlignment', 'center',...
    'VerticalAlignment', 'middle',...
    'String',units_tex,'Interpreter',interpreter,...
    'FontName','Arial',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'LineStyle','none',...
    'Rotation',90);





% transect plot

dx=xmax-xmin;
dz=(zmax-zmin)/axisratio;

zinterval = zmax/5;

% plotwidth = 0.6; % 60% of page
plotheight = plotwidth*xsize/dx*dz/ysize;

% dummy axes
dummy_axes24 = axes('Parent',figure1,...
    'YTick', zmin:zinterval:zmax,...
    'XTickLabel', [],...
    'YTickLabel', [],...
    'Position',[40/xsize 84/ysize 1.5*plotwidth plotheight],...
    'Box','off',...
    'YGrid','on',...
    'XColor','none',...
    'YColor','none'...
    );
xlim(dummy_axes24,[xmin xmax]);
ylim(dummy_axes24,[zmin zmax]);
hold on

% axes
axes2 = axes('Parent',figure1,...
    'YTick', zmin:zinterval:zmax,...
    'XTick', xmin:interval:xmax,...
    'XAxisLocation','top',...
    'XTickLabel', [],...
    'FontSize',12,...
    'FontName','Arial',...
    'CLim',[Cmin Cmax],...
    'Position',[40/xsize 84/ysize plotwidth plotheight],...
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

xline(core_X_position,'Color',marker_color,'LineWidth',1,'LineStyle','--');
text(core_X_position, repelem(-0.6,length(core_X_position)), ["C1" "C2"],"Color",marker_color,"FontSize",12,"HorizontalAlignment","center")


% if strcmp(xunit,'km')
%     % xlabel
%     xlabel('X [km]','FontName','Arial');
% elseif strcmp(xunit,'m') 
%     % xlabel
%     xlabel('X [m]','FontName','Arial');
% elseif strcmp(xunit,'latlon')
%     % xlabel
%     xlabel('Longitude','FontName','Arial');
% end

if strcmp(zunit,'m')
    % ylabel
    yl1 = ylabel('Depth [m]','FontName','Arial');
elseif strcmp(zunit,'cm') 
    % ylabel
    yl1 = ylabel('Depth [cm]','FontName','Arial');
elseif strcmp(zunit,'mm')
    % ylabel
    yl1 = ylabel('Depth [mm]','FontName','Arial');
else
    % ylabel
    yl1 = ylabel('missing units','FontName','Arial');
end

% title
% title('Vertical transect','FontSize',12,'FontName','Arial', 'FontWeight', 'normal');

% use xlabel as title
xl2 = xlabel('Vertical transect','FontSize',14,'FontName','Arial','FontWeight', 'normal');
xl2.Position(2) = 1.15*zmax;

yl1.Position(1) = xmin - 0.1*(xmax-xmin);



coreXindex = round(size(CData2, 1)*core_X_position/xmax);

Cinterval = (Cmax-Cmin)/5;


% dummy axes
dummy_axes34 = axes('Parent',figure1,...
    'XTick', Cmin:Cinterval:Cmax,...
    'XTickLabel', [],...
    'YTickLabel', [],...
    'Position',[205/xsize 84/ysize 90/xsize 1.5*plotheight],...
    'Box','on',...
    'XGrid','on',...
    'XColor','none',...
    'YColor','none'...
    );
xlim(dummy_axes34,[Cmin Cmax]);
ylim(dummy_axes34,[zmin zmax]);
hold on


% concentration profile plot 1
% background colorbar
% colorbar('Position',[230/xsize 235/ysize 80/xsize plotheight],...
colorbar('Position',[205/xsize 235/ysize 90/xsize plotheight],...
    'TickLabels',[],...
    'Orientation','Horizontal' ...
    );
% axes
axes3 = axes('Parent',figure1,...
    'YTick', zmin:zinterval:zmax,...
    'XTick', Cmin:Cinterval:Cmax,...
    'XLim',[Cmin Cmax],...
    'XAxisLocation','top',...
    'FontSize',12,...
    'FontName','Arial',...
    'Position',[205/xsize 235/ysize 90/xsize plotheight],... % 'Position',[230/xsize 235/ysize 80/xsize plotheight],...
    'Box','on', ...
    'Color',[1 1 1 0.8]);

xlim manual
ylim manual
xlim(axes3,[Cmin Cmax]);
ylim(axes3,[zmin zmax]);

% yl3 = ylabel('Depth [cm]','FontSize',14,'FontName','Arial','FontWeight', 'normal');
% yl3.Position(1) = Cmin - 0.22*(Cmax-Cmin);

grid on

set(gca, 'YTickLabel', [])

hold on

h_core1=plot(CData2(coreXindex(2), :), YData2(coreXindex(2), :), 'LineWidth',1,'Color',marker_color);

xl3 = xlabel('Core 1','FontSize',14,'FontName','Arial','FontWeight', 'normal');
xl3.Position(2) = 1.15*zmax;

hold off





% concentration profile plot 2
% background colorbar
% colorbar('Position',[230/xsize 84/ysize 80/xsize plotheight],...
colorbar('Position',[205/xsize 84/ysize 90/xsize plotheight],...
    'TickLabels',[],...
    'Orientation','Horizontal' ...
    );
% axes
axes4 = axes('Parent',figure1,...
    'YTick', zmin:zinterval:zmax,...
    'XTick', Cmin:Cinterval:Cmax,...
    'XLim',[Cmin Cmax],... 
    'XAxisLocation','top',...
    'XTickLabels', [],...
    'FontSize',12,...
    'FontName','Arial',...
    'Position',[205/xsize 84/ysize 90/xsize plotheight],... %'Position',[230/xsize 84/ysize 80/xsize plotheight],...
    'Box','on', ...
    'Color',[1 1 1 0.8]);

xlim manual
ylim manual
xlim(axes4,[Cmin Cmax]);
ylim(axes4,[zmin zmax]);

% yl4 = ylabel('Depth [cm]','FontSize',14,'FontName','Arial','FontWeight', 'normal');
% yl4.Position(1) = Cmin - 0.22*(Cmax-Cmin);

grid on

set(gca, 'YTickLabel', [])

hold on

h_core2=plot(CData2(coreXindex(2), :), YData2(coreXindex(2), :), 'LineWidth',1,'Color',marker_color);

xl4 = xlabel('Core 2','FontSize',14,'FontName','Arial','FontWeight', 'normal');
xl4.Position(2) = 1.15*zmax;






% Title textbox

annotation(figure1,'textbox',...
    [0.0 725/ysize 1.0 0.035],... % [0.0 735/ysize 1.0 0.035],...
    'HorizontalAlignment', 'center',...
    'VerticalAlignment', 'middle',...
    'String',title1,...
    'FontName','Arial',...
    'FontSize',16,...
    'FitBoxToText','on',...
    'LineStyle','none');



% date time textbox

h_annot=annotation(figure1,'textbox',...
    [0.0 0.02 1.0 0.035],...
    'HorizontalAlignment', 'center',...
    'String',annot_str,...
    'FontName','Arial',...
    'FontSize',14,...
    'FitBoxToText','on',...
    'LineStyle','none');




