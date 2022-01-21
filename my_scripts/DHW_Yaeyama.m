%
% === Copyright (c) 2021 Takashi NAKAMURA  =====

CASE = 2;
out_dirstr = 'output/figs_Y2DHW_test';
fname_prefix='Y2_DHW_';
fileID = fopen([out_dirstr,'/Y2_DHW.txt'],'w');

[status, msg] = mkdir( out_dirstr )

if CASE == 1      % YAEYAMA1
% ----- YAEYAMA1 -----------
grd='F:\COAWST_DATA\Yaeyama\Yaeyama1\Grid\Yaeyama1_grd_v10.nc';
his=["H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_19940102.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_19950101.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_19960102.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_19970102.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_19980103.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_19990104.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20000104.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20010102.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20011231.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20021231.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20031221.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20040104.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20050104.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20060105.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20060302.nc"
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20070106.nc"      %<-Yaeyama1_his_20060302_00008.nc
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20080107.nc"      %<-Yaeyama1_his_20060302_00009.nc
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20080222.nc"      %<-Yaeyama1_his_20080222_00009.nc
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20090107.nc"      %<-Yaeyama1_his_20080222_00010.nc
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20100108.nc"      %<-Yaeyama1_his_20080222_00011.nc
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20110109.nc"      %<-Yaeyama1_his_20080222_00012.nc
     "H:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20120110.nc"      %<-Yaeyama1_his_20080222_00013.nc
     "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20130110.nc"      %<-Yaeyama1_his_20080222_00014.nc
     "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20140111.nc"      %<-Yaeyama1_his_20080222_00015.nc
     "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20150112.nc"      %<-Yaeyama1_his_20080222_00016.nc
     "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20160113.nc"      %<-Yaeyama1_his_20080222_00017.nc
     "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20170113.nc"      %<-Yaeyama1_his_20170113_00018.nc
     "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20180114.nc"      %<-Yaeyama1_his_20170113_00019.nc
     "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20180606.nc"      %<-Yaeyama1_his_20180606_00019.nc
     "F:\COAWST_OUTPUT\Yaeyama1\Yaeyama1_his_20190115.nc"  ];  %<-Yaeyama1_his_20180606_00020.nc

% ----- YAEYAMA2 ------------
elseif CASE == 2  % YAEYAMA2
 grd='F:/COAWST_DATA/Yaeyama/Yaeyama2/Grid/Yaeyama2_grd_v11.2.nc';
 his=[  "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_19940110.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_19950110.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_19960110.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_19960731.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_19960802.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_19970801.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_19980801.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_19990801.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20000801.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20010731.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20020731.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20030731.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20040731.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20040823.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20040826.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20050718.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20060718.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20060915.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20060919.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20070917.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20070919.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20071003.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20071005.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20071008.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20080912.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20080914.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20090913.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20100402.nc"
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20110402.nc" %29
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20120401.nc" %30
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20120928.nc" %31
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20120930.nc" %32
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20130930.nc" %33
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20140930.nc" %34
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20150823.nc" %35
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20150825.nc" %36
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20150928.nc" %37
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20150930.nc" %38
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20160927.nc" %39
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20160929.nc" %40
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20170306.nc" %41
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20170913.nc" %42
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20170916.nc" %43
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20180916.nc" %44
        "E:/COAWTS_OUTPUT/Yaeyama2/Yaeyama2_his_20190916.nc" ]; %45

% ----- YAEYAMA2 ------------
elseif CASE == 3  % YAEYAMA3 
 grd='F:/COAWST_DATA/Yaeyama/Yaeyama3/Grid/Yaeyama3_grd_v12.2.nc';
 his=[  "E:/COAWTS_OUTPUT/Yaeyama3/Yaeyama3_his_20130501.nc"
        "E:/COAWTS_OUTPUT/Yaeyama3/Yaeyama3_his_20140501.nc"
        "E:/COAWTS_OUTPUT/Yaeyama3/Yaeyama3_his_20150501.nc"
        "E:/COAWTS_OUTPUT/Yaeyama3/Yaeyama3_his_20150807.nc"
        "E:/COAWTS_OUTPUT/Yaeyama3/Yaeyama3_his_20150809.nc"
        "E:/COAWTS_OUTPUT/Yaeyama3/Yaeyama3_his_20150823.nc"
        "E:/COAWTS_OUTPUT/Yaeyama3/Yaeyama3_his_20150825.nc"
        "E:/COAWTS_OUTPUT/Yaeyama3/Yaeyama3_his_20150928.nc"
        "E:/COAWTS_OUTPUT/Yaeyama3/Yaeyama3_his_20150930.nc"
        "E:/COAWTS_OUTPUT/Yaeyama3/Yaeyama3_his_20160501.nc"
        "E:/COAWTS_OUTPUT/Yaeyama3/Yaeyama3_his_20160927.nc"
        "E:/COAWTS_OUTPUT/Yaeyama3/Yaeyama3_his_20160929.nc"]; %
