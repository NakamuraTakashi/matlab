%
%EASYGRID   Generates grid for ROMS.
%
%   This is a "quick-and-dirty" way to generate a grid for ROMS, as
%   well as a simple initial conditions file where specified values
%   are constant over the grid domain.
%
%   USAGE: Before running this script, you need to specify the 
%          parameters in the "USER SETTINGS" section of this code. Beside
%          each variable there are detailed instructions. NOTE the 
%          "SWITCHES" section, which turns ON or OFF different
%          functionalities of EASYGRID, for example: edit_mask turns on/off 
%          the mask-editing routine and smooth_grid turns on/off bathymetry 
%          smoothing. You probably will need to run EASYGRID several times in 
%          a iterative manner to create, smooth and mask-edit a grid. See
%          tutorial link below.       
%
%   TUTORIAL: https://www.myroms.org/wiki/index.php/easygrid
%   
%   DEPENDENCIES: MEXNC (specific for your architecture), SNCTOOLS
%                 and the ROMS Matlab toolkit.
%                 For a tutorial on how to download/install dependencies,
%                 see: https://www.myroms.org/wiki/index.php/MEXNC
%
%   LIMITATIONS: This script should NOT be used to generate GLOBAL grids.
%
%   OUTPUTS: 1) NetCDF file (.nc) with grid for ROMS (if save_grid is ON).
%            2) NetCDF file (.nc) with initial conditions (if save_init is ON).
%            3) Screen output of many parameters that need to be 
%               copy-pasted into the ocean.in file (if screen_output is ON).
%            4) Plot of the grid (if plot_grid is ON).
%            5) Mask-Editing interactive plot (if edit_mask is ON), 
%               to change sea-cells into land-cells and vice versa.
%
%   TESTING: After download, run EASYGRID with all the default parameters.
%            If working properly, EASYGRID should save two NetCDF files 
%            (grid and initialization files) for the ROMS "Fjord Tidal Case".
%            Also screen-output of grid parameters and a plot of the grid
%            should be generated.
%
%==================================================================
% DISCLAIMER:
%   This software is provided "as is" without warranty of any kind.  
%==================================================================
%                                     Version: 0 Date: 2008-Apr-24
%
%                      Written by: Diego A. Ibarra (dibarra@dal.ca)
%             with borrowed code from Katja Fennel and John Wilkin,
%                 and with help of many functions by Hernan Arango.
% 
%   See also   SMTH_BATH   SPHERIC_DIST   PCOLORJW.


%****************************************************************************************************************************************************
% USER SETTINGS *************************************************************************************************************************************
%****************************************************************************************************************************************************

% -------------------------------------------------------------------------
% SWITCHES ( ON = 1; OFF = 0 ) --------------------------------------------
% -------------------------------------------------------------------------
    create_grid = 1;   % Create GRID. Turn OFF to work with a previously created grid (i.e. grid variables existing on Workspace)
      plot_grid = 1;   % Plot grid
    smooth_grid = 0;   % Smooth bathymetry using H. Arango's smth_bath.m , which applies a Shapiro filter to the bathymetry
      edit_mask = 0;   % Edit rho-mask using interactive plot. Use this to manually change sea-pixels into land-pixels and vice-versa 
  screen_output = 1;   % Displays (on screen) many parameters that need to be copy-pasted in the ocean.in file    
      save_grid = 1;   % Save GRID in a NetCDF file
      save_init = 0;   % Create (and save) INITIAL CONDITIONS (from grid)
                       % ON = 1; OFF = 0
                       
