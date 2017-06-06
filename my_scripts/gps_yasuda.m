%
% === ver 2016/01/08   Copyright (c) 2016 Takashi NAKAMURA  =====
%                for MATLAB R2015a,b  

% UTM_zone = '51 R';          % UTM zone, e.g. '30 T', '32 T', '11 S', '28 R', '15 S', '51 R'
starting_date=datenum(2000,1,1,0,0,0);% for YAEYAMA1

id=1;

LOCAL_TIME='(UTC)';
%LOCAL_TIME='(JST)';
%LOCAL_TIME='(UTC+9)';
%LOCAL_TIME='';

grd='D:/ROMS/Yaeyama/Data/Yaeyama2_grd_v9.nc';
his='K:/ROMS/Yaeyama/Y2_14/ocean_his_Yaeyama2_140516.nc';

flt='K:/ROMS/Yaeyama/Y2_off_15/ocean_flt_Yaeyama2_150507_2.nc';

gps='C:\Users\Takashi\OneDrive\ドキュメント\推進費まとめ\gps_yasuda.csv';

fid=fopen('env_gps.csv','w');

T = readtable(gps);
h_scatter=scatter(T.E,T.N);

h          = ncread(grd,'h');
p_coral    = ncread(grd,'p_coral');
%p_seagrass = ncread(grd,'p_seagrass');
lat_rho    = ncread(grd,'lat_rho');
lon_rho    = ncread(grd,'lon_rho');
x_rho      = ncread(grd,'x_rho');
y_rho      = ncread(grd,'y_rho');
mask_rho   = ncread(grd,'mask_rho');

