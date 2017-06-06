h_seki(1080,1600)=0.0;
for i=1:1080
%  h_seki(1080-i+1,:)=SPOT030201_bath_submask(1600*(i-1)+1:1600*i);
  h_seki(i,:)=SPOT030201_bath_submask(1600*(i-1)+1:1600*i);
end
h_seki2=h_seki.*-1;
h_seki2(find(h_seki2==0))=99999;
h_seki2(find(h_seki2<=0))=0;
%h_seki2(find(h_seki2>=5))=99999;
%surface(h_seki2,'LineStyle','none')
%dlmwrite('h_seki.txt',h_seki2)  %コンマ区切り
%dlmwrite('h_seki2.txt',h_seki2,'delimiter','\t') %タブ区切り
dlmwrite('h_seki2.txt',h_seki2,'delimiter',' ') %スペース区切り
%h_seki2(230,350)=0.0;
%for i=1:230
%  h_seki2(230-i+1,:)=topoZ(350*(i-1)+1:350*i);
%end
%surface(h_seki2,'LineStyle','none')

h_seki3(1080,1600)=0.0;
for i=1:1080
    for j=1:1600
        if h_seki_bath(i,j)>=6
            h_seki3(i,j)=h_seki_bath(i,j);
        elseif h_seki_bath(i,j)>0 && h_seki2(i,j)==99999
            h_seki3(i,j)=h_seki_bath(i,j);
        else
            h_seki3(i,j)=h_seki2(i,j);
        end
    end
end
%surface(h_seki3,'LineStyle','none')
dlmwrite('h_seki_combined.txt',h_seki3,'delimiter',' ') %スペース区切り

h_seki_100m(270,400)=0.0;
A(16)=0.0;
l=0; 
for i=1:4:1080
    l=l+1;
    m=0;
    for j=1:4:1600
        m=m+1;
        for k=1:4
            A((k-1)*4+1:k*4)=h_seki3(i:i+3,j+k-1);
        end
        h_seki_100m(l,m)=median(A);
    end
end
h_seki_100m(find(h_seki_100m>10000))=99999;
dlmwrite('h_seki_100m.txt',h_seki_100m,'delimiter',' ') %スペース区切り


h_seki_100m_fin_360x270=h_seki_100m_fin(1:270,31:390);
surface(h_seki_100m_fin_360x270,'LineStyle','none');

dlmwrite('h_seki_100m_360x270.txt',h_seki_100m_fin_360x270,'delimiter',' ') %スペース区切り
