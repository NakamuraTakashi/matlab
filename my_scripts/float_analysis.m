%
% === ver 2016/05/09   Copyright (c) 2016 Takashi NAKAMURA  =====
%                for MATLAB R2015a,b  

% UTM_zone = '51 R';          % UTM zone, e.g. '30 T', '32 T', '11 S', '28 R', '15 S', '51 R'
% starting_date=datenum(2000,1,1,0,0,0);% for YAEYAMA1
starting_date=datenum(2000,1,1,0,0,0);

id=9;

LOCAL_TIME='(UTC)';
%LOCAL_TIME='(JST)';
%LOCAL_TIME='(UTC+9)';
%LOCAL_TIME='';

grd='D:/ROMS/Yaeyama/Data/Yaeyama2_grd_v9.3.nc';
flt='O:\ROMS\Yaeyama\Y2v7off\Yaeyama2_flt_130601_6.nc';

flt2='O:\ROMS\Yaeyama\Y2v7off\Nx1_3\cots_larvae_01.nc';
% flt2='O:\ROMS\Yaeyama\Y2v7off\Nx0.25_3\cots_larvae_01.nc';
% flt2='O:\ROMS\Yaeyama\Y2v7off\Nx0.5\cots_larvae_01.nc';
% flt2='O:\ROMS\Yaeyama\Y2v7off\Nx0.75\cots_larvae_01.nc';
% flt2='O:\ROMS\Yaeyama\Y2v7off\Nx2\cots_larvae_01.nc';

h          = ncread(grd,'h');
p_coral    = ncread(grd,'p_coral');
%p_seagrass = ncread(grd,'p_seagrass');
%lat_rho    = ncread(grd,'lat_rho');
%lon_rho    = ncread(grd,'lon_rho');
x_rho      = ncread(grd,'x_rho');
y_rho      = ncread(grd,'y_rho');

[Im,Jm] = size(h);
x_corner_m = min(min(x_rho));
y_corner_m = min(min(y_rho));
%c(1:Im,1:Jm)=0;
x_rho=(x_rho - x_corner_m)/1000; % m->km
y_rho=(y_rho - y_corner_m)/1000; % m->km

k=0;
i=1;

xmin=0;   xmax=max(max(x_rho));  ymin=0;   ymax=max(max(y_rho));

xsize=Im*2+100; ysize=Jm*2+100;  % for YAEYAM1
%xsize=290; ysize=680; % for SHIRAHO
%xsize=500; ysize=650; % for SHIRAHO zoom
%% 


% %% 
% 
% close all
%% 
clear xfloat yfloat lonfloat latfloat

%time = nc_varget(his,'ocean_time',[i],[1]);
time = ncread(flt,'ocean_time');
% imax=length(time);
imax=1705;

%---------------------------------------------------------------------
%  Read in floats data. 
%---------------------------------------------------------------------

% spherical=ncread(his,'spherical');
spherical=true;


if (spherical),
    lonfloat=ncread(flt,'lon',[1 i],[Inf 1]);
    latfloat=ncread(flt,'lat',[1 i],[Inf 1]);

    [xfloat, yfloat, UTM_zone] = deg2utm(latfloat,lonfloat);

    xfloat=(xfloat - x_corner_m)/1000; % m->km
    yfloat=(yfloat - y_corner_m)/1000; % m->km
else  
    xfloat=ncread(flt,'x',[1 i],[Inf 1]).*0.001;
    yfloat=ncread(flt,'y',[1 i],[Inf 1]).*0.001;
    
end

num_float=size(lonfloat,1);
ifloat = 1:num_float;
cfloat=zeros(size(xfloat));

%  Status of COTS larvae. 
%     0: Not started
%     1: Peragic stage1; 
%     2: Peragic stage2; 
%     3: Peragic stage3; 
%     4: settled
%     5: out

stat_end=ncread(flt2,'status_COTS_larvae',[1 imax],[Inf 1]);
%% 

num_end=ncread(flt2,'num_COTS_larvae',[1 imax],[Inf 1]); 
%% 
%COTS_LAR(ng)%num(i) = COTSdens(xi,eta) * dx * dy * num_egg * p_ferit
% num_egg = 5.0e7/30.0d0;
% p_ferit = 0.1;         
% dx  = 300;
% dy  = 300;
% COTSdensini=2.0e-4;
% 
% ini_num = COTSdensini* dx * dy * num_egg * p_ferit;

% mfloat2=mfloat/ini_num*100;

