function [fuhuan,flagtcll,zuiduanqs,zuiduanqshz]=nonqsBell(J,GF,INF,qs,qzzz,yr,w,qzsz,fz,qzjd,qzfz,gfz,fzg,dis,maxedge,qss)
yr=yr+1;
if yr>1
    yr
    for CCC=1:1
        yr
    end
end
[G,N]=size(GF);
buyao=zeros((G+N),G);
flagtcll=0;
flagtcl=0;
flagfh=0;%�ж��Ƿ��ָ���
qsbeifen=qs;

qssbeifen=qss;
tcjd=0;
fuhuan=zeros(1,(N+G));
gfz=zeros(G,(N+G));%��������ʹ��gfzǰ������ֵ���������������û������Ǿ������û���Ż����û���fz���Ҫ��ϸ����
flagtcl=0;






for n=1:(G+N)
        if ~(isequal((qzfz(n,:).*qs),zeros(1,G)))
            qzfz(n,:)=zeros(1,G);
            qzjd(n,:)=zeros(1,(N+G));
            qzsz(n,:)=zeros(1,(N+G));
            dis(n)=maxedge;
        end
end
















for C=1:((N+G)*1)%�ܵĴ�ѭ������Ϊ�ڵ�����һ������ĳɽڵ���ֻ�����Ӽ�����������ı�����
    disflag=dis;%�����жϸô�ѭ���Ƿ�û�б仯�����ޱ仯�������˳�Cѭ��
    for g=1:G%����Ҫע��ÿ�δ�ѭ���������ɳڵ�˳���Ƿ�һ��
        
        for n=1:(N+G)
            
            if fzg(n)==g%������ͬ����ľ͸Ͻ���һ��
                continue;
            end
            if qss(fz(n))~=1
                if qs(fzg(n))==1
                    continue;
                end
            end
            for v=1:(N+G)%��ǰ����g�е��û�                
                if qss(fz(n))~=1
                    if qs(g)==1
                        continue;
                    end
                end
                if gfz(g,v)~=0%����˵��ǰ��v���λ���ڷ���g������ֵ��
                    qs=qsbeifen;
                    qss=qssbeifen;
                    if dis(fz(n))>dis(gfz(g,v))+J(gfz(g,v),fz(n))
                        st=gfz(g,v);%��������ݣ�(��һ��)�����洢��һ�����û����
                        for t=1:(G+N)
                            if qzsz(st,t)==0%��������ݣ����һ��ʼ�ͷ��ֳ����ڵ㣬�����ɳ�
                                dis(fz(n))=dis(gfz(g,v))+J(gfz(g,v),fz(n));
                                fangtongzu;
                                break;
                            end
                            if w(fz(n))==w(qzsz(st,t))%��������ݣ�����ͬ���û�
                                if qzsz(st,t)==fz(n)%��������ݣ���ͬһ�û��������ɳ�
                                    dis(fz(n))=dis(gfz(g,v))+J(gfz(g,v),fz(n));
                                    %dfs(fz(n))=gfz(g,v);%����������ǰ׺�ڵ�
                                    fangtongzu;
                                    break%�����˳�ѭ����
                                else%��������ݣ�ͬһ�鵫�ǲ���ͬһ�û����������ɳ�
                                    if buyao(gfz(g,v),w(fz(n)))==0
                                        qs(w(fz(n)))=1;
                                        qss(fz(n))=1;
                                        [fuhuan,flagtcll,zuiduanqs,zuiduanqshz]=nonqsBell(J,GF,INF,qs,gfz(g,v),yr,w,qzsz,fz,qzjd,qzfz,gfz,fzg,dis,maxedge,qss);
                                        if flagtcll==1
                                            flagtcl=1;
                                            break;
                                        end
                                        if dis(fz(n))>zuiduanqs+J(gfz(g,v),fz(n))
                                            dis(fz(n))=zuiduanqs+J(gfz(g,v),fz(n));
                                            qzsz(fz(n),2:end)=zuiduanqshz(1:(N+G-1));
                                            qzsz(fz(n),1)=gfz(g,v);
                                        end
                                        buyao(gfz(g,v),w(fz(n)))=1;
                                    end
                                    break%�����˳�ѭ����
                                end%���ﲻ���κβ����ǶԵ��𣿲��ԣ���Ҫ����һ���break
                            else
                            end
                        end
                        
                        
                    end
                    
                    panduanfuhuan;
                end
                if gfz(g,v)==0
                    break;
                end
                if flagtcl==1%(��֪����û���õĲ���)
                    break;
                end
            end
            if flagtcl==1%(��֪����û���õĲ���)
                break;
            end
        end
        if flagtcl==1%(��֪����û���õĲ���)
            break;
        end
    end
    if flagtcl==1%(��֪����û���õĲ���)
        break;
    end
    if isequal(disflag,dis)
        break;
    end
end

flagJ=flagfh;%�������
if flagtcll==0%˵��û��ֱ���ҵ������ҵ�����
    %���������Ǹ���ǰ׺�ڵ��ҵ��������Ҳ�ֻҪ�ӵ�tcjd���ϻ��ݣ�һ�������ظ��Ľڵ��˵�������˸�����
    fhjz=zeros(1,(N+G)*2)+(N+G);%�������������ڴ�tcjd��ʼ���ݵľ���
    fhjz(1)=tcjd;
    fhjzx=2;%��������ı��
    fhqs=0;%��������ʼ���ҵ�������Ŀ��˼�¼
    fhzd=0;%�������յ㣩�ҵ���������յ��¼
    flagq=0;%�������
    if flagfh==1%Ҳ����˵���ڸ���
        for i=1:(N+G)*2
            fhjz(i)=qzsz(tcjd,i);
            fhjzx=fhjzx+1;
            for j=1:(i)%Ѱ����û���ظ���
                if (qzsz(tcjd,i)==fhjz(j))&&(i~=j)
                    fhqs=j;
                    fhzd=i;
                    flagq=1;
                    break;
                end
            end
            if flagq==1
                break;
            end
        end
    end
    mm=fhqs;
    
    if flagfh==1%Ҳ����˵���ڸ���
        for i=1:(N+G)%�����
            fuhuan(i)=fhjz(mm);
            mm=mm+1;
            if mm>fhzd
                break;
            end
        end
    end
else
    flagJ=flagtcll;
end
fuhuan2=fuhuan;
flagtcll=flagJ;
zuiduanqs=dis(qzzz);
zuiduanqshz=qzjd(qzzz,:);





