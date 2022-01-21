%
% === ver 2021/12/21   Copyright (c) 2015-2021 Takashi NAKAMURA  =====
%                

grd='F:/COAWST_DATA/Yaeyama/Yaeyama2/Grid/Yaeyama2_grd_v11.2.nc';
% grd='D:/ROMS/Yaeyama/Data/Yaeyama3_grd_v8.nc';

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

% LevelList = [-1 1 10];
LevelList = [-1 0.2 0.5 3];
unit = 'km'; 

k=0;
i=1;
resol = 100;  % 1/3/5/...

xmin=min(min(x_rho))-0.3;   xmax=max(max(x_rho))+0.3;  ymin=min(min(y_rho))-0.3;   ymax=max(max(y_rho))+0.3;
xsize=620; ysize=550;



close all

shallow_area =  ones(size(h));
shallow_area(h<1) = 0;
shallow_area(h>=10)   = 0;

imshow(shallow_area)
axis on
colorbar
[ix,iy]=find(shallow_area == 1);

%% 
% for i=1:size(ix)
%     latfloat_ini(i)=lat_rho(ix(i),iy(i));
%     lonfloat_ini(i)=lon_rho(ix(i),iy(i));
%     dfloat_ini(i)=h(ix(i),iy(i)).*-1;
% end
N_float = 0;

% Yonara channel
lat_c = 24.32771;
lon_c = 123.94808;

% d_lat = 0.003/2/resol;
% d_lon = 0.003/2/resol;
d_lat = 0.01/2/resol;
d_lon = 0.01/2/resol;

lat_s = lat_c - d_lat*floor(resol/2);
lon_s = lon_c - d_lon*floor(resol/2);

for j=1:resol
    for k=1:resol
        N_float = N_float+1;
        latfloat_ini(N_float)=lat_s + d_lat*(j-1);
        lonfloat_ini(N_float)=lon_s + d_lon*(k-1);
%           dfloat_ini(N_float)=h(ix(i),iy(i)).*-1;
        dfloat_ini(N_float)=-10;
    end
end    


%% 

spherical=ncread(grd,'spherical');
if (spherical),
    [xfloat_ini, yfloat_ini, UTM_zone] = deg2utm(latfloat_ini,lonfloat_ini);
    xfloat_ini=(xfloat_ini - x_corner_m)/1000; % m->km
    yfloat_ini=(yfloat_ini - y_corner_m)/1000; % m->km
end  
dfloat_ini2 = dfloat_ini.*-1;

date_str = 'initial points';

%[h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat_ini(:),yfloat_ini(:),dfloat_ini2(:),h,date_str,'Larvae',-1,30,flipud(jet(128)),xsize,ysize,xmin,xmax,ymin,ymax);
[h_scatter,h_contour,h_annot]=createfltplot4(x_rho,y_rho,xfloat_ini(:),yfloat_ini(:),dfloat_ini2(:),h,date_str,'Larvae',-1,30,flipud(jet(128)),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
%[h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat(:,i),yfloat(:,i),dfloat(:,i),h,date_str,'Larvae',-1,40,flipud(winter(256)),xsize,ysize,xmin,xmax,ymin,ymax);
%%
G=1; C=1; T=1; N=1; 
Ft0=datenum(2011,5,25,14,30,0) - datenum(2000,1,1,0,0,0) -1/24/60;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  5606 = 2015-05-08 - 2000-01-01 (days)
Fdt=0; Fdx=0.0; Fdy=0.0; Fdz=0.0; 
fid=fopen('roms_flt_20110525.txt','w');   
for i=1:N_float
    fprintf(fid,'%i %i %i %i %f %f %f %f %f %f %f %f\r\n',G,C,T,N,Ft0,lonfloat_ini(i),latfloat_ini(i),dfloat_ini(i),Fdt,Fdx,Fdy,Fdz);   
end
fclose(fid) ;

totalfloats =  N_float*N

N=1;
Ft0=( datenum(2011,5,25,14,30,0) - datenum(2011,4,2,0,0,0) )*24*60*60;  %2015-05-08 - 2000-01-01 (days)

fid=fopen('LTRANS_flt.csv','w');   
for i=1:N_float
%     fprintf(fid,'%f,%f,%f,%d\r\n',lonfloat_ini(i),latfloat_ini(i),dfloat_ini(i),cast(Ft0,'int32'));
    fprintf(fid,'%f,%f,%f,%d\r\n',lon_c,lat_c,dfloat_ini(i),cast(Ft0,'int32')); 
end
fclose(fid) ;

totalfloats =  N_float*N
