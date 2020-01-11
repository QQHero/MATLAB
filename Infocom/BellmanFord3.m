
function [fuhuan,flagJ]=BellmanFord3(J,GF,INF)
yr=0;
[G,N]=size(GF);
flagtcll=0;
flagtcl=0;
qs=zeros(1,G);
qss=zeros(1,(N+G));
buyao=zeros((G+N),(G+N));
qzsz=zeros((N+G),(G+N));%����ǰ׺�����飬��i���ǵ�i���û���ǰ׺���顢
w=zeros(1,(N+G));%��¼ÿ���û��ķ�����Ϣ
fuhuan=zeros(1,(N+G));%��ֹ�㷨�����
fz=zeros(1,(G+N));%���ڷ��÷�����Ϣ���������û����������������
qzjd=zeros((G+N),(G+N));%���ڴ洢�����û�������ǰ׺�ڵ㣬��n�е�m�д洢�û�n��ǰ׺�ڵ����Ƿ�����û�m,1�Ǵ��ڣ�0�ǲ�����
qzfz=zeros((G+N),G);%���ڴ洢�����û�������ǰ׺�ڵ�ķ��飬��n�е�m�д洢�û�n��ǰ׺�ڵ����Ƿ�����û�m,1�Ǵ��ڣ�0�ǲ�����
fzx=1;%̽�鵽�ڼ���λ��
fzg=fz;%����fz���û���Ӧ�ķ�����
gfz=zeros(G,(N+G));%��������ʹ��gfzǰ������ֵ���������������û������Ǿ������û���Ż����û���fz���Ҫ��ϸ����
for j=1:G
    gfzx=1;%̽�鵽��gfz��j�еĵڼ���λ��
    for i=1:(N)
        if GF(j,i)~=0
            fz(fzx)=i;
            fzg(fzx)=j;
            fzx=fzx+1;
            gfz(j,gfzx)=i;
            gfzx=gfzx+1;
            w(i)=j;%��¼ÿ���û��ķ�����Ϣ
        end
        if i==N
            fz(fzx)=i+j;
            fzg(fzx)=j;
            fzx=fzx+1;
            gfz(j,gfzx)=i+j;%�������õĻ���gfz��fz��һһ��Ӧ��
            gfzx=gfzx+1;
            w(N+j)=j;%��¼ÿ���û��ķ�����Ϣ
        end
    end
end




maxedge=0;
for i=1:(N+G)
    for j=1:(N+G)
        if J(i,j)~=INF
            if maxedge<J(i,j)
                maxedge=J(i,j);
            end
        end
    end
end
dis=ones(1,(N+G))*maxedge;%��ʼ�ĳ����ڵ㵽�����ڵ�ľ��룬�����dis(n)���ǳ����ڵ㵽���Ϊn���û��ľ���
dfs=zeros(1,(N+G));%��ʼΪ0������˵��ʼʱ��һ����Ϊ�����ڵ�
for C=1:(N+G)%�ܵĴ�ѭ������Ϊ�ڵ�����һ������ĳɽڵ���ֻ�����Ӽ�����������ı�����
    for g=1:G%����Ҫע��ÿ�δ�ѭ���������ɳڵ�˳���Ƿ�һ��
        for n=1:(N+G)
            if fzg(n)==g%������ͬ����ľ͸Ͻ���һ��
                continue;
            end
            for v=1:(N+G)%��ǰ����g�е��û�
                if gfz(g,v)~=0%����˵��ǰ��v���λ���ڷ���g������ֵ��
                    if dis(fz(n))>dis(gfz(g,v))+J(gfz(g,v),fz(n))%�������ͨ����gfz(g,v)�Ե�fz(n)�����ɳڣ��ͽ����ɳ�
                        dis(fz(n))=dis(gfz(g,v))+J(gfz(g,v),fz(n));
                        dfs(fz(n))=gfz(g,v);%����������ǰ׺�ڵ�
                    end
                end
                if gfz(g,v)==0
                    break;
                end
            end
        end
    end
end





