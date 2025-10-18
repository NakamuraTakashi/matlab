%
% === Copyright (c) 2014-2024 Takashi NAKAMURA  =====
%  

% CASE 1=> Shizugawa1; 2=> Shizugawa2; 3=> Shizugawa3
% CASE 4=> Yaeyama1; 5=> Yaeyama2; 6=> Yaeyama3
% CASE 7=> Shiraho reef

CASE = 3;

F_drawUV = true;
% F_drawUV = false;
id = 2;  % <- Select 1,2,3,7,100 2=> uv velocity
% id = 3;  % <- Select 1,2,3,7,100 3=> Wave
% id = 7;  % <- Select 1,2,3,7,100
% id = 8;  % <- Select 1,2,3,7,100

% id = 100;  % <- Select 1,2,3,7,100

% wet_dry = 0;  % Dry mask OFF: 0, ON: 1
wet_dry = 1;  % Dry mask OFF: 0, ON: 1

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
    
    Nz=15; % Surface
    % Nz=1; % Bottom
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
    grd='D:\COAWST_DATA\Shizugawa\Shizugawa3\Grid\Shizugawa3_grd_v0.4c.nc';
    his=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa3_eco\SZ3_aqdrag_his_20230701.nc"];
    Fqck=false;
    % Fqck=true;
    qck=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa3_eco\SZ3_eco_qck_20210701v2.nc"];
    Fdia=false;
    % Fdia=true;
    dia=["E:\COAWST_OUTPUT\Shizugawa\Shizugawa3_eco\SZ3_eco_dia_20210701v2.nc"];

    % out_dirstr = 'output/figs_png_SZ3noaqdrag_srf';
    out_dirstr = 'output/figs_png_SZ3aq_dis';
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
    grd='D:\COAWST_DATA\Yaeyama\Yaeyama1\Grid\Yaeyama1_grd_v10.nc';
    his=["F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_19940102.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_19950101.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_19960102.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_19970102.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_19980103.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_19990104.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20000104.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20010102.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20011231.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20021231.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20031221.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20040104.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20050104.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20060105.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20060302.nc"
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20070106.nc"      %<-Yaeyama1_his_20060302_00008.nc
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20080107.nc"      %<-Yaeyama1_his_20060302_00009.nc
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20080222.nc"      %<-Yaeyama1_his_20080222_00009.nc
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20090107.nc"      %<-Yaeyama1_his_20080222_00010.nc
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20100108.nc"      %<-Yaeyama1_his_20080222_00011.nc
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20110109.nc"      %<-Yaeyama1_his_20080222_00012.nc
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20120110.nc"      %<-Yaeyama1_his_20080222_00013.nc
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20130110.nc"      %<-Yaeyama1_his_20080222_00014.nc
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20140111.nc"      %<-Yaeyama1_his_20080222_00015.nc
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20150112.nc"      %<-Yaeyama1_his_20080222_00016.nc
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20160113.nc"      %<-Yaeyama1_his_20080222_00017.nc
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20170113.nc"      %<-Yaeyama1_his_20170113_00018.nc
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20180114.nc"      %<-Yaeyama1_his_20170113_00019.nc
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20180606.nc"      %<-Yaeyama1_his_20180606_00019.nc
         "F:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20190115.nc"      %<-Yaeyama1_his_20180606_00019.nc
         "E:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20200102.nc"      %<-Yaeyama1_his_20180606_00019.nc
         "E:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20201215.nc"      %<-Yaeyama1_his_20180606_00019.nc
         "E:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20220101.nc"      %<-Yaeyama1_his_20180606_00019.nc
         "E:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20220312.nc"      %<-Yaeyama1_his_20180606_00019.nc
         "E:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20230101.nc"      %<-Yaeyama1_his_20180606_00019.nc
         "E:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20230629.nc"      %<-Yaeyama1_his_20180606_00019.nc
         "E:\COAWST_OUTPUT\Yaeyama\Yaeyama1\Yaeyama1_his_20231130.nc"  ];  %<-Yaeyama1_his_20180606_00020.nc
    Fqck=false;
    Fdia=false;

    out_dirstr = 'output/figs_png_Y1_srf';
    % out_dirstr = 'output/figs_png_Y1_btm';
    
    LevelList = [-1 1 10];

    Nz=15; % Surface
    % Nz=1; % Bottom
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
        x_arrow_txt = 12; y_arrow_txt=205;
        I_arrow_legend = 3; J_arrow_legend=22;
        v_legend = 2;
    end
    
