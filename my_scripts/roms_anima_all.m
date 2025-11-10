%
% === Copyright (c) 2014-2025 Takashi NAKAMURA  =====
%
clear all

% CASE 1=> Shizugawa1; 2=> Shizugawa2; 3=> Shizugawa3
% CASE 4=> Yaeyama1; 5=> Yaeyama2; 6=> Yaeyama3
% CASE 7=> Shiraho reef

% CASE 17=> FORP-JPN02 offline
% CASE 18=> Kushimoto

CASE = 18;

% --- Plotting period --- %
% min_date    = datenum(2018,6,15,0,0,0);  % Period 4 start
% min_date    = datenum(2023,10,14,0,0,0);  % Period 4 start
% max_date    = datenum(2018,8,2,0,0,0);  % Period 4 end

% min_date    = datenum(1994,1,10,0,0,0);  % Period 4 start
% min_date    = datenum(1997,8,7,0,0,0);  % Period 4 start
% max_date    = datenum(2024,1,1,0,0,0);  % Period 4 end

% min_date    = datenum(2013,10,21,0,0,0);  % Period 4 start
% min_date    = datenum(2016,5,1,0,0,0);  % Period 4 start
% max_date    = datenum(2016,11,1,0,0,0);  % Period 4 end

% min_date    = datenum(2023,9,13,0,0,0);  % Period 4 start
% max_date    = datenum(2024,1,1,0,0,0);  % Period 4 end

% min_date    = datenum(2006,1,9,0,0,0);   % FORP start
% max_date    = datenum(2006,1,10,0,0,0);  % FORP end

% min_date    = datenum(2019,8,1,0,0,0);  % Y1Y2 start
% max_date    = datenum(2019,9,1,0,0,0);  % Y1Y2 end

min_date    = datenum(2010,6,21,0,0,0);  % Period 4 start
max_date    = datenum(2010,8,10,0,0,0);  % Period 4 end

ref_date     = datenum(2000,1,1,0,0,0);  % 

F_drawUV = true;
% F_drawUV = false;
% id = 2;  % <- Select 1,2,3,7,100 2=> uv velocity
% id = 3;  % <- Select 1,2,3,7,100 3=> Wave
id = 7;  % <- Select 1,2,3,7,100
% id = 8;  % <- Select 1,2,3,7,100 for DIN = NO3 + NH4
% id = 9;  % <- Select 1,2,3,7,100
% id = 10;  % <- Select 1,2,3,7,100 for mudmass diff
% id = 11;  % <- Select 1,2,3,7,100 for 2D fields
% id = 12;  % <- Select 1,2,3,7,100 for Total Phytoplankton
% id = 13;  % <- Select 1,2,3,7,100 for Seagrass biomass

% id = 100;  % <- Select 1,2,3,7,100

wet_dry = 0;  % Dry mask OFF: 0, ON: 1
% wet_dry = 1;  % Dry mask OFF: 0, ON: 1

%==================== Shizugawa ==============================================
if CASE == 1      % Shizugawa1
    grd='D:\COAWST_DATA\Shizugawa\Shizugawa1\Grid\Shizugawa1_grd_v0.1.nc';
    his=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa1\Shizugawa1_his_20210102.nc"];
    % his=["D:\COAWST_DATA\Shizugawa\Shizugawa1\Air\Shizugawa1_frc_MSMgb_20210101_1.nc"];
    Fqck=false;
    Fdia=false;
    % out_dirstr = 'output/figs_png_SZ1wv';
    % out_dirstr = 'output/figs_png_SZ1tmp_btm';
    out_dirstr = 'output/figs_png_SZ1tmp_srf';
    
    LevelList = [-10 0 200 400 600 800 1000 1200 1400 1600 1800 2000 2200];
    
    % Nz=15; % Surface
    Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

    if id==3 % Wave direction
        scale=5;
        s_interval=7;
        % x_arrow_txt = 50; y_arrow_txt=230;
        % I_arrow_legend = 1; J_arrow_legend=25;
        % v_legend = 10;

    elseif id==100 % Wind
        scale=1;
        s_interval=5;
        x_arrow_txt = 50; y_arrow_txt=230;
        I_arrow_legend = 1; J_arrow_legend=25;
        v_legend = 20;
    else % Water Velocity
        scale=10;
        s_interval=5;
        x_arrow_txt = 50; y_arrow_txt=230;
        I_arrow_legend = 1; J_arrow_legend=25;
        v_legend = 1;
    end
    
elseif CASE == 2  % Shizugawa2
    grd='D:\COAWST_DATA\Shizugawa\Shizugawa2\Grid\Shizugawa2_grd_v0.2.nc';
    his=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa2\Shizugawa2_his_20210601.nc"];
    Fqck=false;
    % Fqck=true;
    qck=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa2\Shizugawa2_qck_20210601.nc"];
    Fdia=false;
    % Fdia=true;
    dia=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa2\Shizugawa2_dia_20210601.nc"];
%     out_dirstr = 'output/figs_png_S2srf';
    % out_dirstr = 'output/figs_png_S2btm';
    % out_dirstr = 'output/figs_png_SZ2tmp_srf';
    out_dirstr = 'output/figs_png_SZ2tmp_btm';
    
    LevelList = [-10 0 20 40 60 80 100 120 140 160 180 200 220];
    
    % Nz=15; % Surface
    Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';
    x_arrow_txt = 20; y_arrow_txt=72;
    I_arrow_legend = 1; J_arrow_legend=45;
    v_legend = 1;

    if id==3 %wave
        scale=1.5;
        s_interval=7;
    else
        scale=4;
        s_interval=5;
    end


elseif CASE == 3  % Shizugawa3
    grd='D:\COAWST_DATA\Shizugawa\Shizugawa3\Grid\Shizugawa3_grd_v0.3b.nc';
    his=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa3_eco\SZ3_aqdrag_his_20230701.nc"];
    Fqck=false;
    % Fqck=true;
    qck=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa3_eco\SZ3_eco_qck_20210701v2.nc"];
    Fdia=false;
    % Fdia=true;
    dia=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa3_eco\SZ3_eco_dia_20210701v2.nc"];

    % out_dirstr = 'output/figs_png_SZ3noaqdrag_srf';
    out_dirstr = 'output/figs_png_SZ3aqdrag_btm';
    % out_dirstr = 'output/figs_png_SZ3sedeco';
    % out_dirstr = 'output/figs_png_SZ3tmp_srf';
    % out_dirstr = 'output/figs_png_SZ3tmp_btm';
    
    LevelList = [-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130];
    
    % Nz=15; % Surface
    Nz=1; % Bottom (Sediment: surface layer)
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';
    x_arrow_txt = 2.8; y_arrow_txt=8.25;
    I_arrow_legend = 5; J_arrow_legend=20;
    v_legend = 0.5;
   
    if id==3 %wave
        scale=0.3;
        s_interval=7;
    else
        scale=3;
        s_interval=5;
    end

