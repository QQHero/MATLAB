%�����������ͼ
%w(n)���û�n�ķ���
INF=100000000000000000000000;%������
G=groupnum;
J=ones((N+groupnum),(N+groupnum))*INF;




%���¼�������ȷ���û����ڷ���
w=zeros(1,(N+G));
for g=1:G
    for n=1:N
        if GF(g,n)~=0
            w(n)=g;
        end
    end
end
for g=1:G
    w(g+N)=g;
end




[qpy,qpx]=sort(h,2,'descend');%�ŵ�״��ȫ����,����
GPj=zeros(1,(groupnum));%ÿ���û�ѡ������м�¼ÿ����ⲿ��



for nng=1:(G-1)
    for nnn=1:N%��nng��ĵ�nnn���û������Ľ��н�����̽
        if GF(nng,nnn)~=0
            bnj1n=0;%��ʼ��bn-1
            rliancn=1;%��ʼ���ȵ�ǰ�û��ŵ�״̬����û�Ŀ�괫�����ʳ˻�
            for nnnn=1:N%��ǰ�û���ԭʼ�����е��ⲿ��
                if nnnn==nnn%????????
                    continue;
                end
                if GF(nng,nnnn)>GF(nng,nnn)
                    rliancn=rf(nnnn)*rliancn;%??????????????????
                elseif bnj1n<GF(nng,nnnn)
                    bnj1n=GF(nng,nnnn);
                end
            end
            ann=(bnj1n+1/h(nng,nnn))*rr(nnn);
            wbxnn=ann*rliancn;%��ǰ�û���ԭʼ�����е��ⲿ��
            
            
            
            
            bbb=bnj1n;
            GFqd=GF;%�½�һ������������ȥ��Ҫ�����������������
            GFqd(nng,nnn)=0;
            for nnnnnn=1:N%��ǰ�û���ԭʼ�����е��ⲿ��
                if qpx(nng,nnnnnn)==nnn
                    if nnnnnn~=N
                        GFqd(nng,qpx(nng,nnnnnn))=0;%???????????????
                        for nnnnnnn=(nnnnnn+1):N
                            if GFqd(nng,qpx(nng,nnnnnnn))>0
                                GFqd(nng,qpx(nng,nnnnnnn))=rr(qpx(nng,nnnnnnn))*(bbb+1/h(nng,qpx(nng,nnnnnnn)))+bbb;%??????????????????????
                                bbb=GFqd(nng,qpx(nng,nnnnnnn));%???????????????????????
                            end
                        end
                    end
                    break;
                end
            end
            
            
            
            
            
            
            
            
            
            zengyi=zeros(1,N);%��Ҫһ����������¼ÿ�γ��Ե�����
            zengyig=zeros(1,N);%��Ҫһ����������¼ÿ�γ���ʱ�Խ����û����ڵķ���
            
            
            for mmg=(nng+1):G
                for mmn=1:N%��nng��ĵ�nnn���û����mmg��ĵ�mmn���û������Ľ��н�����̽
                    if GF(mmg,mmn)~=0
                        zengyig(mmn)=mmg;
                        bnj1m=0;%��ʼ��bm-1
                        rliancm=1;%��ʼ���ȵ�ǰ�Խ������û��ŵ�״̬����û�Ŀ�괫�����ʳ˻�
                        for nnnm=1:N%��ǰ�Խ����û�����ԭʼ�����е��ⲿ��
                            if nnnm==mmn
                                continue;
                            end
                            
                            if GF(mmg,nnnm)>GF(mmg,mmn)
                                rliancm=rf(nnnm)*rliancm;%????????????????????
                            elseif bnj1m<GF(mmg,nnnm)
                                bnj1m=GF(mmg,nnnm);
                            end
                        end
                        amm=(bnj1m+1/h(mmg,mmn))*rr(mmn);
                        wbxnm=amm*rliancm;%��ǰ�Խ����û�����ԭʼ�����е��ⲿ��
                        bnj1jzm(mmn)=bnj1m;%��ǰ�Խ����û�ԭʼ�����е�bn-1����
                        
                        
                        
                        bbb=bnj1m;
                        GFqdmn=GF;%�½�һ������������ȥ��Ҫ�����������������
                        GFqdmn(mmg,mmn)=0;
                        for nnnnnn=1:N%��ǰ�û���ԭʼ�����е��ⲿ��
                            if qpx(mmg,nnnnnn)==mmn%??????????????
                                if nnnnnn~=N
                                    for nnnnnnn=(nnnnnn+1):N
                                        if GFqdmn(mmg,qpx(mmg,nnnnnnn))>0
                                            GFqdmn(mmg,qpx(mmg,nnnnnnn))=rr(qpx(mmg,nnnnnnn))*(bbb+1/h(mmg,qpx(mmg,nnnnnnn)))+bbb;%??????????????????????
                                            bbb=GFqdmn(mmg,qpx(mmg,nnnnnnn));%?????????????
                                        end
                                    end
                                end
                                break;
                            end
                        end
                        
                        
                        
                        
                        
                        bnj1mn=0;%��ʼ��bmn-1
                        rliancmn=1;%��ʼ���ȵ�ǰ�û��ŵ�״̬����û�Ŀ�괫�����ʳ˻�
                        for nnnmn=1:N%��ǰ�û����䵱ǰ�������û������е��ⲿ��
                            if nnnmn==nnn
                                continue;
                            end
                            if nnnmn==mmn
                                continue;
                            end
                            if GFqdmn(mmg,nnnmn)~=0
                                if h(mmg,nnnmn)<=h(mmg,nnn)
                                    rliancmn=rf(nnnmn)*rliancmn;%????????????????????
                                elseif bnj1mn<GFqdmn(mmg,nnnmn)
                                    bnj1mn=GFqdmn(mmg,nnnmn);
                                end
                            end
                        end
                        anmn=(bnj1mn+1/h(mmg,nnn))*rr(nnn);
                        wbxnmn=(anmn)*rliancmn;%��ǰ�û����䵱ǰ�������û������е��ⲿ��
                        bnj1jzmn(mmn)=bnj1mn;%��ǰ�û�ԭʼ�����е�bn-1����
                        
                        
                        
                        
                        
                        
                        bnj1nm=0;%��ʼ��bnm-1
                        rliancnm=1;%��ʼ���ȵ�ǰ�Խ������û��ŵ�״̬����û�Ŀ�괫�����ʳ˻�
                        for nnnnm=1:N%��ǰ�������û��ڵ�ǰ�û������е��ⲿ��
                            if nnnnm==mmn
                                continue;
                            end
                            if nnnnm==nnn
                                continue;
                            end
                            if GFqd(nng,nnnnm)>0
                                if h(nng,nnnnm)<=h(nng,mmn)%?????
                                    rliancnm=rf(nnnnm)*rliancnm;%????????????????????
                                else
                                    if bnj1nm<GFqd(nng,nnnnm)
                                        bnj1nm=GFqd(nng,nnnnm);
                                    end
                                end
                            end
                        end
                        annm=(bnj1nm+1/h(nng,mmn))*rr(mmn);
                        wbxnnm=(annm)*rliancnm;%��ǰ�������û����䵱ǰ�������û���n�������е��ⲿ��
                        bnj1jznm(mmn)=bnj1nm;%��ǰ�û�ԭʼ�����е�bn-1����
                        
                        zengyi(mmn)=wbxnmn+wbxnnm-wbxnn-wbxnm;
                        
                        
                        J(nnn,mmn)=wbxnmn-wbxnn;%����ͼ�ڽӾ���
                        J(mmn,nnn)=wbxnnm-wbxnm;%����ͼ�ڽӾ���
                        
                    end
                    
                end
                
            end
            
            
        end
    end
    
