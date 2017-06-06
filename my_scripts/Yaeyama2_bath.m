l=0; 
for i=1:3:270
    l=l+1;
    m=0;
    for j=1:3:360
        m=m+1;
        for k=1:3
            A((k-1)*3+1:k*3)=Yaeyama3(i:i+2,j+k-1);
        end
        Yaeyama3_300m(l,m)=median(A);
    end
end
Yaeyama2Copy=Yaeyama2;
Yaeyama2Copy(128:217,91:210)=Yaeyama3_300m(:,:);
dlmwrite('Yaeyama2_fin.txt',Yaeyama2Copy,'delimiter',' ') %スペース区切り
