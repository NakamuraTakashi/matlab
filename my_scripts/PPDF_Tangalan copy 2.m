%
% === Copyright (c) 2023 Takashi NAKAMURA  =====
clear all
close all

CASE = 2;
out_dirstr = 'output/figs_Tangalan_DHW_2023';
out_dirstr2 = 'output/figs_Tangalan_DHW_zoom_2023';
fname_prefix1='Tangalan_PPFD_Btm_';

[status, msg] = mkdir( out_dirstr )
[status, msg] = mkdir( out_dirstr2 )
% Panay1
% grd='F:/COAWST_DATA/Panay/Panay1/Grid/Panay1_grd_v1.4.nc';
% his=["E:/COAWTS_OUTPUT/Panay/Panay1/Panay1_sed_wav_his_20210105.nc"];
%    
% LevelList = [-5 5 10 100 200 300 400 500 600 700 800 900 1000];

 % Tangalan
grd='D:/COAWST_DATA/Panay/Tangalan/Grid/Tangalan_grd_v2.1.nc';
his=["E:/COAWST_OUTPUT/Panay/Tangalan/Tangalan_sed_wav_his_20230210.nc"
     "E:/COAWST_OUTPUT/Panay/Tangalan/Tangalan_sed_wav_his_20231001.nc"];

LevelList = [-5 0 1 3 5 10 100 200 300 400 500 600 700 800 900 1000];
    

unit = 'km'; % 'm', 'latlon'
% ---------------------------

h = ncread(grd, 'h');
rmask = ncread(grd, 'mask_rho');
umask = ncread(grd,'mask_u');
vmask = ncread(grd,'mask_v');

hc = ncread(his(1), 'hc');             % 'S-coordinate parameter, critical depth'
sc_r = ncread(his(1), 's_rho');        % 'S-coordinate at RHO-points'
Cs_r = ncread(his(1), 'Cs_r');         % 'S-coordinate stretching curves at RHO-points'
sc_w = ncread(his(1), 's_w');          % 'S-coordinate at W-points'
Cs_w = ncread(his(1), 'Cs_w');         % 'S-coordinate stretching curves at W-points'
Vtransform = ncread(his(1), 'Vtransform');
Vstretching = ncread(his(1), 'Vstretching');

% if Vtransform~=2 || Vstretching~=4
%     error('Not applicable: Vtransform & Vstretching')
% end



scale=2;
s_interval=3;
Vmax = 0.6;

if strcmp(unit,'latlon')
    y_rho    = ncread(grd,'lat_rho');
    x_rho    = ncread(grd,'lon_rho');
elseif strcmp(unit,'m')
    x_rho      = ncread(grd,'x_rho');
    y_rho      = ncread(grd,'y_rho');
elseif strcmp(unit,'km')
    x_rho      = ncread(grd,'x_rho');
    y_rho      = ncread(grd,'y_rho');
    x_rho=(x_rho-min(min(x_rho)))/1000; % m->km
    y_rho=(y_rho-min(min(y_rho)))/1000; % m->km
end

[Im, Jm] = size(h);
c(1:Im,1:Jm)=0;

Nz=15;  % Surface
% Nz=1;  % Bottom
% Nz=13;  % Surface + 2 layer
umask = umask ./umask;
vmask = vmask ./vmask;
rmask = rmask ./rmask;

starting_date = datenum(2000,1,1,0,0,0);



% Down sampling
x_rho2=x_rho(1:s_interval:Im,1:s_interval:Jm);
y_rho2=y_rho(1:s_interval:Im,1:s_interval:Jm);
% ubar3=ubar2(1:s_interval:Im,1:s_interval:Jm);
% vbar3=vbar2(1:s_interval:Im,1:s_interval:Jm);
ubar3=zeros(size(x_rho2));
vbar3=zeros(size(x_rho2));
date_str=''; %strcat(datestr(date,31),'  ',LOCAL_TIME);

