%addpath ('E:\Win7_MainPC\ROMS_results');
grd='D:\ROMS\Shiraho_reef\OA5_Ctrl\Data\shiraho_reef_grid11.nc';
his1='D:\ROMS\Shiraho_reef\OA5_Ctrl\ocean_his.nc';
his2='D:\ROMS\Shiraho_reef\OA5_HpCO2\ocean_his.nc';
his3='D:\ROMS\Shiraho_reef\OA5_HSL\ocean_his.nc';
his4='D:\ROMS\Shiraho_reef\OA5_HSL-HpCO2\ocean_his.nc';
his5='D:\ROMS\Shiraho_reef\OA5_MpCO2\ocean_his.nc';
his6='D:\ROMS\Shiraho_reef\OA5_MSL\ocean_his.nc';
his7='D:\ROMS\Shiraho_reef\OA5_MSL-MpCO2\ocean_his.nc';

Jm=192;   % Mm+2
Im=64;    % Lm+2

%i=17;j=33;
i=17;j=33;

%i=954;%954;%864,882,900,918,936

%time = nc_varget(his,'ocean_time',[i],[1]);
time1 = nc_varget(his1,'ocean_time');
time2 = nc_varget(his1,'ocean_time');
time3 = nc_varget(his1,'ocean_time');
time4 = nc_varget(his1,'ocean_time');
time5 = nc_varget(his1,'ocean_time');
time6 = nc_varget(his1,'ocean_time');
time7 = nc_varget(his1,'ocean_time');
dnum1=numel(time1);
dnum2=numel(time2);
dnum3=numel(time3);
dnum4=numel(time4);
dnum5=numel(time5);
dnum6=numel(time6);
dnum7=numel(time7);
%ubar = nc_varget(his,'ubar',[i,0 0],[1,Jm,Im-1]);
%vbar = nc_varget(his,'vbar',[i,0 0],[1,Jm-1,Im]);

zeta1 = nc_varget(his1,'zeta',[0 j i],[dnum1 1 1]);
zeta2 = nc_varget(his2,'zeta',[0 j i],[dnum2 1 1]);
zeta3 = nc_varget(his3,'zeta',[0 j i],[dnum3 1 1]);
zeta4 = nc_varget(his4,'zeta',[0 j i],[dnum4 1 1]);

coral_G1 = nc_varget(his1,'coral_G',[0 j i],[dnum1 1 1]);
coral_G2 = nc_varget(his2,'coral_G',[0 j i],[dnum2 1 1]);
coral_G3 = nc_varget(his3,'coral_G',[0 j i],[dnum3 1 1]);
coral_G4 = nc_varget(his4,'coral_G',[0 j i],[dnum4 1 1]);
coral_G5 = nc_varget(his5,'coral_G',[0 j i],[dnum4 1 1]);
coral_G6 = nc_varget(his6,'coral_G',[0 j i],[dnum4 1 1]);
coral_G7 = nc_varget(his7,'coral_G',[0 j i],[dnum4 1 1]);

coral_QC1 = nc_varget(his1,'coral_orgC',[0 j i],[dnum1 1 1]);
coral_QC2 = nc_varget(his2,'coral_orgC',[0 j i],[dnum2 1 1]);
coral_QC3 = nc_varget(his3,'coral_orgC',[0 j i],[dnum3 1 1]);
coral_QC4 = nc_varget(his4,'coral_orgC',[0 j i],[dnum4 1 1]);
coral_Pn1 = nc_varget(his1,'coral_Pn',[0 j i],[dnum1 1 1]);
coral_Pn2 = nc_varget(his2,'coral_Pn',[0 j i],[dnum2 1 1]);
coral_Pn3 = nc_varget(his3,'coral_Pn',[0 j i],[dnum3 1 1]);
coral_Pn4 = nc_varget(his4,'coral_Pn',[0 j i],[dnum4 1 1]);

Tau_ave1 = nc_varget(his1,'Tau_ave',[0 j i],[dnum1 1 1]);
Tau_ave2 = nc_varget(his2,'Tau_ave',[0 j i],[dnum2 1 1]);
Tau_ave3 = nc_varget(his3,'Tau_ave',[0 j i],[dnum3 1 1]);
Tau_ave4 = nc_varget(his4,'Tau_ave',[0 j i],[dnum4 1 1]);

%Hwave= nc_varget(his,'Hwave',[i,0,0],[1,Jm,Im]);
%Dwave= nc_varget(his,'Dwave',[i,0 0],[1,Jm,Im]); 
%temp = nc_varget(his,'temp',[i,7,0 0],[1,1,Jm,Im]);
%salt = nc_varget(his,'salt',[i,7,0 0],[1,1,Jm,Im]);
%mud_01= nc_varget(his,'mud_01',[i,7,0 0],[1,1,Jm,Im]);
%DIC  = nc_varget(his,'TIC',[i,7,0 0],[1,1,Jm,Im]);
TA1   = nc_varget(his1,'alkalinity',[0 7 j i],[dnum1 1 1 1]) ;
%DO   = nc_varget(his,'oxygen',[i,7,0 0],[1,1,Jm,Im]);
%DI13C    = nc_varget(his,'TI13C',[i,7,0 0],[1,1,Jm,Im]);
%d13C_DIC = nc_varget(his,'d13C_DIC',[i,7,0 0],[1,1,Jm,Im]);
%pH= nc_varget(his,'pH',[i,0 0],[1,Jm,Im]);
Warg1= nc_varget(his1,'Omega_arg',[0 j i],[dnum1 1 1]);
Warg2= nc_varget(his2,'Omega_arg',[0 j i],[dnum2 1 1]);
Warg3= nc_varget(his3,'Omega_arg',[0 j i],[dnum3 1 1]);
Warg4= nc_varget(his4,'Omega_arg',[0 j i],[dnum4 1 1]);
%pCO2= nc_varget(his,'pCO2',[i,0 0],[1,Jm,Im]);

%plot(time1,coral_G1, time2,coral_G2, time3,coral_G3, time4,coral_G4);
%plot(time1,Tau_ave1, time2,Tau_ave2, time3,Tau_ave3, time4,Tau_ave4);
%plot(time1,Warg1, time2,Warg2, time3,Warg3, time4,Warg4);
%plot(time1,coral_QC1, time2,coral_QC2, time3,coral_QC3, time4,coral_QC4);
plot(time1,coral_Pn1, time2,coral_Pn2, time3,coral_Pn3, time4,coral_Pn4);

Ctrl=mean2(coral_G1)
HpCO2=mean2(coral_G2)
HSL=mean2(coral_G3)
HpCO2pHSL=mean2(coral_G4)
MpCO2=mean2(coral_G5)
MSL=mean2(coral_G6)
MpCO2pMSL=mean2(coral_G7)

HpCO2/Ctrl*100
HSL/Ctrl*100
HpCO2pHSL/Ctrl*100
MpCO2/Ctrl*100
MSL/Ctrl*100
MpCO2pMSL/Ctrl*100

Ctrl=mean2(coral_Pn1)
HpCO2=mean2(coral_Pn2)
HSL=mean2(coral_Pn3)
HpCO2pHSL=mean2(coral_Pn4)
HpCO2/Ctrl*100
HSL/Ctrl*100
HpCO2pHSL/Ctrl*100