%==================== Yaeyama ==============================================
elseif CASE == 4      % Yaeyama1
    grd='D:\COAWST_DATA\Yaeyama\Yaeyama1\Grid\Yaeyama1_grd_v10.1.nc';
    % his=["F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_19940102.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_19950101.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_19960102.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_19970102.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_19980103.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_19990104.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20000104.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20010102.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20011231.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20021231.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20031221.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20040104.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20050104.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20060105.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20060302.nc"
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20070106.nc"      %<-Yaeyama1_his_20060302_00008.nc
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20080107.nc"      %<-Yaeyama1_his_20060302_00009.nc
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20080222.nc"      %<-Yaeyama1_his_20080222_00009.nc
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20090107.nc"      %<-Yaeyama1_his_20080222_00010.nc
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20100108.nc"      %<-Yaeyama1_his_20080222_00011.nc
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20110109.nc"      %<-Yaeyama1_his_20080222_00012.nc
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20120110.nc"      %<-Yaeyama1_his_20080222_00013.nc
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20130110.nc"      %<-Yaeyama1_his_20080222_00014.nc
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20140111.nc"      %<-Yaeyama1_his_20080222_00015.nc
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20150112.nc"      %<-Yaeyama1_his_20080222_00016.nc
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20160113.nc"      %<-Yaeyama1_his_20080222_00017.nc
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20170113.nc"      %<-Yaeyama1_his_20170113_00018.nc
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20180114.nc"      %<-Yaeyama1_his_20170113_00019.nc
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20180606.nc"      %<-Yaeyama1_his_20180606_00019.nc
    %      "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20190115.nc"      %<-Yaeyama1_his_20180606_00019.nc
    %      "E:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20200102.nc"      %<-Yaeyama1_his_20180606_00019.nc
    %      "E:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20201215.nc"      %<-Yaeyama1_his_20180606_00019.nc
    %      "E:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20220101.nc"      %<-Yaeyama1_his_20180606_00019.nc
    %      "E:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20220312.nc"      %<-Yaeyama1_his_20180606_00019.nc
    %      "E:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20230101.nc"      %<-Yaeyama1_his_20180606_00019.nc
    %      "E:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20230629.nc"      %<-Yaeyama1_his_20180606_00019.nc
    %      "E:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20231130.nc"  ];  %<-Yaeyama1_his_20180606_00020.nc
    his=["E:\COAWST_OUTPUT\Yaeyama\Y1Y2_nst_eco\Y1_his_nst_eco_20190801.nc"
         "E:\COAWST_OUTPUT\Yaeyama\Y1Y2_nst_eco\Y1_his_nst_eco_20190805.nc"];
    % Fqck=true;
    Fqck=false;
    qck=["E:\COAWST_OUTPUT\Yaeyama\Y1Y2_nst_eco\Y1_qck_nst_eco_20190801.nc"
         "E:\COAWST_OUTPUT\Yaeyama\Y1Y2_nst_eco\Y1_qck_nst_eco_20190805.nc"];
    Fdia=false;
    dia=["E:\COAWST_OUTPUT\Yaeyama\Y1Y2_nst_eco\Y1_dia_nst_eco_20190801.nc"
         "E:\COAWST_OUTPUT\Yaeyama\Y1Y2_nst_eco\Y1_dia_nst_eco_20190805.nc"];

    out_dirstr = 'output/figs_png_Y1_nst_srf_v2';
    % out_dirstr = 'output/figs_png_Y1_btm_v2';
    
    LevelList = [-1 1 10];

    Nz=15; % Surface
    % Nz=1; % Bottom (Sediment: surface layer)
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

    if id==3 % Wave direction
        scale=5;
        s_interval=7;
        % x_arrow_txt = 50; y_arrow_txt=230;
        % I_arrow_legend = 1; J_arrow_legend=25;
        % v_legend = 10;

    elseif id==100 % Wind
        scale=1;
        s_interval=5;
        x_arrow_txt = 50; y_arrow_txt=230;
        I_arrow_legend = 1; J_arrow_legend=25;
        v_legend = 20;
    else % Water Velocity
        scale=10;
        s_interval=6;
        x_arrow_txt = 5; y_arrow_txt=205;
        d_arrow_txt = -18;
        v_legend = 2;
    end
    
elseif CASE == 5  % Yaeyama2
    grd = 'D:/COAWST_DATA/Yaeyama/Yaeyama2/Grid/Yaeyama2_grd_v11.3.nc';
    % his = [ "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_19940110.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_19950110.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_19960110.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_19960731.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_19960802.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_19970801.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_19980801.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_19990801.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20000801.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20010731.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20020731.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20030731.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20040731.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20040823.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20040826.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20050718.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20060718.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20060915.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20060919.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20070917.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20070919.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20071003.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20071005.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20071008.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20080912.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20080914.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20090913.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20100402.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20110402.nc" %29
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20120401.nc" %30
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20120928.nc" %31
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20120930.nc" %32
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20130930.nc" %33
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20140930.nc" %34
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20150823.nc" %35
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20150825.nc" %36
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20150928.nc" %37
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20150930.nc" %38
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20160927.nc" %39
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20160929.nc" %40
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20170306.nc" %41
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20170913.nc" %42
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20170916.nc" %43
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20180916.nc" %44
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20190916.nc" %45
    %         "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20200102.nc" %46
    %         "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20210101.nc" %47
    %         "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20220101.nc" %48
    %         "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20220912.nc" %49
    %         "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20220914.nc" %50
    %         "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20231031.nc" ];%51
    % his = [ "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_19970801.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_19980801.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_19990801.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20000801.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20010731.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20020731.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20030731.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20040731.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20040823.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20040826.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20050718.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20060718.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20060915.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20060919.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20070917.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20070919.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20071003.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20071005.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20071008.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20080912.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20080914.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20090913.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20100402.nc"
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20110402.nc" %29
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20120401.nc" %30
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20120928.nc" %31
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20120930.nc" %32
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20130930.nc" %33
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20140930.nc" %34
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20150823.nc" %35
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20150825.nc" %36
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20150928.nc" %37
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20150930.nc" %38
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20160927.nc" %39
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20160929.nc" %40
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20170306.nc" %41
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20170913.nc" %42
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20170916.nc" %43
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20180916.nc" %44
    %         "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20190916.nc" %45
    %         "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20200102.nc" %46
    %         "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20210101.nc" %47
    %         "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20220101.nc" %48
    %         "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20220912.nc" %49
    %         "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20220914.nc" %50
    %         "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20231031.nc" ];%51
    his=["E:\COAWST_OUTPUT\Yaeyama\Y1Y2_nst_eco\Y2_his_nst_eco_20190801.nc"
         "E:\COAWST_OUTPUT\Yaeyama\Y1Y2_nst_eco\Y2_his_nst_eco_20190805.nc"];
    % Fqck=true;
    Fqck=false;
    qck=["E:\COAWST_OUTPUT\Yaeyama\Y1Y2_nst_eco\Y2_qck_nst_eco_20190801.nc"
         "E:\COAWST_OUTPUT\Yaeyama\Y1Y2_nst_eco\Y2_qck_nst_eco_20190805.nc"];
    Fdia=false;
    dia=["E:\COAWST_OUTPUT\Yaeyama\Y1Y2_nst_eco\Y2_dia_nst_eco_20190801.nc"
         "E:\COAWST_OUTPUT\Yaeyama\Y1Y2_nst_eco\Y2_dia_nst_eco_20190805.nc"];

    out_dirstr = 'output/figs_png_Y2_nst_srf_v2';  % Surface
    % out_dirstr = 'output/figs_png_Y2_btm_v2';  % Bottom
    
    LevelList = [-1 1 10];
    
    Nz=15; % Surface
    % Nz=1; % Bottom (Sediment: surface layer)
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

    scale=4;
    s_interval=6;
    Vmax = 3;

    x_arrow_txt = 20; y_arrow_txt=43;
    I_arrow_legend = 13; J_arrow_legend=23;
    d_arrow_txt = -2;
    v_legend = 1;


elseif CASE == 6  % Yaeyama3
    grd="D:\COAWST_DATA\Yaeyama\Yaeyama3\Grid\Yaeyama3_grd_v12.2.nc";
    % his=["L:\COAWST_OUTPUT\Yaeyama3\Yaeyama3_his_20150501.nc"
    %      "L:\COAWST_OUTPUT\Yaeyama3\Yaeyama3_his_20150807.nc"
    %      "L:\COAWST_OUTPUT\Yaeyama3\Yaeyama3_his_20150809.nc"
    %      "L:\COAWST_OUTPUT\Yaeyama3\Yaeyama3_his_20150823.nc"
    %      "L:\COAWST_OUTPUT\Yaeyama3\Yaeyama3_his_20150825.nc"
    %      "L:\COAWST_OUTPUT\Yaeyama3\Yaeyama3_his_20150928.nc"
    %      "L:\COAWST_OUTPUT\Yaeyama3\Yaeyama3_his_20150930.nc"];
    his=["L:\COAWST_OUTPUT\Yaeyama3\Yaeyama3_his_20160501.nc"
         "L:\COAWST_OUTPUT\Yaeyama3\Yaeyama3_his_20160927.nc"
         "L:\COAWST_OUTPUT\Yaeyama3\Yaeyama3_his_20160929.nc" ];
    Fqck=false;
    Fdia=false;

    out_dirstr = 'output/figs_png_Y3_srf';
    % out_dirstr = 'output/figs_png_Y3_btm';
    
    LevelList = [-1 1 10];
    
    Nz=15; % Surface
    % Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

    scale=2;
    s_interval=6;
    Vmax = 3;

    x_arrow_txt = 1; y_arrow_txt=20;
    I_arrow_legend = 4; J_arrow_legend=32;
    v_legend = 0.5;
   
    
    
