%ʹ������ͼ���̰��
%�����ظ��Ѿ���Ϊ����
jiandanchushihua_zuijiandan;%�õ�GF����
buchongfu=zeros(1,N);
for iqiqiqiq=1:10000000000000
    GFbeifen1=GF;
    GraphJ;%�õ��ڽӾ���J
    
    [fuhuan,flagJ]=greedyhuan_jiacan_buchongfu(J,GF,INF,alph,buchongfu);%���и�������flagJ=1���õ�����fuhuan�����޸�������flagJ=0���˳���
    if flagJ==1
        fuhuangengxin1;%���и�������flagJ=1�������õ��ĸ���fuhuan��ָ��Ĳ������и���
        
    if sum(max(GF'))>sum(max(GFbeifen1'))
        woyoucuole=woyoucuole+1
            break;
        end
    else
        break;
    end
end
iqiqiqiq

