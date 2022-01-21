function[h_quiver,h_surf,h_contour,h_annot]=  createvplot7(XData1,YData1,CData1,XData2,YData2,UData2,VData2,zdata2,scale,annot_str, title1,Cmin,Cmax, colmap, xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList)
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
    'Position',[0 0 xsize ysize]);

dx=xmax-xmin;
dy=ymax-ymin;
for i=0:10
    interval = 10^i;
    if(min(dx/10^i,dy/10^i)<10)
        break
    end
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
%xlim(axes1,[-25 3125]);
 xlim(axes1,[xmin xmax]);
 xticks('auto')
% Axes
%ylim(axes1,[-25 9525]);
 ylim(axes1,[ymin ymax]);
% ylim auto
yticks('auto')
hold(axes1,'all');
pbaspect([dx dy 1])


% surface

% colorbar
%colormap(colmap);
colorbar('peer',axes1,...
    'FontSize',9);

h_surf=pcolor(XData1,YData1,CData1);
shading flat;

% contour
h_contour=contour(XData1,YData1,zdata2,...
    'LineColor',[0.48 0.06 0.92],...
    'LevelList',LevelList,...
    'Parent',axes1,...
    'ShowText','off');

%    'LevelList',[0 0.25 0.5 1 3 5],...
%    'LevelList',[-1 1],...
%    'LevelList',[0 0.5 1 3],...

% quiver
U=UData2*scale;
V=VData2*scale;
h_quiver=quiver(XData2,YData2,U,V,...
    'Color', 'k',...
    'AutoScale','off');

if strcmp(unit,'km')
    % xlabel
    xlabel('X (km)','FontName','Arial');
    % ylabel
    ylabel('Y (km)','FontName','Arial');
elseif strcmp(unit,'m') 
    % xlabel
    xlabel('X (m)','FontName','Arial');
    % ylabel
    ylabel('Y (m)','FontName','Arial');
elseif strcmp(unit,'latlon')
    % xlabel
    xlabel('Longitude','FontName','Arial');
    % ylabel
    ylabel('Latitude','FontName','Arial');
end

% title
title(title1,'FontSize',12,'FontName','Arial', 'FontWeight', 'normal');

% colorbar
%colormap(colmap);
%colorbar('peer',axes1);

% textbox
h_annot=annotation(figure1,'textbox',...
    [0.0 0.015 0.9 0.035],...
    'HorizontalAlignment', 'center',...
    'String',annot_str,...
    'FontName','Arial',...
    'FontSize',11,...
    'FitBoxToText','on',...
    'LineStyle','none');



