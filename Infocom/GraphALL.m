%使用有向图后的全部程序整合
jiandanchushihua_zuijiandan;%得到GF数据
for iqiqiqiq=1:10000000000000
    GFbeifen1=GF;
    GraphJ;
    
    [fuhuan,flagJ]=BellmanFord3(J,GF,INF);%若有负环，则flagJ=1，得到负环fuhuan，若无负环，则flagJ=0，退出；
    if flagJ==1
        fuhuangengxin1;%若有负环，则flagJ=1，对所得到的负环fuhuan所指向的操作进行更新
        
        if sum(max(GF'))>sum(max(GFbeifen1'))
            break;
        end
    else
        break;
    end
end
% iqiqiqiq