elseif CASE == 5  % Yaeyama2
    grd = 'D:/COAWST_DATA/Yaeyama/Yaeyama2/Grid/Yaeyama2_grd_v11.2.nc';
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
    his = [ "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_19970801.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_19980801.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_19990801.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20000801.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20010731.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20020731.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20030731.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20040731.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20040823.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20040826.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20050718.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20060718.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20060915.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20060919.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20070917.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20070919.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20071003.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20071005.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20071008.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20080912.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20080914.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20090913.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20100402.nc"
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20110402.nc" %29
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20120401.nc" %30
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20120928.nc" %31
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20120930.nc" %32
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20130930.nc" %33
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20140930.nc" %34
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20150823.nc" %35
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20150825.nc" %36
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20150928.nc" %37
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20150930.nc" %38
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20160927.nc" %39
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20160929.nc" %40
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20170306.nc" %41
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20170913.nc" %42
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20170916.nc" %43
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20180916.nc" %44
            "L:/COAWST_OUTPUT/Yaeyama2/Yaeyama2_his_20190916.nc" %45
            "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20200102.nc" %46
            "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20210101.nc" %47
            "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20220101.nc" %48
            "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20220912.nc" %49
            "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20220914.nc" %50
            "E:/COAWST_OUTPUT/Yaeyama/Yaeyama2/Yaeyama2_his_20231031.nc" ];%51
    Fqck=false;
    Fdia=false;

    % out_dirstr = 'output/figs_png_Y2_srf';  % Surface
    out_dirstr = 'output/figs_png_Y2_btm';  % Bottom
    
    LevelList = [-1 1 10];
    
    % Nz=15; % Surface
    Nz=1; % Bottom
    unit = 'km'; 
%          'm', 'latlon'
%     unit = 'latlon';

    scale=4;
    s_interval=6;
    Vmax = 3;

    x_arrow_txt = 20; y_arrow_txt=43;
    I_arrow_legend = 13; J_arrow_legend=23;
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
   grd="D:\COAWST_DATA\Yaeyama\Shiraho_reef2\Grid\shiraho_roms_grd_JCOPET_v17.1.nc";

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
% 2023-10
    his=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2_eco\SR_eco_his_20231007.nc"  ];
    Fqck=false;
    % Fqck=true;
    qck=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2_eco\SR_eco_qck_20231007.nc"];
    % Fdia=false;
    Fdia=true;
    dia=["E:\COAWST_OUTPUT\Yaeyama\Shiraho_reef2_eco\SR_eco_dia_20231007.nc"];

%     out_dirstr = 'output/figs_png_Y2btm3';  % Bottom
    % out_dirstr = 'output/figs_png_SR_wave_201101_v2';  % Surface
    out_dirstr = 'output/figs_png_SR_eco_202310';  % Surface
    % out_dirstr = 'output/figs_png_SR_bstrcwmax_201101_v2';  % Surface
    
    LevelList = [-1 0.2 0.5 3];
    
    Nz=8; % Surface
    % Nz=1; % Bottom
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
end

%==========================================================================

[status, msg] = mkdir( out_dirstr )

%% 

starting_date=datenum(2000,1,1,0,0,0); % 


h          = ncread(grd,'h');
% p_coral    = ncread(grd,'p_coral');
% % p_coral2 = ncread(grd,'p_coral2');
% p_seagrass = ncread(grd,'p_seagrass');
% p_sand = ncread(grd,'p_sand');
% p_algae = ncread(grd,'p_algae');

if strcmp(unit,'latlon')
    y_rho = ncread(grd,'lat_rho');
    x_rho = ncread(grd,'lon_rho');
else

    x_rho = ncread(grd,'x_rho');
    y_rho = ncread(grd,'y_rho');

    x_corner_m = min(min(x_rho));
    y_corner_m = min(min(y_rho));
    x_rho=(x_rho - x_corner_m);
    y_rho=(y_rho - y_corner_m);

    if strcmp(unit,'km')
        x_rho=x_rho/1000;
        y_rho=y_rho/1000;
    end
