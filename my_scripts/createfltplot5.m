function[h_scatter,h_contour,h_annot]= createfltplot5(XData1,YData1,X,Y,Z,zdata2, annot_str, title1,Cmin,Cmax, colmap, xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList,PointSize)
%CREATEFIGURE(ZDATA1,YDATA1,XDATA1,CDATA1,ZDATA2)
%  ZDATA1:  surface zdata
%  YDATA1:  surface ydata
%  XDATA1:  surface xdata
%  CDATA1:  surface cdata
%  ZDATA2:  contour z

figure1 = figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'Colormap',colmap,...
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
 yticks('auto')
hold(axes1,'on');
pbaspect([dx dy 1])


% surface
%surface('Parent',axes1,'ZData',ZData1,'YData',YData1,'XData',XData1,...
%    'LineStyle','none',...
%    'CData', CData1);


% contour
h_contour=contour(XData1,YData1,zdata2,...
    'LineColor',[0.48 0.06 0.92],...
    'LevelList',LevelList,...
    'Parent',axes1,...
    'ShowText','off');

%    'LevelList',[0 0.25 0.5 1 3 5],...
%    'LevelList',[-1 1],...
%    'LevelList',[0 0.5 1 3],...


h_scatter=scatter(X,Y,PointSize,Z,'fill'); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Point size
%h_scatter=plot(X,Y,'ro');
%shading flat;
%shading interp;

% colorbar
colormap(colmap);
colorbar('peer',axes1,...
    'FontSize',9);


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

% textbox
% textbox
h_annot=annotation(figure1,'textbox',...
    [0.0 0.01 0.9 0.035],...
    'HorizontalAlignment', 'center',...
    'String',annot_str,...
    'FontName','Arial',...
    'FontSize',11,...
    'FitBoxToText','on',...
    'LineStyle','none');

% 

