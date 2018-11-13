function[h_scatter,h_contour,h_annot]= createfltplot(XData1,YData1,X,Y,Z,zdata2, annot_str, title1,Cmin,Cmax, colmap)
%CREATEFIGURE(ZDATA1,YDATA1,XDATA1,CDATA1,ZDATA2)
%  ZDATA1:  surface zdata
%  YDATA1:  surface ydata
%  XDATA1:  surface xdata
%  CDATA1:  surface cdata
%  ZDATA2:  contour z

%  MATLAB による自動生成日: 29-Mar-2013 19:17:25
%
% figure を作成
figure1 = figure('PaperSize',[20 10],...
    'Color',[1 1 1],...
    'Colormap',colmap,...
    'OuterPosition',[0 0 320 700]);

% axes を作成
axes1 = axes('Parent',figure1,...
    'YTick',[0 1 2 3 4 5 6 7 8 9],...
    'XTick',[0 1 2 3],...
    'FontSize',9,...
    'FontName','Arial',...
    'CLim',[Cmin Cmax],...
    'Box','on');
% Axes の X 軸の範囲を保持するために以下のラインのコメントを解除
%xlim(axes1,[-25 3125]);
 xlim(axes1,[0 3.1]);
% Axes の Y 軸の範囲を保持するために以下のラインのコメントを解除
%ylim(axes1,[-25 9525]);
 ylim(axes1,[0 9.5]);
hold(axes1,'all');
pbaspect([64 192 1])
%daspect([1 1 1])


% surface を作成
%surface('Parent',axes1,'ZData',ZData1,'YData',YData1,'XData',XData1,...
%    'LineStyle','none',...
%    'CData', CData1);

h_scatter=scatter(X,Y,8,Z,'fill');
%h_scatter=plot(X,Y,'ro');
%shading flat;
%shading interp;

% colorbar を作成
%colormap(colmap);
colorbar('peer',axes1);


% contour を作成
h_contour=contour(XData1,YData1,zdata2,...
    'LineColor',[0.48 0.06 0.92],...
    'LevelList',[0 0.5 1 3],...
    'Parent',axes1,...
    'ShowText','off');

% xlabel を作成
xlabel('X (km)','FontName','Arial');

% ylabel を作成
ylabel('Y (km)','FontName','Arial');

% title を作成
title(title1,'FontSize',12,'FontName','Arial Bold');


% textbox を作成
h_annot=annotation(figure1,'textbox',...
    [0.4 0.02 0.35 0.035],...
    'String',annot_str,...
    'FontName','Arial',...
    'FitBoxToText','on',...
    'LineStyle','none');



