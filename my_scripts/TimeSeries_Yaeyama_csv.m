temp_file='Yaeyama2_temp_i=147_j=136_Mbuoy.csv';
salt_file='Yaeyama2_salt_i=147_j=136_Mbuoy.csv';
% temp_file='Yaeyama2_temp_i=141_j=150_btm.csv';
% salt_file='Yaeyama2_salt_i=141_j=150_btm.csv';

swrad_file='Yaeyama2_swrad.csv';

temp=readmatrix(temp_file);
salt=readmatrix(salt_file);
swrad=readmatrix(swrad_file);

starting_date = datenum(2000,1,1,0,0,0);
temp(:,1)=starting_date+temp(:,1)/24/60/60; %sec-> day
salt(:,1)=starting_date+salt(:,1)/24/60/60; %sec-> day
swrad(:,1)=starting_date+swrad(:,1)/24/60/60; %sec-> day
% 
% imin = 1; imax = size(temp,1);
% ymin = 728000; ymax = 738000;
% datestr ='yyyy';

% ymin = datenum(2016,4,25,0,0,0); ymax = datenum(2016,12,5,0,0,0);
% datestr ='dd-mmm';
ymin = datenum(2016,7,20,0,0,0); ymax = datenum(2016,8,10,0,0,0);
datestr ='dd-mmm';

imin = find(temp(:,1)<ymin, 1, 'last' ); imax = find(temp(:,1)>ymax, 1 , 'first');

%% plot figure
figure('PaperSize',[20 30],...
    'Color',[1 1 1],...
    'GraphicsSmoothing','on',...
    'OuterPosition',[0 0 800 700]);  %[0 0 800 700]

subplot(3,1,1);
plot(swrad(imin:imax,1), swrad(imin:imax,2),'g');
datetick('x',datestr);
ylim([-50 1300]);
ylabel('Solar radiation (W m^-^2)')
ax = gca;
ax.XLim = [ymin,ymax];

hold on

subplot(3,1,2);
% subplot(2,1,1);
plot(temp(imin:imax,1), temp(imin:imax,2),'r');
datetick('x',datestr);
% ylim([17.5 33.5]);
% ylim([24.5 33.5]);
ylim([28.5 33.5]);
ylabel('Temperature (^oC)')
ax = gca;
ax.XLim = [ymin,ymax];

hold on

subplot(3,1,3);
% subplot(2,1,2);
plot(salt(imin:imax,1), salt(imin:imax,2),'b');
datetick('x',datestr);
% xlabel('Year')
xlabel('Date')
ylim([28.5 35.5]);
ylim([32.5 35.5]);
ylabel('Salinity (PSU)')
ax = gca;
ax.XLim = [ymin,ymax];
% ax.XTick = [datenum(1995,1,1,0,0,0),datenum(2000,1,1,0,0,0),datenum(2005,1,1,0,0,0),datenum(2010,1,1,0,0,0),datenum(2015,1,1,0,0,0),datenum(2020,1,1,0,0,0)];
% ax.XTickLabel = ["01-Jan-1995","01-Jan-2000","01-Jan-2005","01-Jan-2010","01-Jan-2015","01-Jan-2020"];

samexaxis('abc','xmt','on','ytac','join','yld',1)