[Im,Jm] = size(h);
x_corner_m = min(min(x_rho));
y_corner_m = min(min(y_rho));
%c(1:Im,1:Jm)=0;
% x_rho=(x_rho - x_corner_m)/1000; % m->km
% y_rho=(y_rho - y_corner_m)/1000; % m->km
[x_gps, y_gps, UTM_zone]=deg2utm(T.N,T.E);
[Km,Lm]=size(T.N);
for k=1:Km;

    min_dx(k) =abs(x_gps(k)-x_rho(1,1));
    for i=2:Im
        dx = abs(x_gps(k)-x_rho(i,1));
        if min_dx(k) > dx
            Igps(k)=i;
            min_dx(k) = dx;
        end
    end

    min_dy(k) =abs(y_gps(k)-y_rho(1,1));
    for j=2:Jm
        dy = abs(y_gps(k)-y_rho(1,j));
        if min_dy(k) > dy
            Jgps(k)=j;
            min_dy(k) = dy;
        end
    end
    
    if mask_rho(Igps(k),Jgps(k))==0
        if mask_rho(Igps(k)+1,Jgps(k))==1
            Igps(k)=Igps(k)+1;
        elseif mask_rho(Igps(k)-1,Jgps(k))==1
            Igps(k)=Igps(k)-1;
        elseif mask_rho(Igps(k),Jgps(k)+1)==1
            Jgps(k)=Jgps(k)+1;
        elseif mask_rho(Igps(k),Jgps(k)-1)==1
            Jgps(k)=Jgps(k)-1;
        elseif mask_rho(Igps(k)+1,Jgps(k)+1)==1
            Igps(k)=Igps(k)+1;
            Jgps(k)=Jgps(k)+1;
        elseif mask_rho(Igps(k)+1,Jgps(k)-1)==1
            Igps(k)=Igps(k)+1;
            Jgps(k)=Jgps(k)-1;
        elseif mask_rho(Igps(k)-1,Jgps(k)-1)==1
            Igps(k)=Igps(k)-1;
            Jgps(k)=Jgps(k)-1;
        elseif mask_rho(Igps(k)-1,Jgps(k)+1)==1
            Igps(k)=Igps(k)-1;
            Jgps(k)=Jgps(k)+1;
        elseif mask_rho(Igps(k)+2,Jgps(k))==1
            Igps(k)=Igps(k)+2;
        elseif mask_rho(Igps(k)-2,Jgps(k))==1
            Igps(k)=Igps(k)-2;
        elseif mask_rho(Igps(k),Jgps(k)+2)==1
            Jgps(k)=Jgps(k)+2;
        elseif mask_rho(Igps(k),Jgps(k)-2)==1
            Jgps(k)=Jgps(k)-2;
        elseif mask_rho(Igps(k)+2,Jgps(k)+2)==1
            Igps(k)=Igps(k)+2;
            Jgps(k)=Jgps(k)+2;
        elseif mask_rho(Igps(k)+2,Jgps(k)-2)==1
            Igps(k)=Igps(k)+2;
            Jgps(k)=Jgps(k)-2;
        elseif mask_rho(Igps(k)-2,Jgps(k)-2)==1
            Igps(k)=Igps(k)-2;
            Jgps(k)=Jgps(k)-2;
        elseif mask_rho(Igps(k)-2,Jgps(k)+2)==1
            Igps(k)=Igps(k)-2;
            Jgps(k)=Jgps(k)+2;
        elseif mask_rho(Igps(k)+3,Jgps(k))==1
            Igps(k)=Igps(k)+3;
        elseif mask_rho(Igps(k)-3,Jgps(k))==1
            Igps(k)=Igps(k)-3;
        elseif mask_rho(Igps(k),Jgps(k)+3)==1
            Jgps(k)=Jgps(k)+3;
        elseif mask_rho(Igps(k),Jgps(k)-3)==1
            Jgps(k)=Jgps(k)-3;
        elseif mask_rho(Igps(k)+3,Jgps(k)+3)==1
            Igps(k)=Igps(k)+3;
            Jgps(k)=Jgps(k)+3;
        elseif mask_rho(Igps(k)+3,Jgps(k)-3)==1
            Igps(k)=Igps(k)+3;
            Jgps(k)=Jgps(k)-3;
        elseif mask_rho(Igps(k)-3,Jgps(k)-3)==1
            Igps(k)=Igps(k)-3;
            Jgps(k)=Jgps(k)-3;
        elseif mask_rho(Igps(k)-3,Jgps(k)+3)==1
            Igps(k)=Igps(k)-3;
            Jgps(k)=Jgps(k)+3;
        else
            disp('cannot found!!');
        end
    end
    

    Nz=15;
    tmp = ncread(his,'temp',[Igps(k) Jgps(k) Nz 1],[1 1 1 Inf]);
    avg_t(k)=mean(tmp);
    max_t(k)=max(tmp);
    min_t(k)=min(tmp);
    std_t(k)=std(tmp);

    tmp = ncread(his,'salt',[Igps(k) Jgps(k) Nz 1],[1 1 1 Inf]);
    avg_s(k)=mean(tmp);
    max_s(k)=max(tmp);
    min_s(k)=min(tmp);
    std_s(k)=std(tmp);

    u = ncread(his,'u',[Igps(k) Jgps(k) Nz 1],[1 1 1 Inf]);
    v = ncread(his,'v',[Igps(k) Jgps(k) Nz 1],[1 1 1 Inf]);
    u(isnan(u))=0;
    v(isnan(v))=0;
    tmp = sqrt(u.*u+v.*v);
    avg_v(k)=mean(tmp);
    max_v(k)=max(tmp);
    min_v(k)=min(tmp);
    std_v(k)=std(tmp);

    fprintf(fid,'%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f\r\n', avg_t(k),max_t(k),min_t(k),std_t(k),avg_s(k),max_s(k),min_s(k),std_s(k),avg_v(k),max_v(k),min_v(k),std_v(k),lat_rho(Igps(k),Jgps(k)),lon_rho(Igps(k),Jgps(k)),h(Igps(k),Jgps(k)) );   

end

fclose(fid) ;