flagfh=0;%�ж��Ƿ��ָ���
tcjd=0;%����ʱ�ڵ��ֵ�������ڵ�  ��ƴ����
for g=1:G%����Ҫע��ÿ�δ�ѭ���������ɳڵ�˳���Ƿ�һ��
    for n=1:(N+G)
        if fzg(n)==g%������ͬ����ľ͸Ͻ���һ��
            continue;
        end
        for v=1:(N+G)%��ǰ����g�е��û�
            if gfz(g,v)~=0%����˵��ǰ��v���λ���ڷ���g������ֵ��
                if dis(fz(n))>dis(gfz(g,v))+J(gfz(g,v),fz(n))%�������ͨ����gfz(g,v)�Ե�fz(n)�����ɳڣ��ͽ����ɳ�
                    dis(fz(n))=dis(gfz(g,v))+J(gfz(g,v),fz(n));
                    dfs(fz(n))=gfz(g,v);%����������ǰ׺�ڵ�
                    tcjd=(fz(n));%��¼������ʱ�ڵ��ֵ�������ڵ�  ��ƴ����
                    flagfh=1;%һ�����ָ������������������±��ֵ
                    break;
                end
            end
        end
        if flagfh==1
            break;
        end
    end
    if flagfh==1
        break;
    end
end
flagJ=flagfh;%�������








fhjz=zeros(1,(N+G)*2)+(N+G);%�������������ڴ�tcjd��ʼ���ݵľ���
fhjz(1)=tcjd;
fhjzx=2;%��������ı��
fhqs=0;%��������ʼ���ҵ�������Ŀ��˼�¼
fhzd=0;%�������յ㣩�ҵ���������յ��¼
flagq=0;%�������
if flagfh==1%Ҳ����˵���ڸ���
    for i=1:(N+G)*2
        fhjz(fhjzx)=dfs(fhjz(fhjzx-1));
        fhjzx=fhjzx+1;
        for j=1:(fhjzx-2)%Ѱ����û���ظ���
            if fhjz(fhjzx-1)==fhjz(j)
                fhqs=j;
                fhzd=fhjzx-1;
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










fuhuan1=fuhuan;




flagtcl=0;%���������ı�־��

flagcf=0;%(�ظ�)˵���������ظ�
chongfu=zeros(1,(N+G));%����һ����������Ϊ�±�
if flagfh==1%Ҳ����˵���ڸ���
    for i=1:(N+G)%�����
        if fuhuan(i+1)==0%����ж����÷�ǰ��
            break
        end
        if chongfu(w(fuhuan(i)))~=0%�±�����˵���ô��Ѿ����û��ˣ������з����ظ�������
            flagcf=1;
            break;
        else
            chongfu(w(fuhuan(i)))=chongfu(w(fuhuan(i)))+1;
        end
    end
