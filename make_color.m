clear
clc

MyColormaps = load('MyColormaps.mat');

colmap1 = MyColormaps.colmap1;
colmap2 = MyColormaps.colmap2;
colmap3 = MyColormaps.colmap3;
colmap4 = MyColormaps.colmap4;
colmap5 = MyColormaps.colmap5;

colmap6 = turbo(15+128+15);
turbo1 = turbo(15+128+15);
colmap6 = colmap6(16:16+127, :);

colmap7 = colmap6;
colmap7hsv = rgb2hsv(colmap7);
for i = 1:13
    colmap7hsv(i,2) = (i-1)/12*(colmap7hsv(i,2));
    colmap7hsv(i,3) = 1-(i-1)/12*(1-colmap7hsv(i,3));
end
colmap7 = hsv2rgb(colmap7hsv);

colmap8 = turbo(3*15+3*128+3*15);
colmap8 = colmap8(3*15+1:3*15+1+127, :);

colmap9 = turbo(3*15+3*128+3*15);
colmap9 = colmap9(3*15+2*128+1:3*15+3*128, :);

colmap10 = colmap6;
for i = 1:64
    colmap10(i,:) = colmap8(i*2,:);
    colmap10(129-i,:) = colmap9(129-(i*2),:);
end
colmap10hsv = rgb2hsv(colmap10);
for i = 1:13
    colmap10hsv(64+i,2) = (i-1)/12*(colmap10hsv(64+i,2));
    colmap10hsv(64+i,3) = 1-(i-1)/12*(1-colmap10hsv(64+i,3));

    colmap10hsv(65-i,2) = (i-1)/12*(colmap10hsv(65-i,2));
    colmap10hsv(65-i,3) = 1-(i-1)/12*(1-colmap10hsv(65-i,3));
end
colmap10 = hsv2rgb(colmap10hsv);



% figure1 = figure(...
%     'Color',[1 1 1],...
%     'Colormap',colmap8...
%     );
% hold on
% colorbar


save('MyColormaps.mat', ...
    'colmap1', ...
    'colmap2', ...
    'colmap3', ...
    'colmap4', ...
    'colmap5', ...
    'colmap6', ...
    'colmap7', ...
    'colmap8', ...
    'colmap9', ...
    'colmap10');