elseif CASE == 7  % SHIRAHO_REEF
    % grd="D:\COAWST_DATA\Yaeyama\Shiraho_reef2\Grid\shiraho_roms_grd_HYCOM_v17.0.nc";
   grd="D:\COAWST_DATA\Yaeyama\Shiraho_reef2\Grid\shiraho_roms_grd_JCOPET_v18.1.nc";

% % 2009-08
    % his=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2\Shiraho_his_20090815v2.nc"  ];
% % 2010-05
    % his=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2\Shiraho_his_20100510v2.nc"  ];
% 2010-08
    % his=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2\Shiraho_his_20100815v2.nc"  ];
% % 2011-01
    % his=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2\Shiraho_his_20110115v3.nc"  ];
% % 2011-08
%     his=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2\Shiraho_his_20110815.nc"  
%          "E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2\Shiraho_his_20110827.nc"
%          "E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2\Shiraho_his_20110829.nc"
%          "E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2\Shiraho_his_20110831.nc"  ];
% % 2018-10
%     his=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2\Shiraho_his_20181010.nc"  ];
% % 2022-11
%     his=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2\Shiraho_his_20221120.nc"  ];
% % 2023-10
%     his=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2\Shiraho_his_20231001.nc"  
%          "E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2\Shiraho_his_20231003.nc"
%          "E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2\Shiraho_his_20231005.nc"
%          "E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2\Shiraho_his_20231007.nc"  ];
% % 2023-10
%     his=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2_eco\SR_eco_his_20231007.nc"  ];
%     Fqck=false;
%     % Fqck=true;
%     qck=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2_eco\SR_eco_qck_20231007.nc"];
%     % Fdia=false;
%     Fdia=true;
%     dia=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2_eco\SR_eco_dia_20231007.nc"];
    % his=["../Projects/Shiraho_reef2_eco/SR_veg_eco2_sg_his_20231007_v5.nc"  ];
    his=["../Projects/Shiraho_reef2_eco/SR_veg_eco2_nosg_his_20231007_v5.nc"  ];
    Fqck=false;
    % Fqck=true;
    qck=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2_eco\SR_eco_qck_20231007.nc"];
    Fdia=false;
    % Fdia=true;
    dia=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2_eco\SR_eco_dia_20231007.nc"];

%     out_dirstr = 'output/figs_png_Y2btm3';  % Bottom
    % out_dirstr = 'output/figs_png_SR_wave_201101_v2';  % Surface
    % out_dirstr = 'output/figs_png_SR_sg_v5';  % Surface
    out_dirstr = 'output/figs_png_SR_nosg_v5';  % Surface
    % out_dirstr = 'output/figs_png_SR_bstrcwmax_201101_v2';  % Surface
    
    LevelList = [-1 0.2 0.5 3];
    
    % Nz=8; % Surface
    Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';


    if id==3 % Wave direction
        scale=0.1;
        s_interval=4;
        % x_arrow_txt = 50; y_arrow_txt=230;
        % I_arrow_legend = 1; J_arrow_legend=25;
        % v_legend = 10;

    elseif id==100 % Wind
        scale=1;
        s_interval=5;
        x_arrow_txt = 50; y_arrow_txt=230;
        I_arrow_legend = 1; J_arrow_legend=25;
        v_legend = 20;
    else % Water Velocity
        scale=0.8; % surf
        % scale=1.5; % bottom
        s_interval=3;
        x_arrow_txt = 0.0; y_arrow_txt=6.2;
        I_arrow_legend = 2; J_arrow_legend=44;
        v_legend = 1;
    end
%==================== Panay ==============================================
elseif CASE == 8      % Panay0
    grd='D:\COAWST_DATA\Panay\Panay0\Grid\Panay0_grd_v1.0.nc';
    his=["E:\COAWST_OUTPUT\Panay\Panay0\roms\Panay0_sed_his_20230102.nc"];
    Fqck=false;
    % Fqck=true;
    qck=["E:\COAWST_OUTPUT\Panay\Panay0\roms\Panay0_sed_qck_20230102.nc"];
    Fdia=false;
    % Fdia=true;
    dia=["E:\COAWST_OUTPUT\Panay\Panay0\roms\Panay0_sed_dia_20230102.nc"];

    out_dirstr = 'output/figs_png_PNY0srf_2023';
    
    LevelList = [-10 0 250 500 750 1000 1250 1500 1750 2000];
    
    Nz=15; % Surface
%     Nz=1; % Bottom
    unit = 'km'; 

    scale=10;
    s_interval=4;

    x_arrow_txt = 165; y_arrow_txt=85;
    I_arrow_legend = 31; J_arrow_legend=10;
    v_legend = 1;

elseif CASE == 9  % Panay1
    grd='D:/COAWST_DATA/Panay/Panay1/Grid/Panay1_grd_v1.4.nc';
%     his=["E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210107.nc"
%          "E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210227.nc"
%          "E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210514.nc"];
%     his=["E:\COAWTS_OUTPUT\Boracay3\Boracay3_his_20210808.nc"];
    his=["E:/COAWST_OUTPUT/Panay/Panay1/Panay1_sed_wav_his_20230201.nc"
         "E:/COAWST_OUTPUT/Panay/Panay1/Panay1_sed_wav_his_20231001.nc"];
    Fqck=false;
    % Fqck=true;
    qck=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2_eco\SR_eco_qck_20231007.nc"];
    Fdia=false;
    % Fdia=true;
    dia=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2_eco\SR_eco_dia_20231007.nc"];

    out_dirstr = 'output/figs_png_PNY1srf_2023';
%     out_dirstr = 'output/figs_png_PNY1btm';
    
    LevelList = [-5 5 10 100 200 300 400 500 600 700 800 900 1000];
    
    Nz=15; % Surface
%     Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

    if id==3 %wave
        scale=1.5;
        s_interval=7;
    else
        scale=3;
        s_interval=5;
        x_arrow_txt = 30; y_arrow_txt=32;
        I_arrow_legend = 30; J_arrow_legend=1;
        v_legend = 1.0;   
    end

    
elseif CASE == 10  % Tangalan
    grd='D:/COAWST_DATA/Panay/Tangalan/Grid/Tangalan_grd_v2.1.nc';

%     his=["E:/COAWTS_OUTPUT/Panay/Tangalan/Tangalan_sed_wav_his_20210107.nc"
%          "E:/COAWTS_OUTPUT/Panay/Tangalan/Tangalan_sed_wav_his_20211010.nc"];
    his=["E:/COAWST_OUTPUT/Panay/Tangalan/Tangalan_sed_wav_his_20230210.nc"
         "E:/COAWST_OUTPUT/Panay/Tangalan/Tangalan_sed_wav_his_20231001.nc"];
    Fqck=false;
    % Fqck=true;
    qck=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2_eco\SR_eco_qck_20231007.nc"];
    Fdia=false;
    % Fdia=true;
    dia=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2_eco\SR_eco_dia_20231007.nc"];

    out_dirstr = 'output/figs_png_TGLsrf_2023';
    % out_dirstr = 'output/figs_png_TGLbtm_2023';
    
    LevelList = [-5 0 1 3 5 10 100 200 300 400 500 600 700 800 900 1000];
    
    Nz=15; % Surface
    % Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

    if id==3 %wave
        scale=0.3;
        s_interval=7;
    else
        scale=0.7;
        s_interval=5;
        x_arrow_txt = 3.7; y_arrow_txt=5.5;
        I_arrow_legend = 15; J_arrow_legend=5;
        v_legend = 1.0;   
    end  

