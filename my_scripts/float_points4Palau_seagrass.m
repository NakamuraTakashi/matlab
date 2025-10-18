%
% === ver 2025/07/14 Copyright (c) 2015-2025 Takashi NAKAMURA  =====
%                

grd='D:/COAWST_DATA/Palau/Palau2/Grid/Palau2_grd_v1.1.nc';
polyfile = 'F:/Dropbox/Projects/Palau/Palau_personal/model/Seagrass_polygons.shp';
MAX_iflt = 1000;
Nz=30;
h          = ncread(grd,'h');
lat_rho    = ncread(grd,'lat_rho');
lon_rho    = ncread(grd,'lon_rho');
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
resol = 100;  % 1/3/5/...

xmin=0;   xmax=max(max(x_rho));  ymin=0;   ymax=max(max(y_rho));

xsize=Im*2+100; ysize=Jm*2+100;  % for YAEYAM1
%xsize=290; ysize=680; % for SHIRAHO
%xsize=500; ysize=650; % for SHIRAHO zoom



close all

shallow_area =  ones(size(h));
shallow_area(h<-0.2) = 0;
shallow_area(h>5)   = 0;

imshow(shallow_area)
axis on
colorbar
[ix,iy]=find(shallow_area == 1);

%% 
S = shaperead(polyfile);
n_poly = size(S,1);
for i=1:n_poly
    S(i).Lat = rmmissing(S(i).Y);
    S(i).Lon = rmmissing(S(i).X);
    S(i).y_km = rmmissing(S(i).Y);
    S(i).x_km = rmmissing(S(i).X);
end
% Sort by id field
S2=S;
for i=1:n_poly-1
    for j=i+1:n_poly
        if S(i).id >S(j).id
            S2(i)=S(i);
            S(i)=S(j);
            S(j)=S2(i);
        end
    end
end
for i=1:n_poly
    [S(i).x_km, S(i).y_km, UTM_zone] = deg2utm(S(i).Lat,S(i).Lon);
    S(i).x_km=(S(i).x_km - x_corner_m)/1000; % m->km
    S(i).y_km=(S(i).y_km - y_corner_m)/1000; % m->km
end

%% Seek release points inside each polygon
N_float = MAX_iflt*n_poly;
lonfloat_ini = zeros(1, N_float);
latfloat_ini = zeros(1, N_float);
dfloat_ini = zeros(1, N_float);

for i=1:n_poly
    iflt=0;
    min_Lat=min(S(i).Lat);
    max_Lat=max(S(i).Lat);
    min_Lon=min(S(i).Lon);
    max_Lon=max(S(i).Lon);
    while iflt < MAX_iflt
        lat0=min_Lat + rand(1,1)*(max_Lat-min_Lat);
        lon0=min_Lon + rand(1,1)*(max_Lon-min_Lon);
        if (inpolygon(lon0, lat0, S(i).Lon, S(i).Lat))
            d=(lat_rho-lat0).*(lat_rho-lat0)+(lon_rho-lon0).*(lon_rho-lon0);
            [M,Idx]=min(d(:));
            [ii, jj] = ind2sub(size(d), Idx);
            if(shallow_area(ii,jj))
                iflt=iflt+1;
                lonfloat_ini(iflt+MAX_iflt*(i-1))=lon0;
                latfloat_ini(iflt+MAX_iflt*(i-1))=lat0;
                dfloat_ini(iflt+MAX_iflt*(i-1)) = Nz; % floats release at surface
            end
        end
    end
end

%% 
% % for i=1:size(ix)
% %     latfloat_ini(i)=lat_rho(ix(i),iy(i));
% %     lonfloat_ini(i)=lon_rho(ix(i),iy(i));
% %     dfloat_ini(i)=h(ix(i),iy(i)).*-1;
% % end
% N_float = 0;
% 
% lat_c = 7.063205556;
% lon_c = 134.3006667;
% 
% d_lat = 0.015/2/resol;
% d_lon = 0.015/2/resol;
% 
% lat_s = lat_c - d_lat*floor(resol/2);
% lon_s = lon_c - d_lon*floor(resol/2);
% 
% for j=1:resol
%     for k=1:resol
%         N_float = N_float+1;
%         latfloat_ini(N_float)=lat_s + d_lat*(j-1);
%         lonfloat_ini(N_float)=lon_s + d_lon*(k-1);
% %           dfloat_ini(N_float)=h(ix(i),iy(i)).*-1;
%         dfloat_ini(N_float)=-0.01;
%     end
% end    

%% 

spherical=ncread(grd,'spherical');
if (spherical)
    [xfloat_ini, yfloat_ini, UTM_zone] = deg2utm(latfloat_ini,lonfloat_ini);
    xfloat_ini=(xfloat_ini - x_corner_m)/1000; % m->km
    yfloat_ini=(yfloat_ini - y_corner_m)/1000; % m->km
end  
dfloat_ini2 = dfloat_ini.*-1;

date_str = 'initial points';

LevelList = [-0.2 3 50];
unit = 'km'; 

%[h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat_ini(:),yfloat_ini(:),dfloat_ini2(:),h,date_str,'Larvae',-1,30,flipud(jet(128)),xsize,ysize,xmin,xmax,ymin,ymax);
[h_scatter,h_contour,h_annot]=createfltplot4(x_rho,y_rho,xfloat_ini(:),yfloat_ini(:),dfloat_ini2(:),h,date_str,'Larvae',-1,30,flipud(jet(128)),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% [h_scatter,h_contour,h_annot]=createfltplot4(x_rho,y_rho,xfloat(:,i),yfloat(:,i),ifloat,h,date_str,'Larvae',1,num_float,flipud(jet(128)),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
%[h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat(:,i),yfloat(:,i),dfloat(:,i),h,date_str,'Larvae',-1,40,flipud(winter(256)),xsize,ysize,xmin,xmax,ymin,ymax);
hold on;

%% draw polygons
colors=jet(n_poly);

for i=1:n_poly
    pgon = polyshape(S(i).x_km, S(i).y_km);
    plot(pgon,'FaceColor',colors(S(i).id,:),'FaceAlpha',0.5);
    text(max(S(i).x_km)+1, mean(S(i).y_km), num2str(S(i).id),'FontSize',15);
end
drawnow();
%%
G=1; C=1; T=2; N=1; 
Ft0=datenum(2024,1,7,0,0,0)-datenum(2000,1,1)-101/24/60/60;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  5606 = 2015-05-08 - 2000-01-01 (days)
Fdt=1; Fdx=0.0; Fdy=0.0; Fdz=0.0; 
fid=fopen('roms_flt_palau_20240106.txt','w');   
for i=1:N_float
    fprintf(fid,'%i %i %i %i %f %f %f %f %f %f %f %f\r\n',G,C,T,N,Ft0,lonfloat_ini(i),latfloat_ini(i),dfloat_ini(i),Fdt,Fdx,Fdy,Fdz);   
end
fclose(fid) ;

totalfloats =  N_float*N

fid=fopen('LTRANS_flt.txt','w');   
for i=1:N_float
    fprintf(fid,'%f, %f, %f\r\n',lonfloat_ini(i),latfloat_ini(i),dfloat_ini(i));   
end
fclose(fid) ;

totalfloats =  N_float*N
