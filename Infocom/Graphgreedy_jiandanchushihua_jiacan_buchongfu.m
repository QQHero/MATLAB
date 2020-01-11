%使用有向图后的贪心
%不能重复已经作为起点的
jiandanchushihua_zuijiandan;%得到GF数据
buchongfu=zeros(1,N);
for iqiqiqiq=1:10000000000000
    GFbeifen1=GF;
    GraphJ;%得到邻接矩阵J
    
    [fuhuan,flagJ]=greedyhuan_jiacan_buchongfu(J,GF,INF,alph,buchongfu);%若有负环，则flagJ=1，得到负环fuhuan，若无负环，则flagJ=0，退出；
    if flagJ==1
        fuhuangengxin1;%若有负环，则flagJ=1，对所得到的负环fuhuan所指向的操作进行更新
        
    if sum(max(GF'))>sum(max(GFbeifen1'))
        woyoucuole=woyoucuole+1
            break;
        end
    else
        break;
    end
end
iqiqiqiq