%==================== TokyoBay ==============================================
elseif CASE == 11  % TokyoBay1
    grd='D:\COAWST_DATA\Shizugawa\Shizugawa3\Grid\Shizugawa3_grd_v0.3b.nc';
    his=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa3_eco\SZ3_aqdrag_his_20230701.nc"];
    Fqck=false;
    % Fqck=true;
    qck=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa3_eco\SZ3_eco_qck_20210701v2.nc"];
    Fdia=false;
    % Fdia=true;
    dia=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa3_eco\SZ3_eco_dia_20210701v2.nc"];

    % out_dirstr = 'output/figs_png_SZ3noaqdrag_srf';
    out_dirstr = 'output/figs_png_SZ3aqdrag_btm';
    % out_dirstr = 'output/figs_png_SZ3sedeco';
    % out_dirstr = 'output/figs_png_SZ3tmp_srf';
    % out_dirstr = 'output/figs_png_SZ3tmp_btm';
    
    LevelList = [-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130];
    
    % Nz=15; % Surface
    Nz=1; % Bottom (Sediment: surface layer)
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';
    x_arrow_txt = 2.8; y_arrow_txt=8.25;
    I_arrow_legend = 5; J_arrow_legend=20;
    v_legend = 0.5;
   
    if id==3 %wave
        scale=0.3;
        s_interval=7;
    else
        scale=3;
        s_interval=5;
    end

elseif CASE == 12  % TokyoBay2
    grd='D:\COAWST_DATA\Shizugawa\Shizugawa3\Grid\Shizugawa3_grd_v0.3b.nc';
    his=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa3_eco\SZ3_aqdrag_his_20230701.nc"];
    Fqck=false;
    % Fqck=true;
    qck=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa3_eco\SZ3_eco_qck_20210701v2.nc"];
    Fdia=false;
    % Fdia=true;
    dia=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa3_eco\SZ3_eco_dia_20210701v2.nc"];

    % out_dirstr = 'output/figs_png_SZ3noaqdrag_srf';
    out_dirstr = 'output/figs_png_SZ3aqdrag_btm';
    % out_dirstr = 'output/figs_png_SZ3sedeco';
    % out_dirstr = 'output/figs_png_SZ3tmp_srf';
    % out_dirstr = 'output/figs_png_SZ3tmp_btm';
    
    LevelList = [-10 0 10 20 30 40 50 60 70 80 90 100 110 120 130];
    
    % Nz=15; % Surface
    Nz=1; % Bottom (Sediment: surface layer)
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';
    x_arrow_txt = 2.8; y_arrow_txt=8.25;
    I_arrow_legend = 5; J_arrow_legend=20;
    v_legend = 0.5;
   
    if id==3 %wave
        scale=0.3;
        s_interval=7;
    else
        scale=3;
        s_interval=5;
    end

elseif CASE == 13  % TokyoBay3
    grd='D:/COAWST_DATA/TokyoBay/tky3/TDA/present_set/grd/TokyoBay3_grd_v3.2.nc';
    % his=["../../TSUBAME/gs1/nakamura/COAWST/COAWST_OUTPUT/TokyoBay/TDA/present_set/TB3_eco_offline_his_20180615_sed1.nc"
    %      "../../TSUBAME/gs1/nakamura/COAWST/COAWST_OUTPUT/TokyoBay/TDA/present_set/TB3_eco_offline_his_20180718_sed1_2.nc"];
    his=["../../TSUBAME/gs1/nakamura/COAWST/COAWST_OUTPUT/TokyoBay/TDA/present_set/TB3_eco_offline_his_20180615_sed2.nc"
         "../../TSUBAME/gs1/nakamura/COAWST/COAWST_OUTPUT/TokyoBay/TDA/present_set/TB3_eco_offline_his_20180718_sed2_2.nc"];
    % his='E:/COAWST_OUTPUT/TokyoBay/TDA/present_set/TB3_eco_offline_dia_20180718_sed2_2.nc';
    % his='E:/COAWST_OUTPUT/TokyoBay/TDA/present_set/TB3_eco_offline_dia_20180718_sed1_2.nc';
    % his='E:/COAWST_OUTPUT/TokyoBay/TDA/present_set/TB3_eco_offline_dia_20180718_sed2_2.nc';
    Fqck=false;
    % Fqck=true;
    qck=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa3_eco\SZ3_eco_qck_20210701v2.nc"];
    Fdia=false;
    % Fdia=true;
    dia=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa3_eco\SZ3_eco_dia_20210701v2.nc"];

    % out_dirstr = 'output/figs_png_TB3_sed1';
    out_dirstr = 'output/figs_png_TB3_sed2';
    
    LevelList = [-1 1 10 20 50 100 500 1000 5000];
    
    % Nz=30; % Surface
    Nz=1; % Bottom (Sediment: surface layer)
    % unit = 'km'; 
%          'm', 'latlon'
    unit = 'latlon';
    x_arrow_txt = 2.8; y_arrow_txt=8.25;
    I_arrow_legend = 5; J_arrow_legend=20;
    v_legend = 0.5;
   
    if id==3 %wave
        scale=0.3;
        s_interval=7;
    else
        scale=3;
        s_interval=5;
    end

%==================== Palau ==============================================
elseif CASE == 14      % Palau1
    grd='D:/COAWST_DATA/Palau/Palau1/Grid/Palau1_grd_v1.0.nc';
    % his=["E:\COAWST_OUTPUT\Palau\Palau1\P1_his_20230102.nc"
    %      "E:\COAWST_OUTPUT\Palau\Palau1\P1_his_20230728.nc"
    %      "E:\COAWST_OUTPUT\Palau\Palau1\P1_his_20230729.nc"
    %      "E:\COAWST_OUTPUT\Palau\Palau1\P1_his_20230911.nc"];
    % his=["E:\COAWST_OUTPUT\Palau\Palau1\P1_his_20230913.nc"];
    % his=["E:\COAWST_OUTPUT\Palau\Palau1\P1_his_20240102.nc"];
    his=["E:\COAWST_OUTPUT\Palau\Palau1\P1_his_20240201.nc"];
    Fqck=false;
    Fdia=false;
    % out_dirstr = 'output/figs_png_SZ1wv';
    % out_dirstr = 'output/figs_png_SZ1tmp_btm';
    out_dirstr = 'output/figs_png_Palau1_srf_2024';
    
    LevelList = [-1 5 50];
    
    Nz=30; % Surface
    % Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

    if id==3 % Wave direction
        scale=5;
        s_interval=7;
    elseif id==100 % Wind
        scale=1;
        s_interval=5;
        x_arrow_txt = 300; y_arrow_txt=80;
        d_arrow_txt = -16;
        v_legend = 20;
    else % Water Velocity
        scale=10;
        s_interval=8;
        x_arrow_txt = 300; y_arrow_txt=80;
        d_arrow_txt = -16;
        v_legend = 3;
    end
    
elseif CASE == 15  % Palau2
    grd='D:/COAWST_DATA/Palau/Palau2/Grid/Palau2_grd_v1.1.nc';
    his=["E:\COAWST_OUTPUT\Palau\Palau2\P2_his_20240106.nc"];
    Fqck=false;
    % Fqck=true;
    qck=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa2\Shizugawa2_qck_20210601.nc"];
    Fdia=false;
    % Fdia=true;
    dia=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa2\Shizugawa2_dia_20210601.nc"];

    % out_dirstr = 'output/figs_png_Palau2_srf';
    out_dirstr = 'output/figs_png_Palau2_srf_Zoom';
      
    Nz=30; % Surface
    % Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

    LevelList = [-1 5 50];
    
    Nz=30; % Surface
    % Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

    if id==3 % Wave direction
        scale=5;
        s_interval=7;
    elseif id==100 % Wind
        scale=1;
        s_interval=5;
        x_arrow_txt = 150; y_arrow_txt=40;
        d_arrow_txt = -7;
        v_legend = 20;
    else % Water Velocity
    % Whole area
        % scale=5;
        % s_interval=15;
        % x_arrow_txt = 150; y_arrow_txt=40;
        % d_arrow_txt = -7;
        % v_legend = 2;

    % close up
        scale=3;
        s_interval=4;
        x_arrow_txt = 118; y_arrow_txt=105;
        d_arrow_txt = -2;
        v_legend = 2;
    end

