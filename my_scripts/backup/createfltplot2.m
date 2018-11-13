function[h_scatter,h_contour,h_annot]= createfltplot2(XData1,YData1,X,Y,Z,zdata2, annot_str, title1,Cmin,Cmax, colmap, xsize,ysize,xmin,xmax,ymin,ymax)
%CREATEFIGURE(ZDATA1,YDATA1,XDATA1,CDATA1,ZDATA2)
%  ZDATA1:  surface zdata
%  YDATA1:  surface ydata
%  XDATA1:  surface xdata
%  CDATA1:  surface cdata
%  ZDATA2:  contour z

%  MATLAB ?½É‚ï¿½éŽ©?½?½?½?½?½?½?½?½: 29-Mar-2013 19:17:25
%
% figure ?½?½?½?¬
figure1 = figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'Colormap',colmap,...
    'GraphicsSmoothing','off',...
    'OuterPosition',[0 0 xsize ysize]);

dx=xmax-xmin;
dy=ymax-ymin;
for i=0:10
    interval = 10^i;
    if(min(dx/10^i,dy/10^i)<10)
        break
    end
end 

% axes ?½?½?½?¬
axes1 = axes('Parent',figure1,...
    'YTick', ymin:interval:ymax,...
    'XTick', xmin:interval:xmax,...
    'FontSize',9,...
    'FontName','Arial',...
    'CLim',[Cmin Cmax],...
    'Box','on');
%    'FontSmoothing','off',...

% Axes ?½?½ X ?½?½?½Ì”ÍˆÍ‚ï¿½ÛŽï¿½?½?½?½é‚½?½ß‚ÉˆÈ‰ï¿½?½Ì?¿½?½C?½?½?½ÌƒR?½?½?½?½?½g?½?½?½?½?½?½
%xlim(axes1,[-25 3125]);
 xlim(axes1,[xmin xmax]);
% Axes ?½?½ Y ?½?½?½Ì”ÍˆÍ‚ï¿½ÛŽï¿½?½?½?½é‚½?½ß‚ÉˆÈ‰ï¿½?½Ì?¿½?½C?½?½?½ÌƒR?½?½?½?½?½g?½?½?½?½?½?½
%ylim(axes1,[-25 9525]);
 ylim(axes1,[ymin ymax]);
hold(axes1,'all');
pbaspect([dx dy 1])


% surface ?½?½?½?¬
%surface('Parent',axes1,'ZData',ZData1,'YData',YData1,'XData',XData1,...
%    'LineStyle','none',...
%    'CData', CData1);

h_scatter=scatter(X,Y,3,Z,'fill'); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Point size
%h_scatter=plot(X,Y,'ro');
%shading flat;
%shading interp;

% colorbar ?½?½?½?¬
%colormap(colmap);
colorbar('peer',axes1,...
    'FontSize',9);


% contour ?½?½?½?¬
h_contour=contour(XData1,YData1,zdata2,...
    'LineColor',[0.48 0.06 0.92],...
    'LevelList',[-9 0.5],...
    'Parent',axes1,...
    'ShowText','off');

%    'LevelList',[0 0.25 0.5 1 3 5],...
%    'LevelList',[-1 1],...
%    'LevelList',[0 0.5 1 3],...

% xlabel ?½?½?½?¬
xlabel('X (km)','FontName','Arial');

% ylabel ?½?½?½?¬
ylabel('Y (km)','FontName','Arial');

% title ?½?½?½?¬
title(title1,'FontSize',16,'FontName','Arial Bold');


% textbox ?½?½?½?¬
h_annot=annotation(figure1,'textbox',...
    [0.4 0.02 0.35 0.035],...
    'String',annot_str,...
    'FontName','Arial',...
    'FontSize',16,...
    'FitBoxToText','on',...
    'LineStyle','none');



