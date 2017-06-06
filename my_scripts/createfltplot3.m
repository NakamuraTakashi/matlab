function[h_scatter1,h_scatter2,h_contour,h_annot]= createfltplot3(XData1,YData1,X1,Y1,Z1,X2,Y2,Z2,zdata2, annot_str, title1,Cmin,Cmax, colmap, xsize,ysize,xmin,xmax,ymin,ymax)
%CREATEFIGURE(ZDATA1,YDATA1,XDATA1,CDATA1,ZDATA2)
%  ZDATA1:  surface zdata
%  YDATA1:  surface ydata
%  XDATA1:  surface xdata
%  CDATA1:  surface cdata
%  ZDATA2:  contour z

%  MATLAB �ɂ�鎩��������: 29-Mar-2013 19:17:25
%
% figure ���쐬
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

% axes ���쐬
axes1 = axes('Parent',figure1,...
    'YTick', ymin:interval:ymax,...
    'XTick', xmin:interval:xmax,...
    'FontSize',9,...
    'FontName','Arial',...
    'CLim',[Cmin Cmax],...
    'Box','on');
%    'FontSmoothing','off',...

% Axes �� X ���͈̔͂�ێ����邽�߂Ɉȉ��̃��C���̃R�����g������
%xlim(axes1,[-25 3125]);
 xlim(axes1,[xmin xmax]);
% Axes �� Y ���͈̔͂�ێ����邽�߂Ɉȉ��̃��C���̃R�����g������
%ylim(axes1,[-25 9525]);
 ylim(axes1,[ymin ymax]);
hold(axes1,'all');
pbaspect([dx dy 1])


% surface ���쐬
%surface('Parent',axes1,'ZData',ZData1,'YData',YData1,'XData',XData1,...
%    'LineStyle','none',...
%    'CData', CData1);

h_scatter1=scatter(X1,Y1,1,Z1,'filled'); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Point size
%h_scatter=plot(X,Y,'ro');
%shading flat;
%shading interp;

h_scatter2=scatter(X2,Y2,50,Z2*100,'filled','+'); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Point size
%h_scatter2=scatter(X2,Y2,10,'filled'); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Point size

% colorbar ���쐬
%colormap(colmap);
colorbar('peer',axes1,...
    'FontSize',9);


% contour ���쐬
h_contour=contour(XData1,YData1,zdata2,...
    'LineColor',[0.48 0.06 0.92],...
    'LevelList',[-1 1],...
    'Parent',axes1,...
    'ShowText','off');

%    'LevelList',[0 0.25 0.5 1 3 5],...
%    'LevelList',[-1 1],...
%    'LevelList',[0 0.5 1 3],...

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
    'FontSize',9,...
    'FitBoxToText','on',...
    'LineStyle','none');