% Setting for Yaeyama1 ----------------------------------------------------

          Bathy = 'data\Yaeyama1_fin3.asc';  % ESRI Arc/Info Grid ASCII Bathymetry file.
  Grid_filename = 'Yaeyama1'; 	   % Filename for grid and initial conditions files (don't include extension). 

  refine_factor = 0;   % Option for refine grid. If not refined: refine_factor = 0 


% Setting for Yaeyama2 ----------------------------------------------------

%          Bathy = 'data\Yaeyama2_fin3.asc';  % ESRI Arc/Info Grid ASCII Bathymetry file.
%  Grid_filename = 'Yaeyama2'; 	   % Filename for grid and initial conditions files (don't include extension). 
                               % "_grd.nc" is added to grid file and "_ini.nc" is added to initial conditions file
%  refine_factor = 5;   % Option for refine grid. If not refined: refine_factor = 0 
  
%    parent_grid = 'Yaeyama1_grd.nc' ;  % Option for refine grid
%    parent_Imin = 155;  % Option for refine grid
%    parent_Jmin = 60;  % Option for refine grid


% Setting for Yaeyama3 ----------------------------------------------------

%          Bathy = 'data\Yaeyama3_fin3.asc';  % ESRI Arc/Info Grid ASCII Bathymetry file.
%  Grid_filename = 'Yaeyama3'; 	   % Filename for grid and initial conditions files (don't include extension). 

%  refine_factor = 3;   % Option for refine grid. If not refined: refine_factor = 0 
  
%    parent_grid = 'Yaeyama2_grd.nc' ;  % Option for refine grid
%    parent_Imin = 91;  % Option for refine grid
%    parent_Jmin = 84;  % Option for refine grid
      
% -------------------------------------------------------------------------
% GRID SETTINGS -----------------------------------------------------------
% -------------------------------------------------------------------------
    NCOLS = 310;
    NROWS = 280;
XLLCORNER = 329037.5000000000;
YLLCORNER = 2560812.5000000000;
 CELLSIZE = 1500.000000;          % Cell size (meters)
NODATA_VALUE = -99999.0000;
 UTM_zone = '51 R';          % UTM zone, e.g. '30 T', '32 T', '11 S', '28 R', '15 S', '51 R'
        X = NCOLS*CELLSIZE;  % Width of domain (meters)
        Y = NROWS*CELLSIZE;  % Length of domain (meters)
%       X = 9100;            % Width of domain (meters)
%       Y = 2550;            % Length of domain (meters)
 rotangle = 0;               % Angle (degrees) to rotate the grid conterclock-wise
    resol = CELLSIZE;        % Cell width and height (i.e. Resolution)in degree. Grid cells are forced to be (almost) square.
        N = 30;              % Number of vertical levels
     
       
% Bathymetry -------------- % Bathymetry for ROMS is measured positive downwards (zeros are not allowed) see: https://www.myroms.org/wiki/index.php/Grid_Generation#Bathymetry
                            % To allow variations in surface elevation (eg. tides) while keeping all depths positive,
                            % an arbitrary offset (see minh below) is added to the depth vector.
      
      hh = nan;             % Analytical Depth (meters) used to create a uniform-depth grid. If using a bathymetry file, leave hh = nan;
    minh = 0;               % Arbitrary depth offset in meters (see above). minh should be a little more than the maximum expected tidal variation.
%   Bathy = 'Fjord_bathy.mat';% Bathymetry file. If using the analytical depth above (i.e. hh ~= nan), then Bathy will not be used.
%                            % The bathymetry file should be a .mat file containing 3 vectors (xbathy, ybathy and zbathy). where xbathy = Longitude, 
%                            % ybathy = Latitude and zbathy = depth (positive, in meters). xbathy and ybathy are in decimal degrees See: http://en.wikipedia.org/wiki/Decimal_degrees
       %Bathymetry smoothing routine...  See "Switches section" (above) to turn this ON or OFF
       if smooth_grid == 1;
           order = 2;       % Order of Shapiro filter (2,4,8)... default: 2
            rlim = 0.35;    % Maximum r-factor allowed (0.35)... default: 0.35
           npass = 50;      % Maximum number of passes.......... default: 50
       end
%---------------------------------
                       

% Coastline ----------------------
%   Coast = load('Fjord_coast.mat'); % If there isn't a coastline file... comment-out this line: e.g. %Coast = load('Fjord_coast.mat');
                                    % The coastline is only used for plotting. The coastline .mat file should contain 2 vectors named "lat" and "lon"
                                     
       

% -------------------------------------------------------------------------
% INITIAL CONDITIONS ------------------------------------------------------
% -------------------------------------------------------------------------
if save_init == 1; % See "Switches section" (above) to turn this ON or OFF
    % Initial conditions will be constant throughout the grid domain
    %--------------------------------------------------------------------------
    NH4          = 0.1;     % Ammonium concentration (millimole_NH4 meter-3)
    NO3          = 10;      % Nitrate concentration (millimole_N03 meter-3)
    chlorophyll1 = 0.3;     % Chlorophyll concentration in small phytoplankyon (milligrams_chlorophyll meter-3)
    chlorophyll2 = 0.3;     % Chlorophyll concentration in large phytoplankyon (milligrams_chlorophyll meter-3)
    detritus1    = 0.03;    % Small detritus concentration (millimole_nitrogen meter-3)
    detritus2    = 0.03;    % Large detritus concentration (millimole_nitrogen meter-3)
    detritusC1   = 1;       % Small detritus carbon concentration (millimole_carbon meter-3)
    detritusC2   = 0.2;     % Large detritus carbon concentration (millimole_carbon meter-3)
    phyto1       = 0.02;    % Small phytoplankton concentration (millimole_nitrogen meter-3)
    phyto2       = 0.02;    % Large phytoplankton concentration (millimole_nitrogen meter-3)
    phytoC1      = 0.2;     % Small phytoplankton carbon concentration (millimole_carbon meter-3)
    phytoC2      = 0.1;     % Small phytoplankton carbon concentration (millimole_carbon meter-3)
    salt         = 30;      % Salinity (PSU)
    temp         = 9;       % Potential temperature (Celsius)
    u            = 0;       % u-momentum component (meter second-1)
    ubar         = 0;       % Vertically integrated u-momentum component (meter second-1)
    v            = 0;       % v-momentum component (meter second-1)
    vbar         = 0;       % Vertically integrated v-momentum component (meter second-1)
    zeta         = 0;       % Free-surface (meters)
    zooplankton  = 0.01;    % Zooplankton concentration "millimole_nitrogen meter-3"
    zooplanktonC = 0.5;     % Zooplankton carbon concentration "millimole_carbon meter-3"
    %--------------------------------------------------------------------------
end



%****************************************************************************************************************************************************
% END OF USER SETTINGS ******************************************************************************************************************************
%****************************************************************************************************************************************************


tic % Start the timer


disp([char(13),char(13),char(13),char(13),char(13),char(13)])
disp('***************************************************************')
disp('** EASYGRID ***************************************************')
disp('***************************************************************')


%Lets start with some conversions 
rotangle = rotangle/180*pi;                 % Convert Angle for grid rotation from degrees to radians
%latdist  = geodesic_dist(lon,lat,lon,lat+1); % Length (in meters) of 1 degree of latitude




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START of GRID generation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if create_grid == 1; % Only create grid if switch (in USER SETTINGS) is turned ON

    disp([char(13),'GENERATING grid...'])

    % Clear varibles from previous grids
    clear x y Lm Lp L Mm Mp M x_rho y_rho lat_rho lon_rho lat_u lon_u lat_v lon_v lat_psi lon_psi...
        el xl dx dy pm pn dndx dmde f h mask_rho mask_rho_nan mask_u mask_v mask_psi dx dy angle
     
    XLLCENTER=XLLCORNER+CELLSIZE/2;
    YLLCENTER=YLLCORNER+CELLSIZE/2;
    
    x = XLLCENTER:CELLSIZE:XLLCENTER+(NCOLS-1)*CELLSIZE; 
    y = YLLCENTER:CELLSIZE:YLLCENTER+(NROWS-1)*CELLSIZE;
    
    Lm = NCOLS-2; Lp= Lm +2; L = Lp-1; 
    Mm = NROWS-2; Mp= Mm +2; M = Mp-1;
    
    % RHO GRID ------------------------------------------------------------
    %Create non-georeferenced grid in meters (origin = 0,0)
    x_rho = ones(length(y),1)*x(:)';
    y_rho = y(:)*ones(1,length(x));

    %Rotate grid ...See: http://en.wikipedia.org/wiki/Rotation_(mathematics)
    %Rx_rho = x_rho * cos(rotangle) - y_rho * sin(rotangle);
    %Ry_rho = x_rho * sin(rotangle) + y_rho * cos(rotangle);

    %Estimate Latitude and Longitude of each Grid point
    lat_rho = ones(size(x_rho));
    lon_rho = ones(size(x_rho));
    for i = 1:Mp;
        for j = 1:Lp;
            [lat_rho(i,j), lon_rho(i,j)] = utm2deg(x_rho(i,j),y_rho(i,j),UTM_zone);
        end
    end
    clear Rx_rho Ry_rho

    % U GRID --------------------------------------------------------------
    %Create non-georeferenced grid in meters (origin = 0,0)
    x_u   = (x_rho(:,1:L)   + x_rho(:,2:Lp))/2;
    y_u   = (y_rho(:,1:L)   + y_rho(:,2:Lp))/2;

    %Rotate grid ...See: http://en.wikipedia.org/wiki/Rotation_(mathematics)
    %Rx_u = x_u * cos(rotangle) - y_u * sin(rotangle);
    %Ry_u = x_u * sin(rotangle) + y_u * cos(rotangle);

    %Estimate Latitude and Longitude of each Grid point
    lat_u = ones(size(x_u));
    lon_u = ones(size(x_u));
    for i = 1:Mp;
        for j = 1:L;
            [lat_u(i,j), lon_u(i,j)] = utm2deg(x_u(i,j),y_u(i,j),UTM_zone);
        end
    end
    clear Rx_u Ry_u

    % V GRID --------------------------------------------------------------
    %Create non-georeferenced grid in meters (origin = 0,0)
    x_v   = (x_rho(1:M,:)   + x_rho(2:Mp,:))/2;
    y_v   = (y_rho(1:M,:)   + y_rho(2:Mp,:))/2;

    %Rotate grid ...See: http://en.wikipedia.org/wiki/Rotation_(mathematics)
    %Rx_v = x_v * cos(rotangle) - y_v * sin(rotangle);
    %Ry_v = x_v * sin(rotangle) + y_v * cos(rotangle);

    %Estimate Latitude and Longitude of each Grid point
    lat_v = ones(size(x_v));
    lon_v = ones(size(x_v));
    for i = 1:M;
        for j = 1:Lp;
            [lat_v(i,j), lon_v(i,j)] = utm2deg(x_v(i,j),y_v(i,j),UTM_zone);
        end
    end
    clear Rx_v Ry_v

    % PSI GRID ------------------------------------------------------------
    %Create non-georeferenced grid in meters (origin = 0,0)
    x_psi = (x_rho(1:M,1:L) + x_rho(2:Mp,2:Lp))/2;
    y_psi = (y_rho(1:M,1:L) + y_rho(2:Mp,2:Lp))/2;

    %Rotate grid ...See: http://en.wikipedia.org/wiki/Rotation_(mathematics)
    %Rx_psi = x_psi * cos(rotangle) - y_psi * sin(rotangle);
    %Ry_psi = x_psi * sin(rotangle) + y_psi * cos(rotangle);

    %Estimate Latitude and Longitude of each Grid point
    lat_psi = ones(size(x_psi));
    lon_psi = ones(size(x_psi));
    for i = 1:M;
        for j = 1:L;
            [lat_psi(i,j), lon_psi(i,j)] = utm2deg(x_psi(i,j),y_psi(i,j),UTM_zone);
        end
    end
    clear Rx_psi Ry_psi i j


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Grid spacing and other grid parameters  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    el      = Y; %lat_u(end,1) - lat_u(1,1);
    xl      = X; %lon_v(1,end) - lon_v(1,1);

    %Thanks to John Wilkin for this following section.
    dx=ones(size(x_rho));
    dy=ones(size(x_rho));
    for i = 1:Mp;
        for j = 1:Lp;
            dx(i,j)=CELLSIZE;
            dy(i,j)=CELLSIZE; 
        end
    end    


    %dx(:,2:L)=geodesic_dist(lon_u(:,2:L),lat_u(:,2:L),lon_u(:,1:Lm),lat_u(:,1:Lm)); %sperical distance calculation
    %for i = 1:length(dx(:,1));
    %    for j = 2:L;
    %        dx(i,j)=geodesic_dist(lon_u(i,j),lat_u(i,j),lon_u(i,j-1),lat_u(i,j-1)); %sperical distance calculatio
    %    end
    %end
    
    %dx(:,1)=dx(:,2);
    %dx(:,Lp)=dx(:,L);
    %%dy(2:M,:)=geodesic_dist(lon_v(2:M,:),lat_v(2:M,:),lon_v(1:Mm,:),lat_v(1:Mm,:)); %sperical distance calculation
    %for i = 2:M;
    %    for j = 1:length(dx(1,:));
    %        dy(i,j)=geodesic_dist(lon_v(i,j),lat_v(i,j),lon_v(i-1,j),lat_v(i-1,j)); %sperical distance calculation
    %    end
    %end
    %dy(1,:)=dy(2,:);
    %dy(Mp,:)=dy(M,:);
    pm=1./dx;
    pn=1./dy;

    dndx = zeros(size(pm));
    dmde = dndx;
    dndx(2:M,2:L)=0.5*(1./pn(2:M,3:Lp) - 1./pn(2:M,1:Lm));
    dmde(2:M,2:L)=0.5*(1./pm(3:Mp,2:L) - 1./pm(1:Mm,2:L));
    
    angle=zeros(Mp,Lp);
    
    % Original grid parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    p_coral    = zeros(Mp,Lp); % coral coverage
    p_seagrass = zeros(Mp,Lp); % seagrass coverage
    p_algae    = zeros(Mp,Lp); % calgal coverage
    sgd_src    = zeros(Mp,Lp); % Source points of submarine groundwater discharge


    % Coriolis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    f = 2 .* 7.29E-5 .* sin(lat_rho .* (pi/180)); %Estimation of Coriolis over the grid domain. OMEGA=7.29E-5
    %More info: http://en.wikipedia.org/wiki/Coriolis_effect#Formula


    % Bathymetry %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    if ~isnan(hh);
%        h = hh*ones(size(x));
%        h = ones(length(y),1)*h(:)';
%    else
%        load(Bathy);
%        h = griddata(xbathy,ybathy,zbathy,lon_rho,lat_rho,'linear');
%        h(isnan(h)) = -1;
%    end
    bath=importdata(Bathy,' ',6);
    
    h = ones(size(lon_rho));
    for i =1:Mp;
        h(i,:)=bath.data(Mp-i+1,:);
    end
    
    h(h==NODATA_VALUE) = -100;
    
%    h(h<0) = 0;   % Flatten hills and mountains (i.e. positive depths)
%    h = h + minh; % Add the depth offset minh (specified in USER SETTINGS)
%    clear xbathy ybathy zbathy
    %NOTE: Bathymetry smoothing occurs below "generating masks"




    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % GENERATING MASKS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp(['DONE!',char(13),char(13),char(13),'GENERATING masks...'])
    
    %  Land/Sea mask on RHO-points... and a NaN version of the mask for plotting.
    mask_rho = ones(size(lon_rho));
    mask_rho_nan = mask_rho;

    %mask_rho(h <= minh) = 0;
    %mask_rho_nan(h <= minh) = nan;
    %mask_rho(h < 0) = 0;
    %mask_rho_nan(h < 0) = nan;
    mask_rho(h == -100) = 0;
    mask_rho_nan(h == -100) = nan;
    
    %  Land/Sea mask on U-points.
    mask_u = mask_rho(:,1:L) .* mask_rho(:,2:Lp);

    %  Land/Sea mask on V-points.
    mask_v = mask_rho(1:M,:) .* mask_rho(2:Mp,:);

    %  Land/Sea mask on PSI-points.
    mask_psi = mask_u(1:M,:) .* mask_u(2:Mp,:);
    disp('DONE!')
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    disp([char(13),char(13)])
    disp('---------------------------------------')
    disp('WORKING with previously-generated GRID!')
    disp('---------------------------------------')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END of grid generation   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%Check for a grid variable. If it is not there... Warn user to TURN ON create_grid in USER SETTINGS
if exist('lat_rho','var') == 0;
    disp([char(13),char(13)])
    warning('ABSENT GRID VARIABLE!!!')
    disp('NOTE: You may have to SWITCH ON create_grid in the USER SETTINGS section and run EASYGRID again')
end








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SMOOTHING Bathymetry %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if smooth_grid == 1; % Only smooth bathymetry if switch (in USER SETTINGS) is turned ON
    disp([char(13),char(13),'SMOOTHING Bathymetry...'])
    h = smooth_bath(h,mask_rho,order,rlim,npass); %Smooth the grid
    disp('DONE!')
    clear smoothing
else
    clear smoothing
end
%--------------------------------------------------------------------------



  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SCREEN DISPLAY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if screen_output == 1; % Only display on screen if switch (in USER SETTINGS) is turned ON
    disp([char(13),char(13),char(13)])
    disp(['SCREEN DISPLAY:',char(13)])
    disp('COPY-PASTE the following parameters into your ocean.in file')
    disp('----------------------------------------------------------------------------------------------')
    disp(char(13))
    disp(['    Lm == ' num2str(Lm) '         ! Number of I-direction INTERIOR RHO-points'])
    disp(['    Mm == ' num2str(Mm) '         ! Number of J-direction INTERIOR RHO-points'])
    disp(['     N == ' num2str(N) '          ! Number of vertical levels'])
    disp(char(13))
    disp(['Make sure the Baroclinic time-step (DT) in your ocean.in file is less than: ' num2str(sqrt(((min(min(dx))^2)+(min(min(dy))^2)) / (9.8 * (min(min(h))^2)))) ' seconds'])
    disp('----------------------------------------------------------------------------------------------')
end
%--------------------------------------------------------------------------




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOTTING GRID %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if plot_grid == 1; % Only plot if switch (in USER SETTINGS) is turned ON
    disp([char(13),'PLOTTING grid...'])
    % check if you have John Wilkin's pcolor... if not use the normal pcolor
    cla % Erase axis but keep figure (this is to refresh old plot with new plot, while keeping figure size).
    if exist('pcolorjw.m') == 2;
        pcolorjw(lon_rho,lat_rho,h.*mask_rho_nan);shading faceted;cb=colorbar; title(cb,[{'Depth'};{'(m)'}])
    else
        pcolor(lon_rho,lat_rho,h.*mask_rho_nan);shading faceted;cb=colorbar; title(cb,[{'Depth'};{'(m)'}])
    end
    axis square
    xlabel('Longitude (degrees)');
    ylabel('Latitude (degrees)');
    title(['ROMS grid: ' Grid_filename]);    
    % Check if there is a coastline file
    if exist('Coast') == 1;
        hold on
        plot(Coast.lon,Coast.lat,'k');
    end
    clear cb
    disp(['DONE!'])
end
%--------------------------------------------------------------------------





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MASK EDITING  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if edit_mask == 1; % Only edit mask if switch (in USER SETTINGS) is turned ON
    disp([char(13),'EDITING MASK...'])
    disp('To FINISH editing... press right-button (on mouse).')
    figure(2)
    pcolorjw(lon_rho,lat_rho,mask_rho);caxis([0 1]);shading faceted;colormap([0.6 0.4 0;0.6 0.9 1]);colorbar;
    axis square
    xlabel('Longitude (degrees)');
    ylabel('Latitude (degrees)');
    title('LEFT-button: sea/land toggle ... RIGHT-button: Finish!','BackgroundColor','red');
    hold on
    if exist('Coast') == 1; 
        plot(Coast.lon,Coast.lat,'k');
    end
    button = 1;
    while button == 1
        [xi,yi,button] = ginput(1);
        if button == 1;
            costfunct = ((lon_rho-xi).^2) + ((lat_rho-yi).^2);
            [loni,lonj] = find(costfunct == min(min(costfunct)));
                if mask_rho(loni,lonj) == 0;
                    mask_rho(loni,lonj) = 1;
                else
                    mask_rho(loni,lonj) = 0;
                end
            pcolorjw(lon_rho,lat_rho,mask_rho);caxis([0 1]);shading faceted;colormap([0.6 0.4 0;0.6 0.9 1]);colorbar;
                if exist('Coast') == 1;
                    plot(Coast.lon,Coast.lat,'k');
                end
        end
        % Update u, v, psi and rho_nan MASKS
        mask_rho_nan = mask_rho;
        mask_rho_nan(mask_rho == 0) = nan;
        mask_u = mask_rho(:,1:L) .* mask_rho(:,2:Lp);
        mask_v = mask_rho(1:M,:) .* mask_rho(2:Mp,:);
        mask_psi = mask_u(1:M,:) .* mask_u(2:Mp,:); 
    end
    clear button xi yi costfunct
    disp(['DONE!'])
end
%--------------------------------------------------------------------------



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SAVE GRID FILE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if save_grid == 1; % Only save grid if switch (in USER SETTINGS) is turned ON
%    try
        
        grd_name   = [Grid_filename '_grd.nc'];
        ncid = netcdf.create(grd_name,'64BIT_OFFSET');
        % Generate general file information
        % Get Global Attribute ID
        varid_global = netcdf.getConstant('NC_GLOBAL');
        % Write Global Attributes
        netcdf.putAtt(ncid,varid_global,'creation_date',...
            [datestr(now),' GMT+9']);
        netcdf.putAtt(ncid,varid_global,'type','EASYGRID4Yaeyama Output Data');
        netcdf.putAtt(ncid,varid_global,'script',...
            [mfilename('fullpath'),'.m']);
        netcdf.putAtt(ncid,varid_global,'authors',...
            'Takashi Nakamura');
        netcdf.putAtt(ncid,varid_global,...
            'agency','Tokyo Tech.');
        netcdf.putAtt(ncid,varid_global,'software',...
            ['Created with Matlab ',version]);
        [~,host] = system('hostname');
        netcdf.putAtt(ncid,varid_global,'host',host(1:end-1));
        netcdf.putAtt(ncid,varid_global,'arch',computer('arch'));

    if refine_factor > 0 ; % Only save grid if switch (in USER SETTINGS) is turned ON
        
        parent_Imax = parent_Imin + (NCOLS-2)/refine_factor;
        parent_Jmax = parent_Jmin + (NROWS-2)/refine_factor;

        netcdf.putAtt(ncid,varid_global,'parent_grid',...
            parent_grid);
        netcdf.putAtt(ncid,varid_global,'parent_Imin',...
            int32(parent_Imin));
        netcdf.putAtt(ncid,varid_global,'parent_Imax',...
            int32(parent_Imax));
        netcdf.putAtt(ncid,varid_global,'parent_Jmin',...
            int32(parent_Jmin));
        netcdf.putAtt(ncid,varid_global,'parent_Jmax',...
            int32(parent_Jmax));
        netcdf.putAtt(ncid,varid_global,'refine_factor',...
            int32(refine_factor));
    end
    
        % Create dimensions
        dimid_xi_rho = netcdf.defDim(ncid,'xi_rho',Lp);
        dimid_xi_u   = netcdf.defDim(ncid,'xi_u',L);
        dimid_xi_v   = netcdf.defDim(ncid,'xi_v',Lp);
        dimid_xi_psi = netcdf.defDim(ncid,'xi_psi',L);
        
        dimid_eta_rho = netcdf.defDim(ncid,'eta_rho',Mp);
        dimid_eta_u   = netcdf.defDim(ncid,'eta_u',Mp);
        dimid_eta_v   = netcdf.defDim(ncid,'eta_v',M);
        dimid_eta_psi = netcdf.defDim(ncid,'eta_psi',M);
        
        dimid_one     = netcdf.defDim(ncid,'one',1);
       
        % Create variables to NetCDF
        varid_sph = netcdf.defVar(ncid,'spherical','nc_char',...
            dimid_one);
        netcdf.putAtt(ncid,varid_sph,'long_name',...
            'grid type logical switch');
        netcdf.putAtt(ncid,varid_sph,'option_T','spherical');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_sph,'T'); % 'T' -> 'F'
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_xl = netcdf.defVar(ncid,'xl','double',...
            dimid_one);
        netcdf.putAtt(ncid,varid_xl,'long_name',...
            'domain length in the XI-direction');
        netcdf.putAtt(ncid,varid_xl,'units','meter');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_xl,xl);
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_el = netcdf.defVar(ncid,'el','double',...
            dimid_one);
        netcdf.putAtt(ncid,varid_el,'long_name',...
            'domain length in the ETA-direction');
        netcdf.putAtt(ncid,varid_el,'units','meter');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_el,el);
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_dmde = netcdf.defVar(ncid,'dmde','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_dmde,'long_name',...
            'eta derivative of inverse metric factor pm');
        netcdf.putAtt(ncid,varid_dmde,'units','m');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_dmde,permute(dmde,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_dndx = netcdf.defVar(ncid,'dndx','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_dndx,'long_name',...
            'xi derivative of inverse metric factor pn');
        netcdf.putAtt(ncid,varid_dndx,'units','m');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_dndx,permute(dndx,[2 1]));
        %------------------------------------------------------------%
        %netcdf.reDef(ncid);
        %varid_X = netcdf.defVar(ncid,'X','double',...
        %    dimid_one);
        %netcdf.putAtt(ncid,varid_X,'long_name',...
        %    'width of the domain (degrees)');
        %netcdf.endDef(ncid);
        %netcdf.putVar(ncid,varid_X,X);
        %------------------------------------------------------------%
        %netcdf.reDef(ncid);
        %varid_Y = netcdf.defVar(ncid,'Y','double',...
        %    dimid_one);
        %netcdf.putAtt(ncid,varid_Y,'long_name',...
        %    'length of the domain (degrees)');
        %netcdf.endDef(ncid);
        %netcdf.putVar(ncid,varid_Y,Y);
        %------------------------------------------------------------%
        %netcdf.reDef(ncid);
        %varid_dx = netcdf.defVar(ncid,'dx','double',...
        %    dimid_one);
        %netcdf.putAtt(ncid,varid_dx,'long_name',...
        %    'resolution in x (degrees)');
        %netcdf.endDef(ncid);
        %dxx = (resol./(60*1852))...
        %    .* spheriq_dist(lon,lat,lon+1,lat); % Estimated resolution 
        %                                        % in x (degrees)0.002;
        %netcdf.putVar(ncid,varid_dx,dxx);
        %------------------------------------------------------------%
        %netcdf.reDef(ncid);
        %varid_dy = netcdf.defVar(ncid,'dy','double',...
        %    dimid_one);
        %netcdf.putAtt(ncid,varid_dy,'long_name',...
        %    'resolution in y (degrees)');
        %netcdf.endDef(ncid);
        %dyy = (resol./(60*1852)); % Estimated resolution 
        %                          % in y (degrees)0.002;
        %netcdf.putVar(ncid,varid_dy,dyy);
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_angle = netcdf.defVar(ncid,'angle','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_angle,'long_name',...
            'angle between XI-axis and EAST');
        netcdf.putAtt(ncid,varid_angle,'units','radians');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_angle,permute(angle,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_f = netcdf.defVar(ncid,'f','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_f,'long_name',...
            'Coriolis parameter at RHO-points');
        netcdf.putAtt(ncid,varid_f,'units','second-1');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_f,permute(f,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_h = netcdf.defVar(ncid,'h','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_h,'long_name',...
            'bathmetry at RHO-points');
        netcdf.putAtt(ncid,varid_h,'units','m');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_h,permute(h,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_lat_rho = netcdf.defVar(ncid,'lat_rho','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_lat_rho,'long_name',...
            'latitude at RHO-points');
        netcdf.putAtt(ncid,varid_lat_rho,'units','degree_north');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_lat_rho,permute(lat_rho,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_lat_psi = netcdf.defVar(ncid,'lat_psi','double',...
            [dimid_xi_psi,dimid_eta_psi]);
        netcdf.putAtt(ncid,varid_lat_psi,'long_name',...
            'latitude at PSI-points');
        netcdf.putAtt(ncid,varid_lat_psi,'units','degree_north');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_lat_psi,permute(lat_psi,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_lat_u = netcdf.defVar(ncid,'lat_u','double',...
            [dimid_xi_u,dimid_eta_u]);
        netcdf.putAtt(ncid,varid_lat_u,'long_name',...
            'latitude at U-points');
        netcdf.putAtt(ncid,varid_lat_u,'units','degree_north');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_lat_u,permute(lat_u,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_lat_v = netcdf.defVar(ncid,'lat_v','double',...
            [dimid_xi_v,dimid_eta_v]);
        netcdf.putAtt(ncid,varid_lat_v,'long_name',...
            'latitude at V-points');
        netcdf.putAtt(ncid,varid_lat_v,'units','degree_north');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_lat_v,permute(lat_v,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_lon_rho = netcdf.defVar(ncid,'lon_rho','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_lon_rho,'long_name',...
            'longitude at RHO-points');
        netcdf.putAtt(ncid,varid_lon_rho,'units','degree_east');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_lon_rho,permute(lon_rho,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_lon_psi = netcdf.defVar(ncid,'lon_psi','double',...
            [dimid_xi_psi,dimid_eta_psi]);
        netcdf.putAtt(ncid,varid_lon_psi,'long_name',...
            'longitude at PSI-points');
        netcdf.putAtt(ncid,varid_lon_psi,'units','degree_east');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_lon_psi,permute(lon_psi,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_lon_u = netcdf.defVar(ncid,'lon_u','double',...
            [dimid_xi_u,dimid_eta_u]);
        netcdf.putAtt(ncid,varid_lon_u,'long_name',...
            'longitude at U-points');
        netcdf.putAtt(ncid,varid_lon_u,'units','degree_east');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_lon_u,permute(lon_u,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_lon_v = netcdf.defVar(ncid,'lon_v','double',...
            [dimid_xi_v,dimid_eta_v]);
        netcdf.putAtt(ncid,varid_lon_v,'long_name',...
            'longitude at V-points');
        netcdf.putAtt(ncid,varid_lon_v,'units','degree_east');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_lon_v,permute(lon_v,[2 1]));
        %------------------------------------------------------------%
        
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_y_rho = netcdf.defVar(ncid,'y_rho','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_y_rho,'long_name',...
            'y location at RHO-points');
        netcdf.putAtt(ncid,varid_y_rho,'units','meter');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_y_rho,permute(y_rho,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_y_psi = netcdf.defVar(ncid,'y_psi','double',...
            [dimid_xi_psi,dimid_eta_psi]);
        netcdf.putAtt(ncid,varid_y_psi,'long_name',...
            'y location at PSI-points');
        netcdf.putAtt(ncid,varid_y_psi,'units','meter');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_y_psi,permute(y_psi,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_y_u = netcdf.defVar(ncid,'y_u','double',...
            [dimid_xi_u,dimid_eta_u]);
        netcdf.putAtt(ncid,varid_y_u,'long_name',...
            'y location at U-points');
        netcdf.putAtt(ncid,varid_y_u,'units','meter');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_y_u,permute(y_u,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_y_v = netcdf.defVar(ncid,'y_v','double',...
            [dimid_xi_v,dimid_eta_v]);
        netcdf.putAtt(ncid,varid_y_v,'long_name',...
            'y location at V-points');
        netcdf.putAtt(ncid,varid_y_v,'units','meter');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_y_v,permute(y_v,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_x_rho = netcdf.defVar(ncid,'x_rho','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_x_rho,'long_name',...
            'x location at RHO-points');
        netcdf.putAtt(ncid,varid_x_rho,'units','meter');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_x_rho,permute(x_rho,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_x_psi = netcdf.defVar(ncid,'x_psi','double',...
            [dimid_xi_psi,dimid_eta_psi]);
        netcdf.putAtt(ncid,varid_x_psi,'long_name',...
            'x location at PSI-points');
        netcdf.putAtt(ncid,varid_x_psi,'units','meter');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_x_psi,permute(x_psi,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_x_u = netcdf.defVar(ncid,'x_u','double',...
            [dimid_xi_u,dimid_eta_u]);
        netcdf.putAtt(ncid,varid_x_u,'long_name',...
            'x location at U-points');
        netcdf.putAtt(ncid,varid_x_u,'units','meter');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_x_u,permute(x_u,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_x_v = netcdf.defVar(ncid,'x_v','double',...
            [dimid_xi_v,dimid_eta_v]);
        netcdf.putAtt(ncid,varid_x_v,'long_name',...
            'x location at V-points');
        netcdf.putAtt(ncid,varid_x_v,'units','meter');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_x_v,permute(x_v,[2 1]));
        %------------------------------------------------------------%

        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_mask_rho = netcdf.defVar(ncid,'mask_rho','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_mask_rho,'long_name',...
            'mask at RHO-points');
        netcdf.putAtt(ncid,varid_mask_rho,'option_0','land');
        netcdf.putAtt(ncid,varid_mask_rho,'option_1','water');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_mask_rho,permute(mask_rho,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_mask_psi = netcdf.defVar(ncid,'mask_psi','double',...
            [dimid_xi_psi,dimid_eta_psi]);
        netcdf.putAtt(ncid,varid_mask_psi,'long_name',...
            'mask at PSI-points');
        netcdf.putAtt(ncid,varid_mask_psi,'option_0','land');
        netcdf.putAtt(ncid,varid_mask_psi,'option_1','water');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_mask_psi,permute(mask_psi,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_mask_u = netcdf.defVar(ncid,'mask_u','double',...
            [dimid_xi_u,dimid_eta_u]);
        netcdf.putAtt(ncid,varid_mask_u,'long_name',...
            'mask at U-points');
        netcdf.putAtt(ncid,varid_mask_u,'option_0','land');
        netcdf.putAtt(ncid,varid_mask_u,'option_1','water');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_mask_u,permute(mask_u,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_mask_v = netcdf.defVar(ncid,'mask_v','double',...
            [dimid_xi_v,dimid_eta_v]);
        netcdf.putAtt(ncid,varid_mask_v,'long_name',...
            'mask at V-points');
        netcdf.putAtt(ncid,varid_mask_v,'option_0','land');
        netcdf.putAtt(ncid,varid_mask_v,'option_1','water');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_mask_v,permute(mask_v,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_pm = netcdf.defVar(ncid,'pm','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_pm,'long_name',...
            'curvilinear coordinate metric in X');
        netcdf.putAtt(ncid,varid_pm,'units','meter-1');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_pm,permute(pm,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_pn = netcdf.defVar(ncid,'pn','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_pn,'long_name',...
            'curvilinear coordinate metric in ETA');
        netcdf.putAtt(ncid,varid_pn,'units','meter-1');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_pn,permute(pn,[2 1]));
        %------------------------------------------------------------%
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_p_coral = netcdf.defVar(ncid,'p_coral','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_p_coral,'long_name',...
            'coral coverage');
        netcdf.putAtt(ncid,varid_p_coral,'units','0 to 1');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_p_coral,permute(p_coral,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_p_seagrass = netcdf.defVar(ncid,'p_seagrass','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_p_seagrass,'long_name',...
            'seagrass coverage');
        netcdf.putAtt(ncid,varid_p_seagrass,'units','0 to 1');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_p_seagrass,permute(p_seagrass,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_p_algae = netcdf.defVar(ncid,'p_algae','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_p_algae,'long_name',...
            'algal coverage');
        netcdf.putAtt(ncid,varid_p_algae,'units','0 to 1');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_p_algae,permute(p_algae,[2 1]));
        %------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_sgd_src = netcdf.defVar(ncid,'sgd_src','double',...
            [dimid_xi_rho,dimid_eta_rho]);
        netcdf.putAtt(ncid,varid_sgd_src,'long_name',...
            'source points of submarine groundwater discharge');
        netcdf.putAtt(ncid,varid_sgd_src,'units','0 to 1');
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_sgd_src,permute(sgd_src,[2 1]));
        %------------------------------------------------------------%
        %------------------------------------------------------------%
        netcdf.close(ncid);  
        
%    catch
%        warning('Problem writing .nc grid file!')
%    end
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SAVE INITIAL CONDITIONS FILE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if save_init == 1; % Only save init_file if switch (in USER SETTINGS) is turned ON
%    try

        ini_name   = [Grid_filename '_ini.nc'];
        ncid = netcdf.create(ini_name,'64BIT_OFFSET');
        % Generate general file information
        % Get Global Attribute ID
        varid_global = netcdf.getConstant('NC_GLOBAL');
        % Write Global Attributes
        netcdf.putAtt(ncid,varid_global,'creation_date',...
            [datestr(now),' Pacific Time']);
        netcdf.putAtt(ncid,varid_global,'type','EASYGRIDC Output Data');
        netcdf.putAtt(ncid,varid_global,'script',...
            [mfilename('fullpath'),'.m']);
        netcdf.putAtt(ncid,varid_global,'authors',...
            'cakan@coas.oregonstate.edu');
        netcdf.putAtt(ncid,varid_global,'owner',...
            'Nearshore Modeling Group (http://ozkan.oce.orst.edu)');
        netcdf.putAtt(ncid,varid_global,...
            'agency','Oregon State University');
        netcdf.putAtt(ncid,varid_global,'software',...
            ['Created with Matlab ',version]);
        [~,host] = system('hostname');
        netcdf.putAtt(ncid,varid_global,'host',host(1:end-1));
        netcdf.putAtt(ncid,varid_global,'arch',computer('arch'));
        
        % Create dimensions
        dimid_xi_rho = netcdf.defDim(ncid,'xi_rho',Lp);
        dimid_xi_u   = netcdf.defDim(ncid,'xi_u',L);
        dimid_xi_v   = netcdf.defDim(ncid,'xi_v',Lp);
        dimid_xi_psi = netcdf.defDim(ncid,'xi_psi',L);
        
        dimid_eta_rho = netcdf.defDim(ncid,'eta_rho',Mp);
        dimid_eta_u   = netcdf.defDim(ncid,'eta_u',Mp);
        dimid_eta_v   = netcdf.defDim(ncid,'eta_v',M);
        dimid_eta_psi = netcdf.defDim(ncid,'eta_psi',M);
        
        dimid_s_rho   = netcdf.defDim(ncid,'s_rho',N);
        dimid_time    = netcdf.defDim(ncid,'time',1);
       
        % Create variables to NetCDF      
        varid_NH4 = netcdf.defVar(ncid,'NH4','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_NH4,'time','ocean_time');
        netcdf.endDef(ncid);
        NH4_tmp = ones(N,Mp,Lp).* NH4;
        netcdf.putVar(ncid,varid_NH4,permute(NH4_tmp,[4 3 2 1]));  
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_NO3 = netcdf.defVar(ncid,'NO3','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_NO3,'time','ocean_time');
        netcdf.endDef(ncid);
        NO3_tmp = ones(N,Mp,Lp).* NO3;
        netcdf.putVar(ncid,varid_NO3,permute(NO3_tmp,[4 3 2 1]));  
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_chlo1 = netcdf.defVar(ncid,'chlorophyll1','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_chlo1,'time','ocean_time');
        netcdf.endDef(ncid);
        chlo1_tmp = ones(N,Mp,Lp).* chlorophyll1;
        netcdf.putVar(ncid,varid_chlo1,permute(chlo1_tmp,[4 3 2 1]));  
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_chlo2 = netcdf.defVar(ncid,'chlorophyll2','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_chlo2,'time','ocean_time');
        netcdf.endDef(ncid);
        chlo2_tmp = ones(N,Mp,Lp).* chlorophyll2;
        netcdf.putVar(ncid,varid_chlo2,permute(chlo2_tmp,[4 3 2 1]));  
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_detri1 = netcdf.defVar(ncid,'detritus1','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_detri1,'time','ocean_time');
        netcdf.endDef(ncid);
        detri1_tmp = ones(N,Mp,Lp).*detritus1;
        netcdf.putVar(ncid,varid_detri1,permute(detri1_tmp,[4 3 2 1]));  
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_detri2 = netcdf.defVar(ncid,'detritus2','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_detri2,'time','ocean_time');
        netcdf.endDef(ncid);
        detri2_tmp = ones(N,Mp,Lp).*detritus2;
        netcdf.putVar(ncid,varid_detri2,permute(detri2_tmp,[4 3 2 1])); 
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_detriC1 = netcdf.defVar(ncid,'detritusC1','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_detriC1,'time','ocean_time');
        netcdf.endDef(ncid);
        detriC1_tmp = ones(N,Mp,Lp).*detritusC1;
        netcdf.putVar(ncid,varid_detriC1,permute(detriC1_tmp,[4 3 2 1]));  
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_detriC2 = netcdf.defVar(ncid,'detritusC2','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_detriC2,'time','ocean_time');
        netcdf.endDef(ncid);
        detriC2_tmp = ones(N,Mp,Lp).*detritusC2;
        netcdf.putVar(ncid,varid_detriC2,permute(detriC2_tmp,[4 3 2 1]));
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_phyto1 = netcdf.defVar(ncid,'phyto1','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_phyto1,'time','ocean_time');
        netcdf.endDef(ncid);
        phyto1_tmp = ones(N,Mp,Lp).*phyto1;
        netcdf.putVar(ncid,varid_phyto1,permute(phyto1_tmp,[4 3 2 1]));
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_phyto2 = netcdf.defVar(ncid,'phyto2','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_phyto2,'time','ocean_time');
        netcdf.endDef(ncid);
        phyto2_tmp = ones(N,Mp,Lp).*phyto2;
        netcdf.putVar(ncid,varid_phyto2,permute(phyto2_tmp,[4 3 2 1]));
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_phytoC1 = netcdf.defVar(ncid,'phytoC1','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_phytoC1,'time','ocean_time');
        netcdf.endDef(ncid);
        phytoC1_tmp = ones(N,Mp,Lp).*phytoC1;
        netcdf.putVar(ncid,varid_phytoC1,permute(phytoC1_tmp,[4 3 2 1]));
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_phytoC2 = netcdf.defVar(ncid,'phytoC2','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_phytoC2,'time','ocean_time');
        netcdf.endDef(ncid);
        phytoC2_tmp = ones(N,Mp,Lp).*phytoC2;
        netcdf.putVar(ncid,varid_phytoC2,permute(phytoC2_tmp,[4 3 2 1]));        
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_zoo = netcdf.defVar(ncid,'zooplankton','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_zoo,'time','ocean_time');
        netcdf.endDef(ncid);
        zoo_tmp = ones(N,Mp,Lp).*zooplankton;
        netcdf.putVar(ncid,varid_zoo,permute(zoo_tmp,[4 3 2 1]));
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_zooC = netcdf.defVar(ncid,'zooplanktonC','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_zooC,'time','ocean_time');
        netcdf.endDef(ncid);
        zooC_tmp = ones(N,Mp,Lp).*zooplanktonC;
        netcdf.putVar(ncid,varid_zooC,permute(zooC_tmp,[4 3 2 1]));
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_salt = netcdf.defVar(ncid,'salt','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_salt,'time','ocean_time');
        netcdf.endDef(ncid);
        salt_tmp = ones(N,Mp,Lp).*salt;
        netcdf.putVar(ncid,varid_salt,permute(salt_tmp,[4 3 2 1]));      
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_temp = netcdf.defVar(ncid,'temp','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_temp,'time','ocean_time');
        netcdf.endDef(ncid);
        temp_tmp = ones(N,Mp,Lp).*temp;
        netcdf.putVar(ncid,varid_temp,permute(temp_tmp,[4 3 2 1]));        
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_time = netcdf.defVar(ncid,'ocean_time','double',...
            dimid_time);
        netcdf.putAtt(ncid,varid_time,'unit',['days since ',datestr(ref_date,'yyyy-mm-dd HH:MM:SS'),' GMT']);
        netcdf.endDef(ncid);
        netcdf.putVar(ncid,varid_time,ocean_time);
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_u = netcdf.defVar(ncid,'u','double',...
            [dimid_xi_u,dimid_eta_u,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_u,'time','ocean_time');
        netcdf.endDef(ncid);
        u_tmp = ones(N,Mp,L).*u;
        netcdf.putVar(ncid,varid_u,permute(u_tmp,[4 3 2 1]));  
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_v = netcdf.defVar(ncid,'v','double',...
            [dimid_xi_v,dimid_eta_v,dimid_s_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_v,'time','ocean_time');
        netcdf.endDef(ncid);
        v_tmp = ones(N,M,Lp).*v;
        netcdf.putVar(ncid,varid_v,permute(v_tmp,[4 3 2 1])); 
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_ubar = netcdf.defVar(ncid,'ubar','double',...
            [dimid_xi_u,dimid_eta_u,dimid_time]);
        netcdf.putAtt(ncid,varid_ubar,'time','ocean_time');
        netcdf.endDef(ncid);
        ubar_tmp = ones(Mp,L).*ubar;
        netcdf.putVar(ncid,varid_ubar,permute(ubar_tmp,[3 2 1])); 
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_vbar = netcdf.defVar(ncid,'vbar','double',...
            [dimid_xi_v,dimid_eta_v,dimid_time]);
        netcdf.putAtt(ncid,varid_vbar,'time','ocean_time');
        netcdf.endDef(ncid);
        vbar_tmp = ones(M,Lp).*vbar;
        netcdf.putVar(ncid,varid_vbar,permute(vbar_tmp,[3 2 1])); 
        %-----------------------------------------------------------------%
        netcdf.reDef(ncid);
        varid_zeta = netcdf.defVar(ncid,'zeta','double',...
            [dimid_xi_rho,dimid_eta_rho,dimid_time]);
        netcdf.putAtt(ncid,varid_zeta,'time','ocean_time');
        netcdf.endDef(ncid);
        zeta_tmp = ones(Mp,Lp).*zeta;
        netcdf.putVar(ncid,varid_zeta,permute(zeta_tmp,[3 2 1])); 

    netcdf.close(ncid);
%    catch
        warning('Problem writing .nc initial-conditions file!')
%    end
end


disp(char(13))
disp('***************************************************************')
disp(['elapsed time: ' num2str(toc/60) ' minute(s)'])
disp('***************************************************************')
disp('EASYGRID is DONE!!! *******************************************')
disp('***************************************************************')
disp([char(13),char(13),char(13)])

clear nc Author Bathy Computer Descrip_grd Descrip_ini Grid_filename X Y dims ...
    grd_name ini_name plot_grid polar_rad npass order rlim ...
    create_grid edit_mask screen_output save_grid save_init smooth_grid
