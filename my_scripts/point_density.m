function pdens = point_density( x, y, dx, dy )
% Point density 
% x(:): x data array
% y(:): y data array
% dx: x width for counting point density
% dy: y width for counting point density

num_data = size(x,2);
pdens=zeros(size(num_data));
for i=1:num_data
    xv=[x(i)-dx/2; x(i)-dx/2; x(i)+dx/2; x(i)+dx/2; x(i)-dx/2];
    yv=[y(i)-dy/2; y(i)+dy/2; y(i)+dy/2; y(i)-dy/2; y(i)-dy/2];
    [in, ~]=inpolygon(x,y,xv,yv);
    pdens(i)=numel(x(in))/dx/dy; % particle/km2
end

end

