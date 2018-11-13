function[h_scatter,h_contour,h_annot]= createfltplot(XData1,YData1,X,Y,Z,zdata2, annot_str, title1,Cmin,Cmax, colmap)
%CREATEFIGURE(ZDATA1,YDATA1,XDATA1,CDATA1,ZDATA2)
%  ZDATA1:  surface zdata
%  YDATA1:  surface ydata
%  XDATA1:  surface xdata
%  CDATA1:  surface cdata
%  ZDATA2:  contour z

%  MATLAB �ɂ�鎩��������: 29-Mar-2013 19:17:25
%
% figure ���쐬
figure1 = figure('PaperSize',[20 10],...
    'Color',[1 1 1],...
    'Colormap',colmap,...
    'OuterPosition',[0 0 320 700]);

% axes ���쐬
axes1 = axes('Parent',figure1,...
    'YTick',[0 1 2 3 4 5 6 7 8 9],...
    'XTick',[0 1 2 3],...
    'FontSize',9,...
    'FontName','Arial',...
    'CLim',[Cmin Cmax],...
    'Box','on');
% Axes �� X ���͈̔͂�ێ����邽�߂Ɉȉ��̃��C���̃R�����g������
%xlim(axes1,[-25 3125]);
 xlim(axes1,[0 3.1]);
% Axes �� Y ���͈̔͂�ێ����邽�߂Ɉȉ��̃��C���̃R�����g������
%ylim(axes1,[-25 9525]);
 ylim(axes1,[0 9.5]);
hold(axes1,'all');
pbaspect([64 192 1])
%daspect([1 1 1])


% surface ���쐬
%surface('Parent',axes1,'ZData',ZData1,'YData',YData1,'XData',XData1,...
%    'LineStyle','none',...
%    'CData', CData1);

h_scatter=scatter(X,Y,8,Z,'fill');
%h_scatter=plot(X,Y,'ro');
%shading flat;
%shading interp;

% colorbar ���쐬
%colormap(colmap);
colorbar('peer',axes1);


% contour ���쐬
h_contour=contour(XData1,YData1,zdata2,...
    'LineColor',[0.48 0.06 0.92],...
    'LevelList',[0 0.5 1 3],...
    'Parent',axes1,...
    'ShowText','off');

% xlabel ���쐬
xlabel('X (km)','FontName','Arial');

% ylabel ���쐬
ylabel('Y (km)','FontName','Arial');

% title ���쐬
title(title1,'FontSize',12,'FontName','Arial Bold');


% textbox ���쐬
h_annot=annotation(figure1,'textbox',...
    [0.4 0.02 0.35 0.035],...
    'String',annot_str,...
    'FontName','Arial',...
    'FitBoxToText','on',...
    'LineStyle','none');



