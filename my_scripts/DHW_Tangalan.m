%
% === Copyright (c) 2023 Takashi NAKAMURA  =====
clear all
close all

CASE = 2;
out_dirstr = 'output/figs_Tangalan_DHW';
% out_dirstr = 'output/figs_Tangalan_DHW_zoom';
fname_prefix1='Tangalan_DHW_';
fname_prefix2='Tangalan_MaxVel_';
fname_prefix3='Tangalan_AveVel_';
fname_prefix4='Tangalan_Max_Btm_ShearStress_';
fname_prefix5='Tangalan_Max_Btm_mud_01_';
fname_prefix6='Tangalan_Ave_Btm_mud_01_';
fname_prefix7='Tangalan_sed_rate_';
fname_prefix8='Tangalan_Max_Hs_';
fname_prefix9='Tangalan_Max_BtmWavOrbVel_';
fname_prefix10='Tangalan_AveVel_wav_curr_';
fname_prefix11='Tangalan_Ave_BtmWavOrbVel_';

[status, msg] = mkdir( out_dirstr )
fileID = fopen([out_dirstr,'/Tangalan_DHW.txt'],'w');

% Panay1
% grd='F:/COAWST_DATA/Panay/Panay1/Grid/Panay1_grd_v1.4.nc';
% his=["E:/COAWTS_OUTPUT/Panay/Panay1/Panay1_sed_wav_his_20210105.nc"];
%    
% LevelList = [-5 5 10 100 200 300 400 500 600 700 800 900 1000];

 % Tangalan
grd='F:/COAWST_DATA/Panay/Tangalan/Grid/Tangalan_grd_v2.1.nc';
his=["E:/COAWTS_OUTPUT/Panay/Tangalan/Tangalan_sed_wav_his_20210107.nc"
     "E:/COAWTS_OUTPUT/Panay/Tangalan/Tangalan_sed_wav_his_20211010.nc"];

LevelList = [-5 0 1 3 5 10 100 200 300 400 500 600 700 800 900 1000];
    

unit = 'km'; % 'm', 'latlon'
% ---------------------------

h = ncread(grd, 'h');
rmask = ncread(grd, 'mask_rho');
umask = ncread(grd,'mask_u');
vmask = ncread(grd,'mask_v');



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

% Nz=15;  % Surface
Nz=1;  % Bottom
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
xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=2;   ymax=max(max(y_rho));
% xmin=3.8;   xmax=11.2;  ymin=3.8;   ymax=11.2; % Zoom
xsize=620; ysize=490;


for yyyy=2021:2021
    
    close all
    tmin = datenum(yyyy,1,1,0,0,0); tmax = datenum(yyyy,12,31,0,0,0);

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

        tmp2 = ncread(his(ihis), 'temp', [1 1 Nz imin], [Inf Inf 1 imax-imin+1]);  % 4D var
    %     tmp2 = ncread(his(ihis), ncname, [i j 1], [1 1 Inf]);   % 3D vae
    %     tmp2 = ncread(his(ihis), ncname, 1, Inf );   % 1D vae
        tmp2=squeeze(tmp2);

        u3 = ncread(his(ihis), 'u', [1 1 Nz imin], [Inf Inf 1 imax-imin+1]);  % 4D var
        v3 = ncread(his(ihis), 'v', [1 1 Nz imin], [Inf Inf 1 imax-imin+1]);  % 4D var
        u3 =squeeze(u3);
        v3 =squeeze(v3);

        u2(1:Im, 1:Jm, 1:imax)=NaN;
        u2(2:Im, 1:Jm, 1:imax)=u3;%.*scale;
        v2(1:Im, 1:Jm, 1:imax)=NaN;
        v2(1:Im, 2:Jm, 1:imax)=v3;%.*scale;
        vel2=hypot(u2,v2);

        bstr2 = ncread(his(ihis), 'bstrcwmax', [1 1 imin], [Inf Inf imax-imin+1]);  % 3D var
        bstr2=squeeze(bstr2);

        mud2 = ncread(his(ihis), 'mud_01', [1 1 Nz imin], [Inf Inf 1 imax-imin+1]);  % 4D var
        mud2 = squeeze(mud2);


        Hsig2 = ncread(his(ihis), 'Hwave', [1 1 imin], [Inf Inf imax-imin+1]);  % 3D var
        Hsig2=squeeze(Hsig2);
        Tsig2 = ncread(his(ihis), 'Pwave_top', [1 1 imin], [Inf Inf imax-imin+1]);  % 3D var
        Tsig2=squeeze(Tsig2);
        Lsig2 = ncread(his(ihis), 'Lwave', [1 1 imin], [Inf Inf imax-imin+1]);  % 3D var
        Lsig2=squeeze(Lsig2);
        Dsig2 = ncread(his(ihis), 'Dwave', [1 1 imin], [Inf Inf imax-imin+1]);  % 3D var
        Dsig2=squeeze(Dsig2);

        zeta2 = ncread(his(ihis), 'zeta', [1 1 imin], [Inf Inf imax-imin+1]);  % 3D var
        zeta2=squeeze(zeta2);

        if(F_1st)
            tmp = tmp2;
            vel = vel2;
            u = u2;
            v = v2;
            bstr = bstr2;
            mud = mud2;
