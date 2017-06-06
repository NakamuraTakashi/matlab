%
% === ver 2015/10/26   Copyright (c) 2015 Takashi NAKAMURA  =====
%                for MATLAB R2015a,b  

grd='/work1/t2gnakamulab/ROMS/Yaeyama/Data/Yaeyama2_grd_v9.3.nc';
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

k=0;
i=1;
resol = 1;  % 1/3/5/...

xmin=0;   xmax=max(max(x_rho));  ymin=0;   ymax=max(max(y_rho));

xsize=Im*2+100; ysize=Jm*2+100;  % for YAEYAM1
%xsize=290; ysize=680; % for SHIRAHO
%xsize=500; ysize=650; % for SHIRAHO zoom



close all

shallow_area =  ones(size(h));
shallow_area(h<0) = 0;
shallow_area(h>40)   = 0;

%imshow(shallow_area)
%axis on
%colorbar
[ix,iy]=find(shallow_area == 1);

%% 
% for i=1:size(ix)
%     latfloat_ini(i)=lat_rho(ix(i),iy(i));
%     lonfloat_ini(i)=lon_rho(ix(i),iy(i));
%     dfloat_ini(i)=h(ix(i),iy(i)).*-1;
% end
N_float = 0;

for i=1:size(ix)
    lat_c = lat_rho(ix(i),iy(i));
    lon_c = lon_rho(ix(i),iy(i));
    d_lat = ( lat_rho(ix(i),iy(i)+1) - lat_rho(ix(i),iy(i)-1) )/2/resol;
    d_lon = ( lon_rho(ix(i)+1,iy(i)) - lon_rho(ix(i)-1,iy(i)) )/2/resol;
    
    lat_s = lat_c - d_lat*floor(resol/2);
    lon_s = lon_c - d_lon*floor(resol/2);
    
    for j=1:resol
        for k=1:resol
            N_float = N_float+1;
            latfloat_ini(N_float)=lat_s + d_lat*(j-1);
            lonfloat_ini(N_float)=lon_s + d_lon*(k-1);
 %           dfloat_ini(N_float)=h(ix(i),iy(i)).*-1;
            dfloat_ini(N_float)=-1;
        end
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
%[h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat_ini(:),yfloat_ini(:),dfloat_ini2(:),h,date_str,'Larvae',-1,30,flipud(jet(128)),xsize,ysize,xmin,xmax,ymin,ymax);
%[h_scatter,h_contour,h_annot]=createfltplot2(x_rho,y_rho,xfloat(:,i),yfloat(:,i),dfloat(:,i),h,date_str,'Larvae',-1,40,flipud(winter(256)),xsize,ysize,xmin,xmax,ymin,ymax);
%%
G=1; C=1; T=1; N=30; 
%Ft0=1+(17-9)/24;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ft0=4900+4+(17-9)/24-101/24/60/60;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  4900 = 2013-06-01 - 2000-01-01 (days)
Fdt=1; Fdx=0.0; Fdy=0.0; Fdz=0.0; 
fid=fopen('roms_flt.txt','w');   
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
