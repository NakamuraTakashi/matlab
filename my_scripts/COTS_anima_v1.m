%
% === ver 2015/11/20   Copyright (c) 2015 Takashi NAKAMURA  =====
%                for MATLAB R2015a  

grd='/work1/t2gnakamulab/ROMS/Yaeyama/Data/Yaeyama2_grd_v9.3.nc'; 

% his='/work1/t2gnakamulab/COTS_model/Nx1_3/cots_his.nc';
% his='/work1/t2gnakamulab/COTS_model/Nx0.25_3/cots_his.nc';
% his='/work1/t2gnakamulab/COTS_model/Nx0.5/cots_his.nc';
% his='/work1/t2gnakamulab/COTS_model/Nx0.75/cots_his.nc';
his='/work1/t2gnakamulab/COTS_model/Nx2/cots_his.nc';



starting_date=datenum(2000,6,1,0,0,0);

h          = ncread(grd,'h');
x_rho      = ncread(grd,'x_rho');
y_rho      = ncread(grd,'y_rho');
mask_rho   = ncread(grd,'mask_rho');

[Im,Jm] = size(h);

c(1:Im,1:Jm)=0;
x_rho=(x_rho-min(min(x_rho)))/1000; % m->km
y_rho=(y_rho-min(min(y_rho)))/1000; % m->km

k=0;
i=1;

xmin=0;   xmax=max(max(x_rho));  ymin=0;   ymax=max(max(y_rho));

xsize=Im*2+100; ysize=Jm*2+100;  % for YAEYAM1

% id = 8;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
id = 7;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all

time = ncread(his,'cots_time');

imax=length(time);

mask_rho = mask_rho ./mask_rho;

if id == 1
    tmp = ncread(his,'cots1',[1 1 i],[Inf Inf 1]);
elseif id == 2 
    tmp = ncread(his,'cots2',[1 1 i],[Inf Inf 1]);
elseif id == 3 
    tmp = ncread(his,'cots3',[1 1 i],[Inf Inf 1]);
elseif id == 4 
    tmp = ncread(his,'cots4',[1 1 i],[Inf Inf 1]);
elseif id == 5 
    tmp = ncread(his,'cots5',[1 1 i],[Inf Inf 1]);
elseif id == 6 
    tmp = ncread(his,'cots_sum',[1 1 i],[Inf Inf 1]);
elseif id == 7
    tmp = ncread(his,'p_coral',[1 1 i],[Inf Inf 1]);
elseif id == 8
    tmp = ncread(his,'cots3',[1 1 i],[Inf Inf 1]);
    tmp = tmp + ncread(his,'cots4',[1 1 i],[Inf Inf 1]);
    tmp = tmp + ncread(his,'cots5',[1 1 i],[Inf Inf 1]);
elseif id == 9
    tmp = ncread(his,'cots4',[1 1 i],[Inf Inf 1]);
    tmp = tmp + ncread(his,'cots5',[1 1 i],[Inf Inf 1]);
end

% My color map
load('MyColormaps')

date=starting_date+time(i+1);

date_str=datestr(date,29);

if id == 1
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'COTS, life stage 1: juvenile (individuals m^-^2)',0,100,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 2
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'COTS, life stage 2: 0.4-1 years old (individuals m^-^2)',0,10,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 3
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'COTS, life stage 3: 1-2 years old (individuals m^-^2)',0,1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 4
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'COTS, life stage 4: 2-3 years old (individuals m^-^2)',0,0.1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 5
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'COTS, life stage 5: 3- years old (individuals m^-^2)',0,0.01,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 6
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'COTS, all stages (individuals m^-^2)',0,0.1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 7
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'Coral coverage',0,1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 8
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'COTS, adult (individuals m^-^2)',0,0.05,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
elseif id == 9
    [h_surf,h_contour,h_annot]=createfigure3(x_rho,y_rho,tmp,h,date_str,'COTS, large size (individuals m^-^2)',0,0.1,colmap4,xsize,ysize,xmin,xmax,ymin,ymax);
end
drawnow

for i=1:1:imax

    if id == 1
        tmp = ncread(his,'cots1',[1 1 i],[Inf Inf 1]);
    elseif id == 2 
        tmp = ncread(his,'cots2',[1 1 i],[Inf Inf 1]);
    elseif id == 3 
        tmp = ncread(his,'cots3',[1 1 i],[Inf Inf 1]);
    elseif id == 4 
        tmp = ncread(his,'cots4',[1 1 i],[Inf Inf 1]);
    elseif id == 5 
        tmp = ncread(his,'cots5',[1 1 i],[Inf Inf 1]);
    elseif id == 6 
        tmp = ncread(his,'cots_sum',[1 1 i],[Inf Inf 1]);
    elseif id == 7
        tmp = ncread(his,'p_coral',[1 1 i],[Inf Inf 1]);
    elseif id == 8
        tmp = ncread(his,'cots3',[1 1 i],[Inf Inf 1]);
        tmp = tmp + ncread(his,'cots4',[1 1 i],[Inf Inf 1]);
        tmp = tmp + ncread(his,'cots5',[1 1 i],[Inf Inf 1]);
    elseif id == 9
        tmp = ncread(his,'cots4',[1 1 i],[Inf Inf 1]);
        tmp = tmp + ncread(his,'cots5',[1 1 i],[Inf Inf 1]);
    end

    date=starting_date+time(i);

    date_str=datestr(date,29);

    set(h_surf,'CData',tmp)
    set(h_annot,'String',date_str)
    drawnow
    hgexport(figure(1), strcat('output/figs_png\cots01_',num2str(i,'%0.4u'),'.png'),hgexport('factorystyle'),'Format','png');

end