%             sed = sed2;
            Hsig = Hsig2;
            Tsig = Tsig2;
            Lsig = Lsig2;
            Dsig = Dsig2;
            zeta = zeta2;
            time= time2(imin:imax);
        else
            for idt=size(time,1):-1:1
                if(time(idt) < time2(1))
                    break
                end
            end
            tmp = cat(3,tmp(:,:,1:idt), tmp2);
            vel = cat(3,vel(:,:,1:idt), vel2);
            u = cat(3,u(:,:,1:idt), u2);
            v = cat(3,v(:,:,1:idt), v2);
            bstr = cat(3,bstr(:,:,1:idt), bstr2);
            mud = cat(3,mud(:,:,1:idt), mud2);
%             sed = cat(3,sed(:,:,1:idt), sed2);
            Hsig = cat(3,Hsig(:,:,1:idt), Hsig2);
            Tsig = cat(3,Tsig(:,:,1:idt), Tsig2);
            Lsig = cat(3,Lsig(:,:,1:idt), Lsig2);
            Dsig = cat(3,Dsig(:,:,1:idt), Dsig2);
            zeta = cat(3,zeta(:,:,1:idt), zeta2);
            time=[time(1:idt); time2(imin:imax)];
        end
        clear tmp2 u3 v3 u2 v2 vel2 bstr2 mud2 sed2 Hsig2 Tsig2 Lsig2 Dsig2 zeta2;
        F_1st = false;
    end

    % sedimentation rate
    sed = ncread(his(ihis), 'bed_thickness', [1 1 1 imax], [Inf Inf 1 1]);  % 3D var
    sed=squeeze(sed);

    %% calc. HS

    MMM = 29.0;
    HS = zeros(size(tmp));
    for k=1:size(time,1)
        HS(:,:,k) = max(tmp(:,:,k)-MMM, 0).* rmask;
    end

    %% calc. DHW

    dit= 1*24*84; % 12 weeks
    dt=1/24; %(day)
    HS(HS<1) = 0;
    DHW = zeros(size(tmp));
    it=1+dit;
    DHW(:,:,it) = sum(HS(:,:,it-dit:it), 3)/7*dt;
    for it=2+dit:size(time,1)
        disp(it)
        DHW(:,:,it) = DHW(:,:,it-1)+(HS(:,:,it)-HS(:,:,it-dit-1))/7*dt;
    end
    % %% 
    % save('DHW.mat','time','date','tmp','DHW');

    %% 

    DHW_max = max(DHW,[],3);

    N04=size(find(DHW_max>=4),1);
    N08=size(find(DHW_max>=8),1);
    N12=size(find(DHW_max>=12),1);
    
    fprintf(fileID,'%d, %d, %d, %d\n',yyyy,N04,N08,N12);


    %% 
    vel_max = max(vel,[],3);
    vel_ave = mean(vel,3);
    bstr_max = max(bstr,[],3);
    mud_max = max(mud,[],3);
    sed_max = max(sed,[],3);
    mud_ave = mean(mud,3);

    [Hsig_max, idx] = max(Hsig,[],3);
