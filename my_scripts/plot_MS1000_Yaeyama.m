%
% === Copyright (c) 2022 Takashi NAKAMURA  =====

CASE = 2;
out_dirstr = 'output/figs_Y2_MS1000_CBL';
fname_prefix='Y2_MS1000_CBL_';
fileID = fopen([out_dirstr,'/Y2_BleachingRatio.txt'],'w');

MODE = 1; %  1: Coral coverage & Bleaching, 2: Number of COTS & coral damage by COTS

[status, msg] = mkdir( out_dirstr )
%% 
excelfile='E:\Documents\Dropbox\Sekisei_Data_personal\モニタリングサイト1000\モニタリングサイト1000データ(2003-2020)\提供データ_2003-2020モニ1000サンゴデータ_サイト11-17.xlsx';
C1 = readcell(excelfile,'Sheet','調査結果_サイト11ｰ17');
C2 = readcell(excelfile,'Sheet','調査地点基礎情報_サイト11ｰ17');
%% 
ImaxC2 = size(C2,1);
iLat_deg=8;  iLat_min=9;  iLat_sec=10;
iLon_deg=12; iLon_min=13; iLon_sec=14;
iArea2=2; iSite2=5;

lat=zeros(ImaxC2,1);
lon=zeros(ImaxC2,1);

for i=2:ImaxC2
%% 

    lat(i)=C2{i,iLat_deg}+C2{i,iLat_min}/60+C2{i,iLat_sec}/3600;
    lon(i)=C2{i,iLon_deg}+C2{i,iLon_min}/60+C2{i,iLon_sec}/3600;
end

data2=rand(ImaxC2-1,1)*100;

[x2,y2,utmzone] = deg2utm(lat,lon);

%% 
ImaxC1 = size(C1,1);
iYear=1; iArea1=3; iSite1=5;iCov=10; iBr1=11; iNcots=19; iPcots=22; 
% yr_all=C1(2:ImaxC1,1);
% br_all=C1(2:ImaxC1,11);
%% 

if CASE == 1      % YAEYAMA1
% ----- YAEYAMA1 -----------
    grd='F:\COAWST_DATA\Yaeyama\Yaeyama1\Grid\Yaeyama1_grd_v10.nc';
    unit = 'km'; % 'm', 'latlon'

% ----- YAEYAMA2 ------------
elseif CASE == 2  % YAEYAMA2
    grd='F:/COAWST_DATA/Yaeyama/Yaeyama2/Grid/Yaeyama2_grd_v11.2.nc';
    unit = 'km'; % 'm', 'latlon'

% ----- YAEYAMA2 ------------
elseif CASE == 3  % YAEYAMA3 
    grd='F:/COAWST_DATA/Yaeyama/Yaeyama3/Grid/Yaeyama3_grd_v12.2.nc';
    unit = 'km'; % 'm', 'latlon'
end
%
% ---------------------------
h          = ncread(grd,'h');

if strcmp(unit,'latlon')
    y_rho    = ncread(grd,'lat_rho');
    x_rho    = ncread(grd,'lon_rho');
elseif strcmp(unit,'m')
    x_rho      = ncread(grd,'x_rho');
    y_rho      = ncread(grd,'y_rho');
elseif strcmp(unit,'km')
    x_rho      = ncread(grd,'x_rho');
    y_rho      = ncread(grd,'y_rho');
    xr_min = min(min(x_rho));
    yr_min = min(min(y_rho));
    x_rho=(x_rho-xr_min)/1000; % m->km
    y_rho=(y_rho-yr_min)/1000; % m->km

    x2=(x2-xr_min)/1000; % m->km
    y2=(y2-yr_min)/1000; % m->km

end

[Im, Jm] = size(h);
c=NaN(Im,Jm);
% LevelList = [-1 1 10];
LevelList = [-1 1 20];


scale=2;
s_interval=3;
Vmax = 0.6;

% Down sampling
x_rho2=x_rho(1:s_interval:Im,1:s_interval:Jm);
y_rho2=y_rho(1:s_interval:Im,1:s_interval:Jm);
ubar3=zeros(size(x_rho2));
vbar3=zeros(size(x_rho2));
date_str=''; %strcat(datestr(date,31),'  ',LOCAL_TIME);

starting_date = datenum(2000,1,1,0,0,0);

% My color map
load('MyColormaps')
% colmap6=superjet(20,'wcZbtgyorWq');
colmap6=superjet(21,'ZbtgyorW');

for yyyy=2003:2020
    
    close all

    %% Read data
    clear x y data2 data1
    k=1;
    for i=2:ImaxC1
        for j=2:ImaxC2
            if C1{i,iYear}==yyyy && ...
               strcmp(num2str(C1{i,iArea1}), num2str(C2{j,iArea2})) && ...
               strcmp(num2str(C1{i,iSite1}), num2str(C2{j,iSite2})) % && ...
