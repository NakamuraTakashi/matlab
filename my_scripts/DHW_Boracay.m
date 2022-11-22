%
% === Copyright (c) 2021 Takashi NAKAMURA  =====

CASE = 2;
out_dirstr = 'output/figs_BCY3DHW';
fname_prefix1='BCY3_DHW_';
fname_prefix2='BCY3_MaxVel_';
fileID = fopen([out_dirstr,'/BCY3_DHW.txt'],'w');

[status, msg] = mkdir( out_dirstr )

 % Boracay3
grd='F:\COAWST_DATA\Boracay\Boracay3\Grid\Boracay3_grd_v1.1.nc';
his=["E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210107.nc"
     "E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210227.nc"
     "E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210514.nc"
     "E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210808.nc"
     "E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20211205.nc"];
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

%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=1;   ymax=max(max(y_rho));
xmin=3.5;   xmax=12;  ymin=3;   ymax=12;
xsize=620; ysize=500;

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

        u = ncread(his(ihis), 'u', [1 1 Nz imin], [Inf Inf 1 imax-imin+1]);  % 4D var
        v = ncread(his(ihis), 'v', [1 1 Nz imin], [Inf Inf 1 imax-imin+1]);  % 4D var
        u =squeeze(u);
        v =squeeze(v);

        u2(1:Im, 1:Jm, 1:imax)=NaN;
        u2(2:Im, 1:Jm, 1:imax)=u;%.*scale;
        v2(1:Im, 1:Jm, 1:imax)=NaN;
        v2(1:Im, 2:Jm, 1:imax)=v;%.*scale;
        vel2=hypot(u2,v2);

        if(F_1st)
            tmp = tmp2;
            vel = vel2;
            time= time2(imin:imax);
        else
            for idt=size(time,1):-1:1
                if(time(idt) < time2(1))
                    break
                end
            end
            tmp = cat(3,tmp(:,:,1:idt), tmp2);
            vel = cat(3,vel(:,:,1:idt), vel2);
            time=[time(1:idt); time2(imin:imax)];
        end
        clear tmp2 u v u2 v2 vel2;
        F_1st = false;
    end

    %% calc. HS

    MMM = 29;
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
    vel_max = max(vel,[],3);
    
    N04=size(find(DHW_max>=4),1);
    N08=size(find(DHW_max>=8),1);
    N12=size(find(DHW_max>=12),1);
    
    fprintf(fileID,'%d, %d, %d, %d\n',yyyy,N04,N08,N12);

    %%

    % My color map
    load('MyColormaps')
    colmap6=superjet(20,'wcZbtgyorWq');

    title=['Maximum Degree Heating Week (^oC-weeks) in ', num2str(yyyy)];  cmin=0; cmax=20; colmap=colmap6;

    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,DHW_max,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow

    fname = [fname_prefix1, num2str(yyyy) ];

    hgexport(figure(1), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

    title=['Maximum bottom velocity (m s^-^1) in ', num2str(yyyy)];  cmin=0; cmax=1; colmap=colmap6;

    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,vel_max,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow

    fname = [fname_prefix2, num2str(yyyy) ];

    hgexport(figure(2), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

end
fclose(fileID);