end
for n=1:N%�����û�ȥ��һ���飬�����������û�
    wbx=0;
    wbjz=zeros(groupnum,N);%��¼�������û��������ⲿ��
    bnj1=zeros(groupnum,1);%��¼�ڸ����е�ǰһ�û������ܹ���
    
    
    for g=1:(groupnum)%ÿ���û���ÿ������Ƚ�
        if GF(g,n)~=0
            continue;
        end
        for nq=1:N%�ҵ��û�n�ڵ�g���е��ŵ�״������,nq���ڵ�ǰ�����е�
            if qpx(g,nq)==n
                break
            end
        end
        flagtx1=0;%�жϸ��û��Ƿ�Ϊ��һ�����ǲ���û��Ҫ����
        %             hlast=n;%������ǡ�����ڸ��û��û����
        if nq~=0%????????????????????
            bn1=0;
            for ng=1:N%�Ҹ�����û�n�ŵ������õ��û��������Ǹ�������Ҫ�Ĺ���
                if GF(g,ng)~=0
                    if h(g,ng)>h(g,n)
                        if bn1<GF(g,ng)
                            bn1=GF(g,ng);
                            flagtx1=1;
                        end
                    end
                end
            end
            
            
        end
        if flagtx1==0%δ�ҵ�����g���ŵ������û�n��
            bn1=0;
        end
        bnj1(g)=bn1;%��¼�ڸ����е�ǰһ�û������ܹ���
        an=rr(n)*bn1+rh(g,n);
        wbx=an;
        wbjz(g,n)=wbx;
        if nq~=N
            for ng2=(nq+1):N%�����ⲿ��
                if GF(g,qpx(g,ng2))~=0
                    %                         wbjz(g,qpx(g,ng2))=wbx*rr(qpx(g,ng2));
                    wbx=wbx*rf(qpx(g,ng2));
                end
            end
        end
        GPj(g)=wbx;
        J(n,N+g)=wbx;
        
    end
    
end
for i=(N+1):(N+G)
    for j=(N+1):(N+G)
        if i~=j
            J(i,j)=0;
        end
    end
end
for i=(N+1):(N+G)
    for j=1:(N)
        if GF((i-N),j)==0
            J(i,j)=0;
        end
    end
end

        
        
        
        
        
        