iset=find(stat_end==4 & num_end>0);
end_num_set=num_end(iset);
%% 
% 
% ini_num_set=zeros(size(end_num_set));
% lons=zeros(size(end_num_set));
% lats=zeros(size(end_num_set));
% lone=zeros(size(end_num_set));
% late=zeros(size(end_num_set));
% 
% k=1;
% for j=iset.'
%     stat_tser=ncread(flt2,'status_COTS_larvae',[j 1],[1 imax]);
%     for i=1:imax-1
%         if (stat_tser(i)==0 && stat_tser(i+1)==1)
%             ini_num_set(k)=ncread(flt2,'num_COTS_larvae',[j i+1],[1 1]);
%             lons(k)=ncread(flt,'lon',[j i+1],[1 1]);
%             lats(k)=ncread(flt,'lat',[j i+1],[1 1]);
%         end
%         if (stat_tser(i)==3 && stat_tser(i+1)==4)
%             lone(k)=ncread(flt,'lon',[j i+1],[1 1]);
%             late(k)=ncread(flt,'lat',[j i+1],[1 1]);
%             break
%         end
%     end
%     k=k+1;
% end
% %% 
% 
% [xs, ys, UTM_zone] = deg2utm(lats,lons);
% [xe, ye, UTM_zone] = deg2utm(late,lone);
% %% 
% xs=(xs - x_corner_m)/1000; % m->km
% xe=(xe - x_corner_m)/1000; % m->km
% ys=(ys - y_corner_m)/1000; % m->km
% ye=(ye - y_corner_m)/1000; % m->km
% %% Save variables 
% save('ini_num_set.mat','ini_num_set');
% save('xs.mat','xs');
% save('xe.mat','xe');
% save('ys.mat','ys');
% save('ye.mat','ye');

%% Load variables

load('ini_num_set.mat','ini_num_set');
load('xs.mat','xs');
load('xe.mat','xe');
load('ys.mat','ys');
load('ye.mat','ye');

%% 

mort=end_num_set./ini_num_set*100;
mean(mort)
ini_sorted=sort(ini_num_set,'descend');
end_sorted=sort(end_num_set,'descend');
mort_sorted=sort(mort,'descend');
mean(mort_sorted(1:100))
%% 
% numel(mfloat2(sfloat==4))
% idflt=find(stat_end==4 & mfloat2>25);
% numflt=numel(idflt)
%% Plot

% xftmp=zeros(size(stat_tser));
% yftmp=zeros(size(stat_tser));
figure1 = figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'Colormap',jet(128),...
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

% axes 
axes1 = axes('Parent',figure1,...
    'YTick', ymin:interval:ymax,...
    'XTick', xmin:interval:xmax,...
    'FontSize',9,...
    'FontName','Arial',...
    'Box','on');
%    'FontSmoothing','off',...
%    'CLim',[Cmin Cmax],...

% Axes 
%xlim(axes1,[-25 3125]);
 xlim(axes1,[xmin xmax]);
% Axes 
%ylim(axes1,[-25 9525]);
 ylim(axes1,[ymin ymax]);
hold(axes1,'all');
pbaspect([dx dy 1])
% colorbar('peer',axes1,...
%     'FontSize',9);


% contour 
h_contour=contour(x_rho,y_rho,h,...
    'LineColor',[0.48 0.06 0.92],...
    'LevelList',[-1 1],...
    'Parent',axes1,...
    'ShowText','off');

%    'LevelList',[0 0.25 0.5 1 3 5],...
%    'LevelList',[-1 1],...
%    'LevelList',[0 0.5 1 3],...

% xlabel 
xlabel('X (km)','FontName','Arial');

% ylabel ?½?½?½?¬
ylabel('Y (km)','FontName','Arial');

% title ?½?½?½?¬
title('Trajectory, top 20','FontSize',12,'FontName','Arial Bold');


% textbox ?½?½?½?¬
h_annot=annotation(figure1,'textbox',...
    [0.4 0.02 0.35 0.035],...
    'FontName','Arial',...
    'FontSize',9,...
    'FitBoxToText','on',...
    'LineStyle','none');
%     'String',annot_str,...
cmap=jet(20);
k=1;
m=1;
for j=iset.'
    if(mort(k)>=mort_sorted(20))
        if (spherical),
            lonf=ncread(flt,'lon',[j 1],[1 imax]);
            latf=ncread(flt,'lat',[j 1],[1 imax]);
            stat_tser=ncread(flt2,'status_COTS_larvae',[j 1],[1 imax]);
            lonf(stat_tser==4)=NaN;
            latf(stat_tser==4)=NaN;

            [xftmp, yftmp, UTM_zone] = deg2utm(latf,lonf);

            xf=(xftmp - x_corner_m)/1000; % m->km
            yf=(yftmp - y_corner_m)/1000; % m->km
            plot(xf,yf,'Color',cmap(m,:))

        else  
            xf=ncread(flt,'x',[j 1],[1 imax]).*0.001;
            yf=ncread(flt,'y',[j 1],[1 imax]).*0.001;
        end
        scatter(xs(k),ys(k),30,'o','MarkerEdgeColor',cmap(m,:))
        scatter(xe(k),ye(k),30,'x','MarkerEdgeColor',cmap(m,:))
        m=m+1;
    end
    k=k+1;
end





