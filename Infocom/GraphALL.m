%ʹ������ͼ���ȫ����������
jiandanchushihua_zuijiandan;%�õ�GF����
for iqiqiqiq=1:10000000000000
    GFbeifen1=GF;
    GraphJ;
    
    [fuhuan,flagJ]=BellmanFord3(J,GF,INF);%���и�������flagJ=1���õ�����fuhuan�����޸�������flagJ=0���˳���
    if flagJ==1
        fuhuangengxin1;%���и�������flagJ=1�������õ��ĸ���fuhuan��ָ��Ĳ������и���
        
        if sum(max(GF'))>sum(max(GFbeifen1'))
            break;
        end
    else
        break;
    end
end
% iqiqiqiq
