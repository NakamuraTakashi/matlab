function [ sk ] = skill( T_obs, X_obs, T_model, X_model )
%skill 
%   
i = find(~isnan(X_obs)); 
Xo = X_obs(i); % Observed data 
To = T_obs(i); 

i = find(~isnan(X_model)); 
Xm = X_model(i); % Model data 
Tm = T_model(i); 
% Xmi=zeros(size(Xo));

% for i=1:size(To,1)
%     for j=2:size(Tm,1)
%         if Tm(j)>= To(i)
%             Xmi(i) = ((Tm(j)-To(i))*Xm(j-1) + (To(i)-Tm(j-1))*Xm(j))/(Tm(j)-Tm(j-1));
%             break 
%         end
%     end
% end
Xmi = interp1(Tm,Xm,To);

i = find(~isnan(Xmi)); 
Xmi2 = Xmi(i); 
Xo2 = Xo(i); 

tmp = abs(Xmi2-mean(Xo2)) + abs(Xo2-mean(Xo2));

sk = 1-(Xmi2-Xo2).'*(Xmi2-Xo2)/(tmp.'*tmp);

end