% Panay1 setting
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=1;   ymax=max(max(y_rho));
% xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=15;   ymax=max(max(y_rho));
% xsize=620; ysize=450;

% Tangalan setting
% xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=2;   ymax=max(max(y_rho));
xmin=3.8;   xmax=11.2;  ymin=3.8;   ymax=11.2; % Zoom
xsize=620; ysize=490;


for yyyy=2023:2023
    
    close all
    % tmin = datenum(yyyy,1,1,0,0,0); tmax = datenum(yyyy,12,31,0,0,0);
    tmin = datenum(yyyy,1,1,0,0,0); tmax = datenum(yyyy+1,4,30,0,0,0);

    %% Read data
    F_1st = true;

    for ihis=1:size(his,1)
    % for ihis=3:9
        disp(ihis)
        time2 = ncread(his(ihis), 'ocean_time', 1, Inf);
        time2=starting_date+time2/24/60/60; %sec-> day
        imin = find(time2>=tmin, 1, 'first' );
        if(isempty(imin))
            continue;
        end  
        imax = find(time2<tmax, 1 , 'last');
        if(isempty(imax))
            break;
        end

        mud2 = ncread(his(ihis), 'mud_01', [1 1 1 imin], [Inf Inf Inf imax-imin+1]);  % 4D var
        mud2 = squeeze(mud2);

        zeta2 = ncread(his(ihis), 'zeta', [1 1 imin], [Inf Inf imax-imin+1]);  % 3D var
        zeta2=squeeze(zeta2);

        swrad2 = ncread(his(ihis), 'swrad', [1 1 imin], [Inf Inf imax-imin+1]);  % 3D var
        swrad2=squeeze(swrad2);

        if(F_1st)
            mud = mud2;
            zeta = zeta2;
            swrad = swrad2;
            time= time2(imin:imax);
        else
            for idt=size(time,1):-1:1
                if(time(idt) < time2(1))
                    break
                end
            end
            mud = cat(4,mud(:,:,:,1:idt), mud2);
            zeta = cat(3,zeta(:,:,1:idt), zeta2);
            swrad = cat(3,swrad(:,:,1:idt), swrad2);
            time=[time(1:idt); time2(imin:imax)];
        end
        clear mud2 zeta2 swrad2;
        F_1st = false;
    end


    %% calc. averaged absolute velocity (wave+current) 
    PFD_btm = zeros(size(zeta));
    for it=1:size(time,1)
        disp(it)
        d = h+zeta(:,:,it);
        PDF = swrad(:,:,it)*1.82*(1-0.07);
        for k=Nz:-1:2
            z0 = (hc*sc_w(k)+Cs_w(k)*h)./(hc+h);
            z1 = zeta(:,:,it)+(zeta(:,:,it)+h).*z0;
            z0 = (hc*sc_w(k-1)+Cs_w(k-1)*h)./(hc+h);
            z2 = zeta(:,:,it)+(zeta(:,:,it)+h).*z0;
            AttSW = 0.06*10^3*mud(:,:,k,it)+0.29;
            PDF = PDF.*exp(AttSW.*(z2-z1));
        end
        PFD_btm(:,:,it) = PDF;
    end

    PFD_ave = mean(PFD_btm,3);

    %%

    % My color map
    load('MyColormaps')
    colmap6=superjet(20,'wcZbtgyorWq');

    title=['Mean bottom photon flux density (umol m^-^2 s^-^1) in ', num2str(yyyy)];  cmin=0; cmax=250; colmap=colmap6;
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=2;   ymax=max(max(y_rho));
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,PFD_ave,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow
    fname = [fname_prefix1, num2str(yyyy) ];
    hgexport(figure(1), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

    xmin=3.8;   xmax=11.2;  ymin=3.8;   ymax=11.2; % Zoom
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,PFD_ave,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow
    fname = [fname_prefix1, num2str(yyyy) ];
    hgexport(figure(2), strcat(out_dirstr2,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

end
save('tangalan_results2.mat','PFD_ave')