%     for i=1:size(Hsig,1)
%         for j=1:size(Hsig,2)
%             Tsig_max = Tsig(i,j,idx(i,j));  % 
%             Lsig_max = Lsig(i,j,idx(i,j));  % 
%         end
%     end
%     k_max = 2*pi./Lsig_max;
%     Uwav_max=pi*Hsig_max./Tsig_max./sinh(k_max.*h);

    %% calc. averaged absolute velocity (wave+current) 

    vel_ave2 = zeros(size(vel));
    Vwav_max = zeros(size(vel));
    for it=1:size(time,1)
        disp(it)
        ksig = 2*pi./Lsig(:,:,it);
        d = h+zeta(:,:,it);
        Vwav_max(:,:,it)=pi*Hsig(:,:,it)./Tsig(:,:,it)./sinh(ksig.*d);
        for idt=1:20           
            v_wav = Vwav_max(:,:,it) * sin(2*pi/20*idt);
            u4 = v_wav.*cos(Dsig(:,:,it)*pi/180) + u(:,:,it);
            v4 = v_wav.*sin(Dsig(:,:,it)*pi/180) + v(:,:,it);
            vel_ave2(:,:,it) = vel_ave2(:,:,it) + sqrt(u4.*u4 + v4.*v4)/20;
        end
    end
    Vwav_max2=max(Vwav_max,[],3);
    vel_ave3 = mean(vel_ave2,3);
    Vwav_ave=sqrt(mean(Vwav_max.*Vwav_max,3));

    %%

    % My color map
    load('MyColormaps')
    colmap6=superjet(20,'wcZbtgyorWq');

    title=['Maximum Degree Heating Week (^oC-weeks) in ', num2str(yyyy)];  cmin=0; cmax=6; colmap=colmap6;
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,DHW_max,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow
    fname = [fname_prefix1, num2str(yyyy) ];
    hgexport(figure(1), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

    title=['Maximum bottom velocity (m s^-^1) in ', num2str(yyyy)];  cmin=0; cmax=0.5; colmap=colmap6;
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,vel_max,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow
    fname = [fname_prefix2, num2str(yyyy) ];
    hgexport(figure(2), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

    title=['Mean bottom velocity (m s^-^1) in ', num2str(yyyy)];  cmin=0; cmax=0.1; colmap=colmap6;
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,vel_ave,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow
    fname = [fname_prefix3, num2str(yyyy) ];
    hgexport(figure(3), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

    title=['Maximum wave and current bottom stress (N m^-^2) in ', num2str(yyyy)];  cmin=0; cmax=80; colmap=colmap6;
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho, bstr_max,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow
    fname = [fname_prefix4, num2str(yyyy) ];
    hgexport(figure(4), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

    title=['Maximum bottom suspended solid concentration (kg m^-^3) in ', num2str(yyyy)];  cmin=0; cmax=0.1; colmap=colmap6;
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho, mud_max,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow
    fname = [fname_prefix5, num2str(yyyy) ];
    hgexport(figure(5), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

    title=['Mean bottom suspended solid concentration (kg m^-^3) in ', num2str(yyyy)];  cmin=0; cmax=0.002; colmap=colmap6;
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho, mud_ave,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow
    fname = [fname_prefix6, num2str(yyyy) ];
    hgexport(figure(6), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

    title=['Sedimentation rate (m yr^-^1) in ', num2str(yyyy)];  cmin=0; cmax=0.0000002; colmap=colmap6;
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho, sed_max,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow
    fname = [fname_prefix7, num2str(yyyy) ];
    hgexport(figure(7), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

    title=['Maximum Hs (m) in ', num2str(yyyy)];  cmin=0; cmax=3; colmap=colmap6;
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho, Hsig_max,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow
    fname = [fname_prefix8, num2str(yyyy) ];
    hgexport(figure(8), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

    title=['Maximum bottom wave orbital velocity (m s^-^1) in ', num2str(yyyy)];  cmin=0; cmax=1.6; colmap=colmap6;
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho, Vwav_max2,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow
    fname = [fname_prefix9, num2str(yyyy) ];
    hgexport(figure(9), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

    title=['Mean bottom wave and current velocity (m s^-^1) in ', num2str(yyyy)];  cmin=0; cmax=0.15; colmap=colmap6;
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho, vel_ave3,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow
    fname = [fname_prefix10, num2str(yyyy) ];
    hgexport(figure(10), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

    title=['Maean bottom wave orbital velocity (m s^-^1) in ', num2str(yyyy)];  cmin=0; cmax=0.2; colmap=colmap6;
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho, Vwav_ave,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow
    fname = [fname_prefix11, num2str(yyyy) ];
    hgexport(figure(11), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

end
fclose(fileID);
save('tangalan_results1.mat','vel_ave','Vwav_max2','vel_ave3','Vwav_ave')