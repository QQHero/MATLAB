%这个程序生成图
%w(n)是用户n的分组
INF=100000000000000000000000;%不相连
G=groupnum;
J=ones((N+groupnum),(N+groupnum))*INF;




%以下几句用于确定用户所在分组
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




[qpy,qpx]=sort(h,2,'descend');%信道状况全排序,降序
GPj=zeros(1,(groupnum));%每个用户选择过程中记录每组的外部性



for nng=1:(G-1)
    for nnn=1:N%第nng组的第nnn个用户与后面的进行交换试探
        if GF(nng,nnn)~=0
            bnj1n=0;%初始化bn-1
            rliancn=1;%初始化比当前用户信道状态差的用户目标传输速率乘积
            for nnnn=1:N%当前用户在原始分组中的外部性
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
            wbxnn=ann*rliancn;%当前用户在原始分组中的外部性
            
            
            
            
            bbb=bnj1n;
            GFqd=GF;%新建一个数组来保存去掉要交换后的那两个东西
            GFqd(nng,nnn)=0;
            for nnnnnn=1:N%当前用户在原始分组中的外部性
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
            
            
            
            
            
            
            
            
            
            zengyi=zeros(1,N);%需要一个矩阵来记录每次尝试的增益
            zengyig=zeros(1,N);%需要一个矩阵来记录每次尝试时试交换用户所在的分组
            
            
            for mmg=(nng+1):G
                for mmn=1:N%第nng组的第nnn个用户与第mmg组的第mmn个用户与后面的进行交换试探
                    if GF(mmg,mmn)~=0
                        zengyig(mmn)=mmg;
                        bnj1m=0;%初始化bm-1
                        rliancm=1;%初始化比当前试交换的用户信道状态差的用户目标传输速率乘积
                        for nnnm=1:N%当前试交换用户在其原始分组中的外部性
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
                        wbxnm=amm*rliancm;%当前试交换用户在其原始分组中的外部性
                        bnj1jzm(mmn)=bnj1m;%当前试交换用户原始分组中的bn-1数据
                        
                        
                        
                        bbb=bnj1m;
                        GFqdmn=GF;%新建一个数组来保存去掉要交换后的那两个东西
                        GFqdmn(mmg,mmn)=0;
                        for nnnnnn=1:N%当前用户在原始分组中的外部性
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
                        
                        
                        
                        
                        
                        bnj1mn=0;%初始化bmn-1
                        rliancmn=1;%初始化比当前用户信道状态差的用户目标传输速率乘积
                        for nnnmn=1:N%当前用户在其当前待交换用户分组中的外部性
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
                        wbxnmn=(anmn)*rliancmn;%当前用户在其当前待交换用户分组中的外部性
                        bnj1jzmn(mmn)=bnj1mn;%当前用户原始分组中的bn-1数据
                        
                        
                        
                        
                        
                        
                        bnj1nm=0;%初始化bnm-1
                        rliancnm=1;%初始化比当前试交换的用户信道状态差的用户目标传输速率乘积
                        for nnnnm=1:N%当前待交换用户在当前用户分组中的外部性
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
                        wbxnnm=(annm)*rliancnm;%当前待交换用户在其当前待交换用户（n）分组中的外部性
                        bnj1jznm(mmn)=bnj1nm;%当前用户原始分组中的bn-1数据
                        
                        zengyi(mmn)=wbxnmn+wbxnnm-wbxnn-wbxnm;
                        
                        
                        J(nnn,mmn)=wbxnmn-wbxnn;%有向图邻接矩阵
                        J(mmn,nnn)=wbxnnm-wbxnm;%有向图邻接矩阵
                        
                    end
                    
                end
                
            end
            
            
        end
    end
    
end
for n=1:N%单个用户去另一分组，不挤兑其他用户
    wbx=0;
    wbjz=zeros(groupnum,N);%记录给其他用户带来的外部性
    bnj1=zeros(groupnum,1);%记录在各组中的前一用户处的总功率
    
    
    for g=1:(groupnum)%每个用户的每个分组比较
        if GF(g,n)~=0
            continue;
        end
        for nq=1:N%找到用户n在第g组中的信道状况排序,nq是在当前分组中的
            if qpx(g,nq)==n
                break
            end
        end
        flagtx1=0;%判断该用户是否为第一个（是不是没必要？）
        %             hlast=n;%该组中恰好优于该用户用户编号
        if nq~=0%????????????????????
            bn1=0;
            for ng=1:N%找该组比用户n信道条件好的用户中最差的那个处所需要的功率
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
        if flagtx1==0%未找到分组g中信道优于用户n的
            bn1=0;
        end
        bnj1(g)=bn1;%记录在各组中的前一用户处的总功率
        an=rr(n)*bn1+rh(g,n);
        wbx=an;
        wbjz(g,n)=wbx;
        if nq~=N
            for ng2=(nq+1):N%计算外部性
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

        
        
        
        
        
        