end
%
% ---------------------------

title='Temperature (^oC)'; cmin=16; cmax=32; colmap=jet(128); ncname='temp';
% title='Salinity (PSU)'; cmin=33; cmax=35; colmap=jet(128); ncname='salt';
% title='Short Wave radiation (W m^-^2)'; cmin=0; cmax=1000; colmap=jet(128); ncname='swrad';
% title='Temperature (^oC)'; cmin=16; cmax=32; colmap=jet(128); ncname='Tair';
depth = ncread(grd, 'h');
rmask = ncread(grd, 'mask_rho');
% lonr = ncread(grd, 'lon_rho', [i j], [1 1])
% latr = ncread(grd, 'lat_rho', [i j], [1 1])
% Nz=15;  % Surface
Nz=1;  % Bottom
% Nz=13;  % Surface + 2 layer

starting_date = datenum(2000,1,1,0,0,0);

for yyyy=1994:2019
    
    close all
    tmin = datenum(yyyy,5,1,0,0,0); tmax = datenum(yyyy,11,1,0,0,0);

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

        tmp2 = ncread(his(ihis), ncname, [1 1 Nz imin], [Inf Inf 1 imax-imin+1]);  % 4D var
    %     tmp2 = ncread(his(ihis), ncname, [i j 1], [1 1 Inf]);   % 3D vae
    %     tmp2 = ncread(his(ihis), ncname, 1, Inf );   % 1D vae

        tmp2=squeeze(tmp2);
        if(F_1st)
            tmp = tmp2;
            time= time2(imin:imax);
        else
            for idt=size(time,1):-1:1
                if(time(idt) < time2(1))
                    break
                end
            end
            tmp = cat(3,tmp(:,:,1:idt), tmp2);
            time=[time(1:idt); time2(imin:imax)];
        end
        clear tmp2;
        F_1st = false;
    end

    %% calc. HS

    MMM = 29.2;
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
    % My color map
    load('MyColormaps')
    colmap6=superjet(20,'wcZbtgyorWq');

    title=['Maximum Degree Heating Week (^oC-weeks) in ', num2str(yyyy)];  cmin=0; cmax=20; colmap=colmap6;

    % LevelList = [-1 1 10];
    LevelList = [-1 1 20];

    unit = 'km'; 
    %          'm', 'latlon'
    %     unit = 'latlon';

    scale=2;
    s_interval=3;
    Vmax = 0.6;

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
        x_rho=(x_rho-min(min(x_rho)))/1000; % m->km
        y_rho=(y_rho-min(min(y_rho)))/1000; % m->km
    end

    [Im, Jm] = size(h);
    c(1:Im,1:Jm)=0;

    % Down sampling
    x_rho2=x_rho(1:s_interval:Im,1:s_interval:Jm);
    y_rho2=y_rho(1:s_interval:Im,1:s_interval:Jm);
    % ubar3=ubar2(1:s_interval:Im,1:s_interval:Jm);
    % vbar3=vbar2(1:s_interval:Im,1:s_interval:Jm);
    ubar3=zeros(size(x_rho2));
    vbar3=zeros(size(x_rho2));
    date_str=''; %strcat(datestr(date,31),'  ',LOCAL_TIME);
    if CASE == 1      % YAEYAMA1
        xmin=min(min(x_rho))-1;   xmax=max(max(x_rho))+1;  ymin=min(min(y_rho))-1;   ymax=max(max(y_rho))+1;
        xsize=640; ysize=520;
    elseif CASE == 2  % YAEYAMA2
    %     xmin=min(min(x_rho))-0.3;   xmax=max(max(x_rho))+0.3;  ymin=min(min(y_rho))-0.3;   ymax=max(max(y_rho))+0.3;
    %     xsize=620; ysize=550;
        xmin=5;   xmax=80;  ymin=25;   ymax=75;
        xsize=800; ysize=520;
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

    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,DHW_max,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
    drawnow

    fname = [fname_prefix, num2str(yyyy) ];

    hgexport(figure(1), strcat(out_dirstr,'/', fname,'.png'),hgexport('factorystyle'),'Format','png');

end
fclose(fileID);