
[XXXh,YYYh]=max(h);
GF=zeros(groupnum,N);
for n=1:(N)
    g=YYYh(n);
    bnj111=0;
    for m=1:N
        if GF(g,m)>bnj111
            if h(g,m)>=h(g,n)
                %if qpx(g,m)>qpx(g,n)
                    bnj111=GF(g,m);
               % end
            end
        end
    end
    GF(g,n)=rh(g,n)+rf(n)*bnj111;
    yy=g;
    for nq=1:N%找到用户n在第yy(1)组中的信道状况排序
        if qpx(yy(1),nq)==n
            break
        end
    end
    bnh=GF(g,n);
    if nq~=N
        for ng3=(nq+1):N%更新数据
            if GF(yy(1),qpx(yy(1),ng3))>0%更新换分组后的分组的数据
                GF(yy(1),qpx(yy(1),ng3))=bnh*(rr(qpx(yy(1),ng3))+1)+rh(yy(1),qpx(yy(1),ng3));
                bnh=GF(yy(1),qpx(yy(1),ng3));
            end
        end
    end
end

