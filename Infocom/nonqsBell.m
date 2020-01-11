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
flagfh=0;%判断是否发现负环
qsbeifen=qs;

qssbeifen=qss;
tcjd=0;
fuhuan=zeros(1,(N+G));
gfz=zeros(G,(N+G));%反过来，使得gfz前几个数值就是它所包含的用户，但是具体是用户编号还是用户的fz编号要仔细考量
flagtcl=0;






for n=1:(G+N)
        if ~(isequal((qzfz(n,:).*qs),zeros(1,G)))
            qzfz(n,:)=zeros(1,G);
            qzjd(n,:)=zeros(1,(N+G));
            qzsz(n,:)=zeros(1,(N+G));
            dis(n)=maxedge;
        end
end
















for C=1:((N+G)*1)%总的大循环次数为节点数减一，这里改成节点数只会增加计算量，不会改变结果。
    disflag=dis;%用于判断该次循环是否没有变化，若无变化，立即退出C循环
    for g=1:G%这里要注意每次大循环，进行松弛的顺序是否一致
        
        for n=1:(N+G)
            
            if fzg(n)==g%遇到相同分组的就赶紧下一个
                continue;
            end
            if qss(fz(n))~=1
                if qs(fzg(n))==1
                    continue;
                end
            end
            for v=1:(N+G)%当前分组g中的用户                
                if qss(fz(n))~=1
                    if qs(g)==1
                        continue;
                    end
                end
                if gfz(g,v)~=0%就是说当前的v这个位置在分组g中是有值的
                    qs=qsbeifen;
                    qss=qssbeifen;
                    if dis(fz(n))>dis(gfz(g,v))+J(gfz(g,v),fz(n))
                        st=gfz(g,v);%（添加内容）(上一跳)用来存储上一跳的用户编号
                        for t=1:(G+N)
                            if qzsz(st,t)==0%（添加内容）如果一开始就发现超级节点，可以松弛
                                dis(fz(n))=dis(gfz(g,v))+J(gfz(g,v),fz(n));
                                fangtongzu;
                                break;
                            end
                            if w(fz(n))==w(qzsz(st,t))%（添加内容）发现同组用户
                                if qzsz(st,t)==fz(n)%（添加内容）是同一用户，允许松弛
                                    dis(fz(n))=dis(gfz(g,v))+J(gfz(g,v),fz(n));
                                    %dfs(fz(n))=gfz(g,v);%并更新树的前缀节点
                                    fangtongzu;
                                    break%可以退出循环了
                                else%（添加内容）同一组但是不是同一用户，不允许松弛
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
                                    break%可以退出循环了
                                end%这里不加任何操作是对的吗？不对，还要加上一句的break
                            else
                            end
                        end
                        
                        
                    end
                    
                    panduanfuhuan;
                end
                if gfz(g,v)==0
                    break;
                end
                if flagtcl==1%(不知道有没有用的补丁)
                    break;
                end
            end
            if flagtcl==1%(不知道有没有用的补丁)
                break;
            end
        end
        if flagtcl==1%(不知道有没有用的补丁)
            break;
        end
    end
    if flagtcl==1%(不知道有没有用的补丁)
        break;
    end
    if isequal(disflag,dis)
        break;
    end
end

flagJ=flagfh;%用来输出
if flagtcll==0%说明没有直接找到负环找到负环
    %接下来就是根据前缀节点找到负环，我猜只要从点tcjd往上回溯，一旦发现重复的节点就说明出现了负环；
    fhjz=zeros(1,(N+G)*2)+(N+G);%（负环矩阵）用于从tcjd开始回溯的矩阵
    fhjz(1)=tcjd;
    fhjzx=2;%负环矩阵的编号
    fhqs=0;%（负环起始）找到负环后的开端记录
    fhzd=0;%（负环终点）找到负环后的终点记录
    flagq=0;%跳出标记
    if flagfh==1%也就是说存在负环
        for i=1:(N+G)*2
            fhjz(i)=qzsz(tcjd,i);
            fhjzx=fhjzx+1;
            for j=1:(i)%寻找有没有重复的
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
    
    if flagfh==1%也就是说存在负环
        for i=1:(N+G)%输出环
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





