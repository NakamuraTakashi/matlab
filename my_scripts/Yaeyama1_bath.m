bath1(280,310)=0.0;
for i=1:280
    for j=1:310
        if Yaeyama1_margi1(i,j)==-99999
            bath1(i,j)=-Yaeyama1_margi2(i,j);
        else
            bath1(i,j)=Yaeyama1_margi1(i,j);
        end
    end
end
bath1(find(bath1<=0))=-99999;
surface(bath1,'LineStyle','none')
dlmwrite('Yaeyama1_fin.txt',bath1,'delimiter',' ') %スペース区切り