%                strcmp(C1{i,iBr1},'-')==0

                x(k)=x2(j);
                y(k)=y2(j);

                if MODE ==1

                    if     strcmp(C1{i,iCov},'<5')
                        data1(k)=2.5;
                    elseif strcmp(C1{i,iCov},'<1')
                        data1(k)=0.5;
                    elseif strcmp(C1{i,iCov},'>90')
                        data1(k)=95;
                    elseif strcmp(C1{i,iCov},'-')
                        data1(k)=0;
                    else
                        data1(k)=C1{i,iCov};
                    end
    
    
                    if     strcmp(C1{i,iBr1},'<5')
                        data2(k)=2.5;
                    elseif strcmp(C1{i,iBr1},'<1')
                        data2(k)=0.5;
                    elseif strcmp(C1{i,iBr1},'>90')
                        data2(k)=95;
                    elseif strcmp(C1{i,iBr1},'-')
                        data2(k)=0;
                    else
                        data2(k)=C1{i,iBr1};
                    end

                elseif MODE == 2
                    data1(k)=C1{i,iNcots};

                    if     strcmp(C1{i,iPcots},'<5')
                        data2(k)=2.5;
                    elseif strcmp(C1{i,iPcots},'<1')
                        data2(k)=0.5;
                    elseif strcmp(C1{i,iPcots},'不明')
                        data2(k)=0;
                    elseif strcmp(C1{i,iPcots},'-')
                        data2(k)=0;
                    else
                        data2(k)=C1{i,iPcots};
                    end


                end


                k=k+1;
                break
            end
        
        end
    
    end

    Ntot=size(x,2);
    N10=size(data2(data2>=10),2);
    N20=size(data2(data2>=20),2);
    N30=size(data2(data2>=30),2);
    N40=size(data2(data2>=40),2);
    N50=size(data2(data2>=50),2);
    N60=size(data2(data2>=60),2);
    N70=size(data2(data2>=70),2);
    N80=size(data2(data2>=80),2);
    N90=size(data2(data2>=90),2);

    fprintf(fileID,'%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d\n',yyyy,Ntot,N10,N20,N30,N40,N50,N60,N70,N80,N90);

    %%

    x(k+1)=-10; y(k+1)=-10; x(k+2)=-10; y(k+2)=-10; 
    if MODE ==1
        data1(k+1)=0;   data2(k+1)=0;
        data1(k+2)=100; data2(k+2)=100;
        cmin=-2.5; cmax=102.5; colmap=colmap6;
        bsizemax=20;
        titlestr='Coral coverage & bleaching ratio in ';
        legendstr ='Coral coverage (%)';
    elseif MODE ==2
        data1(k+1)=0;   data2(k+1)=0;
        data1(k+2)=150; data2(k+2)=100;
        cmin=-2.5; cmax=102.5; colmap=colmap6;
        bsizemax=30;
        titlestr='Number of COTS & Percent damage of corals by COTS in ';
        legendstr ='Number of COTS';
    else
        data1(k+1)=0;   data2(k+1)=0;
        data1(k+2)=100; data2(k+2)=100;
        cmin=-2.5; cmax=102.5; colmap=colmap6;
        bsizemax=20;
        titlestr='Data in ';
        legendstr ='Data (%)';
    end

    title=[titlestr, num2str(yyyy)];  

    if CASE == 1      % YAEYAMA1
        xmin=min(min(x_rho))-1;   xmax=max(max(x_rho))+1;  ymin=min(min(y_rho))-1;   ymax=max(max(y_rho))+1;
        xsize=640; ysize=520;
    elseif CASE == 2  % YAEYAMA2
    %     xmin=min(min(x_rho))-0.3;   xmax=max(max(x_rho))+0.3;  ymin=min(min(y_rho))-0.3;   ymax=max(max(y_rho))+0.3;
    %     xsize=620; ysize=550;
        xmin=5;   xmax=80;  ymin=25;   ymax=75;
%         xsize=800; ysize=520;
        xsize=1000; ysize=520;
    elseif CASE == 3  % YAEYAMA3
        xmin=min(min(x_rho))-0.1;   xmax=max(max(x_rho))+0.1;  ymin=min(min(y_rho))-0.1;   ymax=max(max(y_rho))+0.1;
        xsize=640; ysize=520;
    elseif CASE == 4  % SHIRAHO_REEF
        xmin=min(min(x_rho))-0.05;   xmax=max(max(x_rho))+0.05;  ymin=min(min(y_rho))-0.05;   ymax=max(max(y_rho))+0.05;
    %     xsize=500; ysize=650; % for SHIRAHO zoom
    %     xsize=250; ysize=500; % for SHIRAHO for Publish
        xsize=240; ysize=500; % for SHIRAHO for Animation
    else
        xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
        xsize=520; ysize=520;   
    end

    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,c,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);

%     plot(x,y,'LineStyle','none','Marker','o','MarkerFaceColor','red',...
%              'MarkerEdgeColor', 'k', 'MarkerSize',8)
%     s=scatter(x,y,80,br,'fill');
    
%     s=bubblechart(x,y,cov,br,'MarkerFaceAlpha',1.0);
    s=bubblechart(x,y,data1,data2,'MarkerFaceAlpha',1.0);
    s.LineWidth = 0.6;
    s.MarkerEdgeColor = 'k';
    
%     bubblesize([1 20])
    bubblesize([1 bsizemax])
    bubblelegend(legendstr,'Location','eastoutside')

    drawnow

    fname = [fname_prefix, num2str(yyyy) ];

    hgexport(figure(1), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

end
fclose(fileID);