%==================== FORP-JPN ==============================================
elseif CASE == 17  % FORP
    grd='D:\COAWST_DATA\FORP_offline\Grid\forp-jpn-south_grd_v1.1.nc';
    his=["F:\COAWST_OUTPUT\FORP_offline\FORP_eco_offline_his_20060110.nc"];
    Fqck=false;
    % Fqck=true;
    qck=["F:\COAWST_OUTPUT\FORP_offline\FORP_eco_offline_qck_20060110.nc"];
    Fdia=false;
    % Fdia=true;
    dia=["F:\COAWST_OUTPUT\FORP_offline\FORP_eco_offline_dia_20060110.nc"];

    % out_dirstr = 'output/figs_png_Palau2_srf';
    out_dirstr = 'output/figs_png_FORP_offine';
      
    Nz=30; % Surface
    % Nz=1; % Bottom
    % unit = 'km'; 
%          'm', 'latlon'
    unit = 'latlon';

    LevelList = [-1 0 1000 2000 3000 4000 5000 6000];
    

    if id==3 % Wave direction
        scale=5;
        s_interval=7;
    elseif id==100 % Wind
        scale=1;
        s_interval=5;
        x_arrow_txt = 150; y_arrow_txt=40;
        d_arrow_txt = -7;
        v_legend = 20;
    else % Water Velocity
    % Whole area
        scale=1;
        s_interval=10;
        x_arrow_txt = 150; y_arrow_txt=40;
        d_arrow_txt = -7;
        v_legend = 2;

    % close up
        % scale=3;
        % s_interval=4;
        % x_arrow_txt = 118; y_arrow_txt=105;
        % d_arrow_txt = -2;
        % v_legend = 2;
    end


%==================== Kushimoto ==============================================
elseif CASE == 18  % Kushimoto
    grd='D:/COAWST_DATA/Kushimoto/Grid/Kushimoto_grd_v0.1.nc';
    his=["F:\COAWST_OUTPUT\Kushimoto\Kushimoto_his_20100621.nc"];
    Fqck=false;
    % Fqck=true;
    qck=["F:\COAWST_OUTPUT\Kushimoto\Kushimoto_qck_20100621.nc"];
    Fdia=false;
    % Fdia=true;
    dia=["F:\COAWST_OUTPUT\Kushimoto\Kushimoto_dia_20100621.nc"];

    % out_dirstr = 'output/figs_png_Palau2_srf';
    out_dirstr = 'output/figs_png_Kushimoto_srf';
      
    Nz=15; % Surface
    % Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
    % unit = 'latlon';

    % LevelList = [-1 10 100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000];
    LevelList = [-1 5];
    

    if id==3 % Wave direction
        scale=5;
        s_interval=7;
    elseif id==100 % Wind
        scale=1;
        s_interval=5;
        x_arrow_txt = 150; y_arrow_txt=40;
        d_arrow_txt = -7;
        v_legend = 20;
    else % Water Velocity
    % Whole area
        scale=1.3;
        s_interval=10;
        x_arrow_txt = 3; y_arrow_txt=27;
        d_arrow_txt = -1;
        v_legend = 2;

    % close up
        % scale=3;
        % s_interval=4;
        % x_arrow_txt = 118; y_arrow_txt=105;
        % d_arrow_txt = -2;
        % v_legend = 2;
    end
%==========================================================================

end
%==========================================================================

[status, msg] = mkdir( out_dirstr )

LOCAL_TIME=' (UTC)';
%LOCAL_TIME=' (JST)';
%LOCAL_TIME=' (UTC+9)';
% LOCAL_TIME='';


% My color map
load('MyColormaps')
colormap6=superjet(128,'NuvibZctgyorWq');
colormap7=superjet(128,'xvbZctgyorWq');
colormap8=superjet(128,'vbwwrW');

% === for ID = 7 ===
% title='Sea surface temperature (^oC)'; cmin=10; cmax=30; colmap=colormap7; ncname='temp'; % Shizugawa summer
% title='Sea bottom temperature (^oC)'; cmin=10; cmax=30; colmap=colormap7; ncname='temp'; % Shizugawa summer
% title='Sea surface temperature (^oC)'; cmin=0; cmax=30; colmap=colormap6; ncname='temp'; % YAEYAMA1
% title='Sea surface temperature (^oC)'; cmin=6; cmax=12; colmap=jet(128); ncname='temp'; % YAEYAMA1
% title='Sea surface temperature (^oC)'; cmin=15; cmax=35; colmap=colormap7; ncname='temp'; % YAEYAMA long term surface
% title='Sea bottom temperature (^oC)'; cmin=15; cmax=35; colmap=colormap7; ncname='temp'; % YAEYAMA long term bottom
% title='Sea surface temperature (^oC)'; cmin=23; cmax=34; colmap=colormap7; ncname='temp'; % Shiraho surf
% title='Sea surface temperature (^oC)'; cmin=23; cmax=34; colmap=colormap7; ncname='temp'; % Pany
% title='Sea bottom temperature (^oC)'; cmin=23; cmax=34; colmap=colormap7; ncname='temp'; % Pany
% title='Sea surface temperature (^oC)'; cmin=22; cmax=33; colmap=colormap7; ncname='temp'; % Palau
% title='Sea bottom temperature (^oC)'; cmin=23; cmax=34; colmap=colormap7; ncname='temp'; % Palau
title='Sea surface temperature (^oC)'; cmin=19; cmax=31; colmap=colormap7; ncname='temp'; % Kushimoto

% title='Sea surface Salinity (psu)'; cmin=20; cmax=34.7; colmap=colormap7; ncname='salt';
% title='Sea surface Salinity (psu)'; cmin=30; cmax=34.0; colmap=colormap7; ncname='salt';

% title='Susupended Solid \phi=5um (kg m^-^3)'; cmin=0; cmax=0.01; colmap=colmap1; ncname='mud_01';
% title='Bottom SS (kg m^-^3)'; cmin=0; cmax=0.005; colmap=colormap7; ncname='mud_01';
% title='Bottom SS (kg m^-^3)'; cmin=0; cmax=0.1; colmap=colormap7; ncname='mud_02';

% title='DO (umol L^-^1)'; cmin=150; cmax=350; colmap=flipud(colormap7); ncname='DO';
% title='Bottom DO (umol L^-^1)'; cmin=0; cmax=300; colmap=flipud(jet(128)); ncname='DO';
% title='pH'; cmin=7.8; cmax=8.2; colmap=colormap7; ncname='pH';
% title='Sea bottom aragonite saturation state'; cmin=1.5; cmax=3.5; colmap=colormap7; ncname='Omega_arg';
% title='Sea bottom calcite saturation state'; cmin=2.5; cmax=5; colmap=colormap7; ncname='Omega_cal';
% title='Surface S0 (umol L^-^1)'; cmin=0; cmax=500; colmap=colormap7; ncname='S0_01';
% title='Surface Phytoplankton (umolC L^-^1)';  cmin=0; cmax=500; colmap=colormap7; ncname='PhyC02_01';

% title='Labile POC (umolC L^-^1)';  cmin=0; cmax=5; colmap=colormap7; ncname='POC01_01';
% title='Labile PO^1^3C (umolC L^-^1)'; cmin=0; cmax=0.00001; colmap=colormap7; ncname='POC01_02';
% title='Labile PON (umolN L^-^1)';  cmin=0; cmax=1; colmap=colormap7; ncname='PON01_01';
% title='Labile PO^1^5N (umolN L^-^1)'; cmin=0; cmax=0.000003; colmap=colormap7; ncname='PON01_02';
% title='Labile POP (umolP L^-^1)';  cmin=0; cmax=0.05; colmap=colormap7; ncname='POP01_01';
% title='Labile PO^tP (umolP L^-^1)'; cmin=0; cmax=0.0000001; colmap=colormap7; ncname='POP01_02';

