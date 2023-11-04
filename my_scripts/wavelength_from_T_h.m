function [L] = wavelength_from_T_h(T, h)
% input parameters
%  T: Wave period (s)
%  h: Depth (m)
% output parameters
%  L: Wave length
%
%-----------------------------------------------------------------------
    pi  = 3.14159265359;  % Circle ratio
    g   = 9.80665;        % Gravitational acceleration (m s-2)
    err = 0.001;           % calculation error (m)
    
% Initial wave length
    L = sqrt( g*h )*T;  % wave length of Deep water wave
    L2 = sqrt( (0.5*g*L/pi*tanh(2.0*pi*h/L)) )*T;
    while abs(L-L2)>err
      L=L2;
      L2 = sqrt( (0.5*g*L/pi*tanh(2.0*pi*h/L)) )*T;
    end
    L=L2;

end