end
xmin=min(min(x_rho));   xmax=max(max(x_rho));
ymin=min(min(y_rho));   ymax=max(max(y_rho));

mask_rho   = ncread(grd,'mask_rho');

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
else
    xmin=min(min(x_rho));   xmax=max(max(x_rho));  ymin=min(min(y_rho));   ymax=max(max(y_rho));
    xsize=520; ysize=520;   
end


% LOCAL_TIME='(UTC)';
% LOCAL_TIME='(JST)';
% LOCAL_TIME='(UTC+9)';
LOCAL_TIME='';

wet_dry = 1;  % Dry mask OFF: 0, ON: 1


[Im,Jm] = size(h);

c(1:Im,1:Jm)=0;

k=0;
i=1;


close all

% if id <100
% %time = ncread(his,'ocean_time',[i],[1]);
%     time = ncread(his,'ocean_time');
% else
%      time = ncread(his,'time');
% end

% imax=length(time);

% % coral masking
% coral_mask = (p_coral==0).*0+(p_coral>0).*1;
% coral_mask = coral_mask ./coral_mask;
% % coral2 masking
% coral2_mask = (p_coral2==0).*0+(p_coral2>0).*1;
% coral2_mask = coral2_mask ./coral2_mask;
% % seagrass masking
% sg_mask = (p_seagrass==0).*0+(p_seagrass>0).*1;
% sg_mask = sg_mask ./sg_mask;
% % algae masking
% ag_mask = (p_algae==0).*0+(p_algae>0).*1;
% ag_mask = ag_mask ./ag_mask;
% % sand masking
% sand_mask = (p_sand==0).*0+(p_sand>0).*1;
% sand_mask = sand_mask ./sand_mask;

mask_rho = mask_rho ./mask_rho;



% Down sampling
scale=8;
s_interval=8;
Vmax = 3;

x_rho2=x_rho(1:s_interval:Im,1:s_interval:Jm);
y_rho2=y_rho(1:s_interval:Im,1:s_interval:Jm);
x_rho2=x_rho(1:s_interval:Im,1:s_interval:Jm);
y_rho2=y_rho(1:s_interval:Im,1:s_interval:Jm);
% ubar3=ubar2(1:s_interval:Im,1:s_interval:Jm);
% vbar3=vbar2(1:s_interval:Im,1:s_interval:Jm);
ubar3=zeros(size(x_rho2));
vbar3=zeros(size(x_rho2));


% if id <100
%     date=starting_date+time(i+1)/24/60/60;
% else
%     date=starting_date+time(i+1);
% end
% 
date_str=strcat(datestr(starting_date,31),'  ',LOCAL_TIME);

% My color map
load('MyColormaps')
colormap6=superjet(128,'NuvibZctgyorWq');
% colormap7=superjet(128,'qhaoGUDylggtttZZZZbbbbiiiiiuuuuuuuuA');
colormap7=superjet(128,'xvbZctgyorWq');

data = ncread(grd,'h');
title='Bathymetry';
cmin=0; cmax=50;
tmp=data.*mask_rho;
colmap=colormap7;

% data = ncread(grd,'aquaculture_01');
% title='aquaculture01';
data = ncread(grd,'aquaculture_05');
title='aquaculture05';
cmin=0; cmax=0.2;
tmp=data.*mask_rho;
colmap=colormap7;

[h_quiver,h_surf,h_contour,h_annot]=createvplot7(x_rho,y_rho,tmp,x_rho2,y_rho2,ubar3,vbar3,h,scale,date_str,title,cmin,cmax,colmap,xsize,ysize,xmin,xmax,ymin,ymax,unit,LevelList);
% set(gca,'ColorScale','log')

drawnow
% hgexport(figure(1), 'output/figs_png/aq5.png',hgexport('factorystyle'),'Format','png');
hgexport(figure(1), strcat(out_dirstr,'/', title,'.png'),hgexport('factorystyle'),'Format','png');
% hgexport(figure(1), 'output/figs_eps\bathY3_2.eps',hgexport('factorystyle'),'Format','eps');

