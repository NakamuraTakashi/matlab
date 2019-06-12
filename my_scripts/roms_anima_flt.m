grd='C:\cygwin64\home\Takashi\ROMS\Projects\Shiraho_reef_offline\Data\shiraho_reef_grid11.nc';
his='C:\cygwin64\home\Takashi\ROMS\Projects\Shiraho_reef_offline\ocean_his.nc';
flt='C:\cygwin64\home\Takashi\ROMS\Projects\Shiraho_reef_offline\ocean_flt.nc';
%grd='D:\output\ROMS\Shiraho_reef\flt_test1\Data\shiraho_reef_grid10.nc';
%his='D:\output\ROMS\Shiraho_reef\flt_test1\ocean_his.nc';
%flt='D:\output\ROMS\Shiraho_reef\flt_test1\ocean_flt.nc';
%grd='D:\output\ROMS\Shiraho_reef\flt_test2\Data\shiraho_reef_grid10.nc';
%his='D:\output\ROMS\Shiraho_reef\flt_test2\ocean_his.nc';
%flt='D:\output\ROMS\Shiraho_reef\flt_test2\ocean_flt.nc';

Jm=192;   % Mm+2
Im=64;    % Lm+2

h          = nc_varget(grd,'h');
p_coral    = nc_varget(grd,'p_coral');
%p_seagrass = nc_varget(grd,'p_seagrass');
%lat_rho    = nc_varget(grd,'lat_rho');
%lon_rho    = nc_varget(grd,'lon_rho');
x_rho      = nc_varget(grd,'x_rho');
y_rho      = nc_varget(grd,'y_rho');
c(1:Jm,1:Im)=0;
x_rho=x_rho/1000; % m->km
y_rho=y_rho/1000; % m->km

k=0;
i=1;

id = 16;


close all

%time = nc_varget(his,'ocean_time',[i],[1]);
time = nc_varget(flt,'ocean_time');
imax=length(time);

%---------------------------------------------------------------------
%  Read in floats data. 
%---------------------------------------------------------------------

spherical=nc_read(his,'spherical');

if (spherical),
  xfloat=nc_read(flt,'lon');
  yfloat=nc_read(flt,'lat');
  dfloat=nc_read(flt,'depth');
else  
  xfloat=nc_read(flt,'x').*0.001;
  yfloat=nc_read(flt,'y').*0.001;
  dfloat=nc_read(flt,'depth').*-1;
end  

% My color map
load('MyColormaps')

date=datenum(2009,8,25,0,0,0)+time(i+1)/24/60/60;
date_str=datestr(date,31);

[h_scatter,h_contour,h_annot]=createfltplot(x_rho,y_rho,xfloat(:,i),yfloat(:,i),dfloat(:,i),h,date_str,'Larvae',-1,40,flipud(jet(256)));
%[h_scatter,h_contour,h_annot]=createfltplot(x_rho,y_rho,xfloat(:,i),yfloat(:,i),dfloat(:,i),h,date_str,'Larvae',-1,40,flipud(winter(256)));
drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]%[0 0 290 620]

%for i=3:3:imax-1%336 %imax-1  %i=1:imax-1
for i=1:1:imax-1%336 %imax-1  %i=1:imax-1
    
date=datenum(2009,8,25,0,0,0)+time(i+1)/24/60/60;
date_str=datestr(date,31);

set(h_scatter,'XData',xfloat(:,i),'YData',yfloat(:,i),'CData',dfloat(:,i))
set(h_annot,'String',date_str)

drawnow
%hgexport(figure(1), strcat('output/figs_png\f01_',num2str(i,'%0.4u'),'.png'),hgexport('factorystyle'),'Format','png');

end