% title='Refractory POC (umolC L^-^1)';  cmin=0; cmax=5; colmap=colormap7; ncname='POC02_01';
% title='Refractory PO^1^3C (umolC L^-^1)'; cmin=0; cmax=0.00001; colmap=colormap7; ncname='POC02_02';
% title='Refractory PON (umolN L^-^1)';  cmin=0; cmax=1; colmap=colormap7; ncname='PON02_01';
% title='Refractory PO^1^5N (umolN L^-^1)'; cmin=0; cmax=0.000003; colmap=colormap7; ncname='PON02_02';
% title='Refractory POP (umolP L^-^1)';  cmin=0; cmax=0.05; colmap=colormap7; ncname='POP02_01';
% title='Refractory PO^tP (umolP L^-^1)'; cmin=0; cmax=0.0000001; colmap=colormap7; ncname='POP02_02';

% title='Coarse POC (umolC L^-^1)'; cmin=0; cmax=0.001; colmap=colormap7; ncname='POC03_01';
% title='Coarse PO^1^3C (umolC L^-^1)'; cmin=0; cmax=0.001; colmap=colormap7; ncname='POC03_02';
% title='Coarse PON (umolN L^-^1)'; cmin=0; cmax=1.0e-4; colmap=colormap7; ncname='PON03_01';
% title='Coarse PO^1^5N (umolN L^-^1)'; cmin=0; cmax=1.0e-4; colmap=colormap7; ncname='PON03_02';
% title='Coarse POP (umolP L^-^1)';  cmin=0; cmax=1.0e-5; colmap=colormap7; ncname='POP03_01';
% title='Coarse PO^tP (umolP L^-^1)'; cmin=0; cmax=1.0e-5; colmap=colormap7; ncname='POP03_02';

% title='Labile DOC (umolC L^-^1)';  cmin=0; cmax=50; colmap=colormap7; ncname='DOC01_01';
% title='Labile DO^1^3C (umolC L^-^1)'; cmin=0; cmax=0.00001; colmap=colormap7; ncname='DOC01_02';
% title='Labile DON (umolN L^-^1)';  cmin=0; cmax=1; colmap=colormap7; ncname='DON01_01';
% title='Labile DO^1^5N (umolN L^-^1)'; cmin=0; cmax=0.000003; colmap=colormap7; ncname='DON01_02';
% title='Labile DOP (umolP L^-^1)';  cmin=0; cmax=0.05; colmap=colormap7; ncname='DOP01_01';
% title='Labile DO^tP (umolP L^-^1)'; cmin=0; cmax=0.0000001; colmap=colormap7; ncname='DOP01_02';

% title='Refractory DOC (umolC L^-^1)';  cmin=0; cmax=60; colmap=colormap7; ncname='DOC02_01';
% title='Refractory DO^1^3C (umolC L^-^1)'; cmin=0; cmax=0.00001; colmap=colormap7; ncname='DOC02_02';
% title='Refractory DON (umolN L^-^1)';  cmin=0; cmax=1; colmap=colormap7; ncname='DON02_01';
% title='Refractory DO^1^5N (umolN L^-^1)'; cmin=0; cmax=0.000003; colmap=colormap7; ncname='DON02_02';
% title='Refractory DOP (umolP L^-^1)';  cmin=0; cmax=0.05; colmap=colormap7; ncname='DOP02_01';
% title='Refractory DO^tP (umolP L^-^1)'; cmin=0; cmax=0.0000001; colmap=colormap7; ncname='DOP02_02';

% title='TA (umol kg^-^1)'; cmin=2000; cmax=2350; colmap=colormap7; ncname='TA';
% title='DIC (umol kg^-^1)'; cmin=1750; cmax=2150; colmap=colormap7; ncname='DIC_01';
% title='DI^1^3C (umol kg^-^1)'; cmin=0; cmax=0.0001; colmap=colormap7; ncname='DIC_02';

% title='Dinoflagellate (umolC L^-^1)';  cmin=0; cmax=3; colmap=jet(128); ncname='PhyC01_01';
% title='^1^3C in Dinoflagellate (umolC L^-^1)'; cmin=0; cmax=0.000001; colmap=colmap1; ncname='PhyC01_02';

% title='Diatom (umolC L^-^1)';  cmin=0; cmax=0.05; colmap=jet(128); ncname='PhyC02_01';
% title='^1^3C in Diatom (umolC L^-^1)'; cmin=0; cmax=0.00001; colmap=colmap1; ncname='PhyC02_02';

% title='Coccolithophorids (umolC L^-^1)';  cmin=0; cmax=10; colmap=jet(128); ncname='PhyC03_01';
% title='^1^3C in Coccolithophorids (umolC L^-^1)'; cmin=0; cmax=0.00001; colmap=colmap1; ncname='PhyC03_02';

% title='Zooplankton C biomass (umolC L^-^1)';  cmin=0; cmax=1; colmap=colormap7; ncname='ZooC01_01';
% title='Zooplankton ^1^3C biomass (umolC L^-^1)'; cmin=0; cmax=1.0e-8; colmap=colormap7; ncname='ZooC01_02';
% title='Zooplankton N biomass (umolN L^-^1)';  cmin=0; cmax=0.1; colmap=colormap7; ncname='ZooN01_01';
% title='Zooplankton ^1^5N biomass (umolN L^-^1)'; cmin=0; cmax=5.0e-9; colmap=colormap7; ncname='ZooN01_02';
% title='Zooplankton P biomass (umolP L^-^1)';  cmin=0; cmax=0.01; colmap=colormap7; ncname='ZooP01_01';
% title='Zooplankton ^tP biomass (umolP L^-^1)'; cmin=0; cmax=5.0e-10; colmap=colormap7; ncname='ZooP01_02';

% title='Surface NO_3 (umolN L^-^1)';  cmin=0; cmax=10; colmap=colormap7; ncname='NO3_01';
% title='Surface PO_4 (umolP L^-^1)';  cmin=0; cmax=0.5; colmap=colormap7; ncname='PO4_01';
% title='Surface ^tPO_4 (umolP L^-^1)';  cmin=0; cmax=0.000001; colmap=colormap7; ncname='PO4_02';
% title='Bottom PO_4 (umolP L^-^1)';  cmin=0; cmax=1; colmap=colormap7; ncname='PO4_01';
% title='Bottom ^tPO_4 (umolP L^-^1)';  cmin=0; cmax=1; colmap=colormap7; ncname='PO4_02';
% title='Phytoplankton (umolC L^-^1)';  cmin=0; cmax=0.3; colmap=colormap7; ncname='PhyC02_01';


% title='Sediment DO (umol L^-^1; surface layer)'; cmin=100; cmax=250; colmap=colormap7; ncname='sediment_O2'; % Sediment model
% title='Sediment POC (nmolC g^-^1; surface layer)'; cmin=0; cmax=570; colmap=colormap7; ncname='sediment_POCf'; % Sediment model
% title='Sediment RPO^1^3C (nmolC g^-^1; surface layer)'; cmin=0; cmax=1e-6; colmap=colmap1; ncname='sediment_POC02_02'; % Sediment model

% === for ID = 8 ===
% title='DIN (umolN L^-^1)'; cmin=0; cmax=5; colmap=colormap7; ncname='DIN_01'; % ID =8
% title='DI^1^5N (umolN L^-^1)'; cmin=0; cmax=0.00001; colmap=colormap7; ncname='DIN_02'; % ID =8

% === for ID = 10 ===
% title='Sediment mass change (kg m^-^2)'; cmin=-0.002; cmax=0.002; colmap=colormap8; ncname='mudmass_01'; % Shiraho surf
% title='Sediment mass change (kg m^-^2)'; cmin=-3; cmax=3; colmap=colormap8; ncname='mudmass_02'; % Shiraho surf