end
if (flagcf==1)||(flagJ==0)%˵�������ظ��������ģ���Ҫ�����һ�������ǰ����㷨�����ڸ�������Ҫ���¼��һ�顣
    maxedge=0;
    fuhuan=zeros(1,(N+G));%��ֹ�㷨�����
    for i=1:(N+G)
        for j=1:(N+G)
            if J(i,j)~=INF
                if maxedge<J(i,j)
                    maxedge=J(i,j);
                end
            end
        end
    end
    dis=ones(1,(N+G))*maxedge;
    for C=1:((N+G)*1)%�ܵĴ�ѭ������Ϊ�ڵ�����һ������ĳɽڵ���ֻ�����Ӽ�����������ı�����
        for g=1:G%����Ҫע��ÿ�δ�ѭ���������ɳڵ�˳���Ƿ�һ��
            for n=1:(N+G)
                if fzg(n)==g%������ͬ����ľ͸Ͻ���һ��
                    continue;
                end
                for v=1:(N+G)%��ǰ����g�е��û�
                    if gfz(g,v)~=0%����˵��ǰ��v���λ���ڷ���g������ֵ��
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
                                        fangtongzu;
                                        break%�����˳�ѭ����
                                    else%��������ݣ�ͬһ�鵫�ǲ���ͬһ�û����������ɳ�
                                        break%�����˳�ѭ����
                                    end%���ﲻ���κβ����ǶԵ��𣿲��ԣ���Ҫ����һ���break
                                else
                                end
                            end
                            
                            
                        end
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
    end
    
    
    
    
    
    
    %�����������������ε���Ҫ��������������nonqsBell����
    if flagtcl==0%Ҳ����˵��һ��û���ҵ������ڵ�
        for C=1:((N+G)*1)%�ܵĴ�ѭ������Ϊ�ڵ�����һ������ĳɽڵ���ֻ�����Ӽ�����������ı�����
            disflag=dis;%�����жϸô�ѭ���Ƿ�û�б仯�����ޱ仯�������˳�Cѭ��
            for g=1:G%����Ҫע��ÿ�δ�ѭ���������ɳڵ�˳���Ƿ�һ��
                for n=1:(N+G)
                    if fzg(n)==g%������ͬ����ľ͸Ͻ���һ��
                        continue;
                    end
                    for v=1:(N+G)%��ǰ����g�е��û�
                        if gfz(g,v)~=0%����˵��ǰ��v���λ���ڷ���g������ֵ��
                            qs=zeros(1,G);
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
                                        else
                                            if buyao(gfz(g,v),fz(n))==0
                                                qs(w(fz(n)))=1;
                                                qss(fz(n))=1;
                                                qs;
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
%                                                 buyao(gfz(g,v),w(fz(n)))=1;
                                                buyao(gfz(g,v),fz(n))=1;
                                            end
                                            break%�����˳�ѭ����
                                        end%���ﲻ���κβ����ǶԵ��𣿲��ԣ���Ҫ����һ���break
                                    else
                                    end
                                    %                                 st=dfs(st);%%��������ݣ��������˻��ݣ��޸�λ�ú�
                                end
                                
                                
                            end
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
            if  isequal(disflag,dis)
                break;
            end
        end
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    if flagtcl==0
        flagfh=0;%�ж��Ƿ��ָ���
        tcjd=0;%����ʱ�ڵ��ֵ�������ڵ�  ��ƴ����
        for g=1:G%����Ҫע��ÿ�δ�ѭ���������ɳڵ�˳���Ƿ�һ��
            for n=1:(N+G)
                if fzg(n)==g%������ͬ����ľ͸Ͻ���һ��
                    continue;
                end
                for v=1:(N+G)%��ǰ����g�е��û�
                    if gfz(g,v)~=0%����˵��ǰ��v���λ���ڷ���g������ֵ��
                        
                        
                        if dis(fz(n))>dis(gfz(g,v))+J(gfz(g,v),fz(n))
                            st=gfz(g,v);%��������ݣ�(��һ��)�����洢��һ�����û����
                            for t=1:(G+1)
                                if qzsz(st,t)==0%��������ݣ����һ��ʼ�ͷ��ֳ����ڵ㣬�����ɳ�
                                    dis(fz(n))=dis(gfz(g,v))+J(gfz(g,v),fz(n));
                                    %                                         dfs(fz(n))=gfz(g,v);%����������ǰ׺�ڵ�
                                    fangtongzu;
                                    tcjd=(fz(n));%��¼������ʱ�ڵ��ֵ�������ڵ�  ��ƴ����
                                    flagfh=1;%һ�����ָ������������������±��ֵ
                                    break;
                                end
                                if w(fz(n))==w(qzsz(st,t))%��������ݣ�����ͬ���û�
                                    if qzsz(st,t)==fz(n)%��������ݣ���ͬһ�û��������ɳ�
                                        dis(fz(n))=dis(gfz(g,v))+J(gfz(g,v),fz(n));
                                        %                                         dfs(fz(n))=gfz(g,v);%����������ǰ׺�ڵ�
                                        fangtongzu;
                                        tcjd=(fz(n));%��¼������ʱ�ڵ��ֵ�������ڵ�  ��ƴ����
                                        flagfh=1;%һ�����ָ������������������±��ֵ
                                        break%�����˳�ѭ����
                                    else%��������ݣ�ͬһ�鵫�ǲ���ͬһ�û����������ɳ�
                                        break%�����˳�ѭ����
                                    end%���ﲻ���κβ����ǶԵ��𣿲��ԣ���Ҫ����һ���break
                                else
                                   
                                end
                                %                                 st=dfs(st);%%��������ݣ��������˻���       ���޸�λ�ú�
                            end
                            panduanfuhuan;
                        end
                        %                     flagfh;
                        if flagfh==1%��������ݣ�
                            break;%��������ݣ�
                        end%��������ݣ�
                    end
                end
                if flagfh==1
                    break;
                end
            end
            if flagfh==1
                break;
            end
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
end
if fuhuan(1)==0
    flagJ=0;
end
qzsz;