% === for ID = 11 ===
% title='Max bottom stress (N m^-^2)'; cmin=0; cmax=30; colmap=colormap7; ncname='bstrcwmax'; % Shiraho surf

% === for ID = 12 ===
% title='Total Phytoplankton C biomass (umolC L^-^1)'; cmin=0; cmax=50; colmap=colormap7; ncname='PhyCtot_01'; % Shiraho surf
% title='Total Phytoplankton ^1^3C biomass (umolC L^-^1)'; cmin=0; cmax=0.000001; colmap=colormap7; ncname='PhyCtot_02'; % Shiraho surf
% title='Total Phytoplankton N biomass (umolN L^-^1)'; cmin=0; cmax=10; colmap=colormap7; ncname='PhyNtot_01'; % Shiraho surf
% title='Total Phytoplankton ^1^5N biomass (umolN L^-^1)'; cmin=0; cmax=0.00001; colmap=colormap7; ncname='PhyNtot_02'; % Shiraho surf
% title='Total Phytoplankton P biomass (umolP L^-^1)'; cmin=0; cmax=0.5; colmap=colormap7; ncname='PhyPtot_01'; % Shiraho surf
% title='Total Phytoplankton ^tP biomass (umolP L^-^1)'; cmin=0; cmax=0.000001; colmap=colormap7; ncname='PhyPtot_02'; % Shiraho surf

% === for ID = 13 ===
% title='Sg C biomass (mmolC m^-^2)'; cmin=0; cmax=8; colmap=colormap7; ncname='seagrass_SgCBm01_01'; % Shiraho surf
% title='Sg C biomass (mmolC m^-^2)'; cmin=0; cmax=2; colmap=colormap7; ncname='seagrass_SgCBm01_02'; % Shiraho surf
% title='Sg N biomass (mmolN m^-^2)'; cmin=0; cmax=1; colmap=colormap7; ncname='seagrass_SgNBm01_01'; % Shiraho surf
% title='Sg N biomass (mmolN m^-^2)'; cmin=0; cmax=0.5; colmap=colormap7; ncname='seagrass_SgNBm01_02'; % Shiraho surf
% title='Sg P biomass (mmolP m^-^2)'; cmin=0; cmax=0.03; colmap=colormap7; ncname='seagrass_SgPBm01_01'; % Shiraho surf
% title='Sg P biomass (mmolP m^-^2)'; cmin=0; cmax=0.01; colmap=colormap7; ncname='seagrass_SgPBm01_02'; % Shiraho surf


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

mask_u   = ncread(grd,'mask_u');
mask_v   = ncread(grd,'mask_v');
mask_rho   = ncread(grd,'mask_rho');
agl   = ncread(grd,'angle');

% p_coral_01 = ncread(grd,'p_coral_01');
% p_coral_02 = ncread(grd,'p_coral_02');
% p_sgrass_01 = ncread(grd,'p_sgrass_01');

[Im, Jm] = size(h);

c(1:Im,1:Jm)=0;
agl2 = agl(1:s_interval:Im,1:s_interval:Jm);

k=0;
i=1;

if CASE == 1      % Shizugawa1
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xsize=490; ysize=520;
elseif CASE == 2  % Shizugawa2
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=10;   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=84;
    xsize=360; ysize=620;
elseif CASE == 3  % Shizugawa3
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=0.7;   xmax=11.5;  ymin=1.5;   ymax=11;
    xsize=620; ysize=500;
elseif CASE == 4      % YAEYAMA1
    xmin=min(min(x_rho))-1;   xmax=max(max(x_rho))+1;  ymin=min(min(y_rho))-1;   ymax=max(max(y_rho))+1;
    xsize=640; ysize=520;
elseif CASE == 5  % YAEYAMA2
    xmin=min(min(x_rho))-0.3;   xmax=max(max(x_rho))+0.3;  ymin=min(min(y_rho))-0.3;   ymax=max(max(y_rho))+0.3;
    xsize=620; ysize=550;
elseif CASE == 6  % YAEYAMA3
    xmin=min(min(x_rho))-0.1;   xmax=max(max(x_rho))+0.1;  ymin=min(min(y_rho))-0.1;   ymax=max(max(y_rho))+0.1;
    xsize=640; ysize=520;
elseif CASE == 7  % SHIRAHO_REEF
    xmin=min(min(x_rho))-0.05;   xmax=max(max(x_rho))+0.05;  ymin=min(min(y_rho))-0.05;   ymax=max(max(y_rho))+0.05;
%     xsize=500; ysize=650; % for SHIRAHO zoom
%     xsize=250; ysize=500; % for SHIRAHO for Publish
    xsize=280; ysize=550; % for SHIRAHO for Animation
elseif CASE == 8      % Panay0
    % xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=24.5;   ymax=max(max(y_rho));
    xsize=620; ysize=500;
elseif CASE == 9  % Panay1
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=15;   ymax=max(max(y_rho));
    xsize=620; ysize=450;
elseif CASE == 10  % Tangalan
%     xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=2;   ymax=max(max(y_rho));
    xsize=620; ysize=490;
elseif CASE == 12  % TokyoBay2
    xmin=139.05;   xmax=140.15;  ymin=34.92;   ymax=35.7;
    xsize=780; ysize=500;
elseif CASE == 13  % TokyoBay3
    xmin=139.6;   xmax=140.13;  ymin=35.13;   ymax=35.7;
    xsize=550; ysize=650;
elseif CASE == 14  % Palau1
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xsize=630; ysize=600;
elseif CASE == 15  % Palau2
    % Whole area
    % xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    % xsize=730; ysize=700;
    % Close up
    xmin=80;   xmax=140;  ymin=50;   ymax=150;
    xsize=550; ysize=750;   
elseif CASE == 17  % FORP
    % Whole area
    % xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    % xsize=730; ysize=700;
    % Close up
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xsize=750; ysize=550;   
elseif CASE == 18  % Kushimoto
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xsize=780; ysize=520;   
else
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xsize=520; ysize=520;   
end

% xmin=min(min(x_rho))-0.01;   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
% xmin=123.6;   xmax=max(max(x_rho));  ymin=23.95;   ymax=max(max(y_rho));

% xmin=116;   xmax=max(max(x_rho));  ymin=-6.5;   ymax=max(max(y_rho));  % for Berau1
% xsize=400; ysize=700; % for Berau1

close all
% clear ubar vber ubar2 vbar2 ubar3 vbar3

mask_u = mask_u ./mask_u;
mask_v = mask_v ./mask_v;
mask_rho = mask_rho ./mask_rho;



tmp = zeros(size(x_rho));

% Down sampling
x_rho2=x_rho(1:s_interval:Im,1:s_interval:Jm);
y_rho2=y_rho(1:s_interval:Im,1:s_interval:Jm);
% ubar3=ubar2(1:s_interval:Im,1:s_interval:Jm);
% vbar3=vbar2(1:s_interval:Im,1:s_interval:Jm);
if F_drawUV
    x_rho2(1,1)=x_arrow_txt;
    y_rho2(1,1)=y_arrow_txt+d_arrow_txt;
end
ubar3=zeros(size(x_rho2));
vbar3=zeros(size(x_rho2));

date=ref_date;
date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);

if id==1 || id==2
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Velocity (m s^-^1)',0,0.6,colmap4,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 3
    ncname='Hs';
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Significant wave height (m)',0,2,colormap7,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList); %Shiraho
elseif id == 4
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Temperature (^oC)',3,24,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 5
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Water elevation (m)',-1.5,2.5,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 6
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Salinity (psu)',31,35,jet(128),xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id >= 7
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
elseif id == 100
    [h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,'Wind velocity (m s^-^1)',0,30,colmap4,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
end
% quiver(20,68,0.2*scale,0,0, ...
%     'Color', 'k',...
%     'AutoScale','off');
if F_drawUV
    if id==3
    else
        text(x_arrow_txt,y_arrow_txt,[num2str(v_legend), ' m s^-^1']);
    end
end

drawnow
%set(figure(1),'OuterPosition',[0 0 320 700])%[0 0 400 800]

for ihis=1:size(his,1)

    if id == 100
        time = ncread(his(ihis),'time');
    else
        time = ncread(his(ihis),'ocean_time');
    end
    imax=length(time);
    
    % for i=2:1:imax
    for i=1:1:imax
        if id <100
            date=ref_date+time(i)/24/60/60;
        else
            date=ref_date+time(i);
        end

        if date >= min_date && date <= max_date

            if id == 1
                ubar = ncread(his(ihis),'ubar',[1 1 i],[Inf Inf 1]);
                vbar = ncread(his(ihis),'vbar',[1 1 i],[Inf Inf 1]);
            elseif id == 2
                ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
                vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
            elseif id == 3
                dwave = ncread(his(ihis),'Dwave',[1 1 i],[Inf Inf 1]);
                tmp = ncread(his(ihis),'Hwave',[1 1 i],[Inf Inf 1]);
                ubar = cos(pi*dwave/180).*mask_rho;
                vbar = sin(pi*dwave/180).*mask_rho;
                if wet_dry == 1
                    wetdry_mask_rho = ncread(his(ihis),'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
                    wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
                    tmp = tmp .* wetdry_mask_rho;
                end
            elseif id == 4
                ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
                vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
                tmp = ncread(his(ihis),'temp',[1 1 Nz i],[Inf Inf 1 1]);  % Surface
            elseif id == 5
                ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
                vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
                tmp = ncread(his(ihis),'zeta',[1 1 i],[Inf Inf 1]).*mask_rho;
            elseif id == 6
                ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
                vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
                tmp = ncread(his(ihis),'salt',[1 1 Nz i],[Inf Inf 1 1]);  % Surface
            elseif id == 7
                if F_drawUV
                    ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
                    vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
                end
                if Fdia
                    tmp = ncread(dia(ihis),ncname,[1 1 Nz i-1],[Inf Inf 1 1]);
                elseif Fqck
                    tmp = ncread(qck(ihis),ncname,[1 1 Nz i],[Inf Inf 1 1]);
                else
                    tmp = ncread(his(ihis),ncname,[1 1 Nz i],[Inf Inf 1 1]);
                end
                if wet_dry == 1
                    wetdry_mask_rho = ncread(his(ihis),'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
                    wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
                    tmp = tmp .* wetdry_mask_rho;
                end
            elseif id == 8
                if F_drawUV
                    ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
                    vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
                end
                if Fdia
                    tmp = ncread(dia(ihis),ncname,[1 1 Nz i-1],[Inf Inf 1 1]);
                elseif Fqck
                    tmp = ncread(qck(ihis),ncname,[1 1 Nz i],[Inf Inf 1 1]);
                else
                    tmp =       ncread(his(ihis), replace(ncname,'DIN','NO3'), [1 1 Nz i],[Inf Inf 1 1]);
                    tmp = tmp + ncread(his(ihis), replace(ncname,'DIN','NH4'), [1 1 Nz i],[Inf Inf 1 1]);
                end
                if wet_dry == 1
                    wetdry_mask_rho = ncread(his(ihis),'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
                    wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
                    tmp = tmp .* wetdry_mask_rho;
                end
            elseif id == 9
                if F_drawUV
                    ubar = ncread(his(ihis),'u',[1 1 1 i],[Inf Inf 1 1]).*mask_u;
                    vbar = ncread(his(ihis),'v',[1 1 1 i],[Inf Inf 1 1]).*mask_v;
                end
                tmp = ncread(his(ihis),ncname,[1 1 i],[Inf Inf 1]);
                if wet_dry == 1
                    wetdry_mask_rho = ncread(his(ihis),'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
                    wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
                    tmp = tmp .* wetdry_mask_rho;
                end
    
            elseif id == 10
                ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
                vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
                tmp = ncread(his(ihis),ncname,[1 1 1 i],[Inf Inf 1 1]).*mask_rho;
                tmp = tmp - ncread(his(ihis),ncname,[1 1 1 i-48*3],[Inf Inf 1 1]).*mask_rho;
            elseif id == 11
                ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
                vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
                tmp = ncread(his(ihis),ncname,[1 1 i],[Inf Inf 1]).*mask_rho;

            elseif id == 12
                if F_drawUV
                    ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
                    vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
                end
                tmp =       ncread(his(ihis), replace(ncname,'tot','01'),[1 1 Nz i],[Inf Inf 1 1]);
                tmp = tmp + ncread(his(ihis), replace(ncname,'tot','02'),[1 1 Nz i],[Inf Inf 1 1]);
                tmp = tmp + ncread(his(ihis), replace(ncname,'tot','03'),[1 1 Nz i],[Inf Inf 1 1]);
                tmp = tmp + ncread(his(ihis), replace(ncname,'tot','04'),[1 1 Nz i],[Inf Inf 1 1]);
                if wet_dry == 1
                    wetdry_mask_rho = ncread(his(ihis),'wetdry_mask_rho',[1 1 i],[Inf Inf 1]);
                    wetdry_mask_rho = wetdry_mask_rho ./wetdry_mask_rho;
                    tmp = tmp .* wetdry_mask_rho;
                end
            elseif id == 13
                ubar = ncread(his(ihis),'u',[1 1 Nz i],[Inf Inf 1 1]).*mask_u;
                vbar = ncread(his(ihis),'v',[1 1 Nz i],[Inf Inf 1 1]).*mask_v;
                tmp = ncread(his(ihis),ncname,[1 1 i],[Inf Inf 1]).*mask_rho;
                tmp = tmp .* p_sgrass_01/1000;
            elseif id == 100
                ubar = ncread(his(ihis),'Uwind',[1 1 i],[Inf Inf 1]);
                vbar = ncread(his(ihis),'Vwind',[1 1 i],[Inf Inf 1]);
            end

    
            date_str=strcat(datestr(date,31),'  ',LOCAL_TIME);
    
            if id == 1 || id == 2
                ubar2(1:Im, 1:Jm)=NaN;
                ubar2(2:Im, 1:Jm)=ubar;%.*scale;
                vbar2(1:Im, 1:Jm)=NaN;
                vbar2(1:Im, 2:Jm)=vbar;%.*scale;
                tmp=hypot(ubar2,vbar2);
            elseif id == 3
                ubar2=ubar;
                vbar2=vbar;
                vel=tmp;
            elseif id == 100
                ubar2=ubar;
                vbar2=vbar;
                tmp=hypot(ubar2,vbar2);
            else
                if F_drawUV
                    ubar2(1:Im, 1:Jm)=NaN;
                    ubar2(2:Im, 1:Jm)=ubar;%.*scale;
                    vbar2(1:Im, 1:Jm)=NaN;
                    vbar2(1:Im, 2:Jm)=vbar;%.*scale;
                end
            end
    
            if F_drawUV
                % Down sampling
                ubar3=ubar2(1:s_interval:Im,1:s_interval:Jm);
                vbar3=vbar2(1:s_interval:Im,1:s_interval:Jm);
                if id==3
                    ubar4=ubar3;
                    vbar4=vbar3;
                else
                    ubar4=ubar3.*cos(agl2)-vbar3.*sin(agl2);
                    vbar4=ubar3.*sin(agl2)+vbar3.*cos(agl2);
        
                    ubar4(1,1)=v_legend;
                    vbar4(1,1)=0;
                end
            end
    
            set(h_surf,'CData',tmp)
            if F_drawUV
                set(h_quiver,'UData',ubar4*scale)
                set(h_quiver,'VData',vbar4*scale)
            end
            set(h_annot,'String',date_str)
    
            drawnow
    
            fname = strcat( ncname, datestr(date,'_yyyymmddHHMM') );
            exportgraphics(figure(1), strcat(out_dirstr,'/', fname,'.png'));
        %     exportgraphics(figure(1), strcat('output/figs_eps/', fname,'.eps'),hgexport('factorystyle'),'Format','eps');

        end
    end

end


