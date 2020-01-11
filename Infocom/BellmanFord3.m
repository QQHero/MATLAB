
function [fuhuan,flagJ]=BellmanFord3(J,GF,INF)
yr=0;
[G,N]=size(GF);
flagtcll=0;
flagtcl=0;
qs=zeros(1,G);
qss=zeros(1,(N+G));
buyao=zeros((G+N),(G+N));
qzsz=zeros((N+G),(G+N));%保存前缀的数组，第i行是第i个用户的前缀数组、
w=zeros(1,(N+G));%记录每个用户的分组信息
fuhuan=zeros(1,(N+G));%防止算法无输出
fz=zeros(1,(G+N));%用于放置分组信息，将所有用户按照其分组编号排序；
qzjd=zeros((G+N),(G+N));%用于存储所有用户的所有前缀节点，第n行第m列存储用户n的前缀节点中是否存在用户m,1是存在，0是不存在
qzfz=zeros((G+N),G);%用于存储所有用户的所有前缀节点的分组，第n行第m列存储用户n的前缀节点中是否存在用户m,1是存在，0是不存在
fzx=1;%探查到第几个位置
fzg=fz;%矩阵fz里用户对应的分组编号
gfz=zeros(G,(N+G));%反过来，使得gfz前几个数值就是它所包含的用户，但是具体是用户编号还是用户的fz编号要仔细考量
for j=1:G
    gfzx=1;%探查到了gfz第j行的第几个位置
    for i=1:(N)
        if GF(j,i)~=0
            fz(fzx)=i;
            fzg(fzx)=j;
            fzx=fzx+1;
            gfz(j,gfzx)=i;
            gfzx=gfzx+1;
            w(i)=j;%记录每个用户的分组信息
        end
        if i==N
            fz(fzx)=i+j;
            fzg(fzx)=j;
            fzx=fzx+1;
            gfz(j,gfzx)=i+j;%这样设置的话，gfz与fz是一一对应的
            gfzx=gfzx+1;
            w(N+j)=j;%记录每个用户的分组信息
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
dis=ones(1,(N+G))*maxedge;%初始的超级节点到各个节点的距离，这里的dis(n)就是超级节点到编号为n的用户的距离
dfs=zeros(1,(N+G));%初始为0，就是说初始时上一跳均为超级节点
for C=1:(N+G)%总的大循环次数为节点数减一，这里改成节点数只会增加计算量，不会改变结果。
    for g=1:G%这里要注意每次大循环，进行松弛的顺序是否一致
        for n=1:(N+G)
            if fzg(n)==g%遇到相同分组的就赶紧下一个
                continue;
            end
            for v=1:(N+G)%当前分组g中的用户
                if gfz(g,v)~=0%就是说当前的v这个位置在分组g中是有值的
                    if dis(fz(n))>dis(gfz(g,v))+J(gfz(g,v),fz(n))%如果可以通过点gfz(g,v)对点fz(n)进行松弛，就进行松弛
                        dis(fz(n))=dis(gfz(g,v))+J(gfz(g,v),fz(n));
                        dfs(fz(n))=gfz(g,v);%并更新树的前缀节点
                    end
                end
                if gfz(g,v)==0
                    break;
                end
            end
        end
    end
end





flagfh=0;%判断是否发现负环
tcjd=0;%跳出时节点的值（跳出节点  的拼音）
for g=1:G%这里要注意每次大循环，进行松弛的顺序是否一致
    for n=1:(N+G)
        if fzg(n)==g%遇到相同分组的就赶紧下一个
            continue;
        end
        for v=1:(N+G)%当前分组g中的用户
            if gfz(g,v)~=0%就是说当前的v这个位置在分组g中是有值的
                if dis(fz(n))>dis(gfz(g,v))+J(gfz(g,v),fz(n))%如果可以通过点gfz(g,v)对点fz(n)进行松弛，就进行松弛
                    dis(fz(n))=dis(gfz(g,v))+J(gfz(g,v),fz(n));
                    dfs(fz(n))=gfz(g,v);%并更新树的前缀节点
                    tcjd=(fz(n));%记录下跳出时节点的值（跳出节点  的拼音）
                    flagfh=1;%一旦发现负环，立即跳出，更新标记值
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
flagJ=flagfh;%用来输出








fhjz=zeros(1,(N+G)*2)+(N+G);%（负环矩阵）用于从tcjd开始回溯的矩阵
fhjz(1)=tcjd;
fhjzx=2;%负环矩阵的编号
fhqs=0;%（负环起始）找到负环后的开端记录
fhzd=0;%（负环终点）找到负环后的终点记录
flagq=0;%跳出标记
if flagfh==1%也就是说存在负环
    for i=1:(N+G)*2
        fhjz(fhjzx)=dfs(fhjz(fhjzx-1));
        fhjzx=fhjzx+1;
        for j=1:(fhjzx-2)%寻找有没有重复的
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

if flagfh==1%也就是说存在负环
    for i=1:(N+G)%输出环
        fuhuan(i)=fhjz(mm);
        mm=mm+1;
        if mm>fhzd
            break;
        end
    end
end










fuhuan1=fuhuan;




flagtcl=0;%（跳出来的标志）

flagcf=0;%(重复)说明发生了重复
chongfu=zeros(1,(N+G));%定义一个数组来作为下标
if flagfh==1%也就是说存在负环
    for i=1:(N+G)%输出环
        if fuhuan(i+1)==0%这个判断语句得放前面
            break
        end
        if chongfu(w(fuhuan(i)))~=0%下标非零就说明该处已经有用户了，所以有分组重复的现象
            flagcf=1;
            break;
        else
            chongfu(w(fuhuan(i)))=chongfu(w(fuhuan(i)))+1;
        end
    end
end
if (flagcf==1)||(flagJ==0)%说明是有重复现象发生的，需要重新找环。或者前面的算法不存在负环，需要重新检查一遍。
    maxedge=0;
    fuhuan=zeros(1,(N+G));%防止算法无输出
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
    for C=1:((N+G)*1)%总的大循环次数为节点数减一，这里改成节点数只会增加计算量，不会改变结果。
        for g=1:G%这里要注意每次大循环，进行松弛的顺序是否一致
            for n=1:(N+G)
                if fzg(n)==g%遇到相同分组的就赶紧下一个
                    continue;
                end
                for v=1:(N+G)%当前分组g中的用户
                    if gfz(g,v)~=0%就是说当前的v这个位置在分组g中是有值的
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
                                        fangtongzu;
                                        break%可以退出循环了
                                    else%（添加内容）同一组但是不是同一用户，不允许松弛
                                        break%可以退出循环了
                                    end%这里不加任何操作是对的吗？不对，还要加上一句的break
                                else
                                end
                            end
                            
                            
                        end
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
    end
    
    
    
    
    
    
    %下面这大段与上面这大段的主要区别在于增加了nonqsBell函数
    if flagtcl==0%也就是说上一个没有找到跳出节点
        for C=1:((N+G)*1)%总的大循环次数为节点数减一，这里改成节点数只会增加计算量，不会改变结果。
            disflag=dis;%用于判断该次循环是否没有变化，若无变化，立即退出C循环
            for g=1:G%这里要注意每次大循环，进行松弛的顺序是否一致
                for n=1:(N+G)
                    if fzg(n)==g%遇到相同分组的就赶紧下一个
                        continue;
                    end
                    for v=1:(N+G)%当前分组g中的用户
                        if gfz(g,v)~=0%就是说当前的v这个位置在分组g中是有值的
                            qs=zeros(1,G);
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
                                            break%可以退出循环了
                                        end%这里不加任何操作是对的吗？不对，还要加上一句的break
                                    else
                                    end
                                    %                                 st=dfs(st);%%（添加内容）不能忘了回溯（修改位置后）
                                end
                                
                                
                            end
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
            if  isequal(disflag,dis)
                break;
            end
        end
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    if flagtcl==0
        flagfh=0;%判断是否发现负环
        tcjd=0;%跳出时节点的值（跳出节点  的拼音）
        for g=1:G%这里要注意每次大循环，进行松弛的顺序是否一致
            for n=1:(N+G)
                if fzg(n)==g%遇到相同分组的就赶紧下一个
                    continue;
                end
                for v=1:(N+G)%当前分组g中的用户
                    if gfz(g,v)~=0%就是说当前的v这个位置在分组g中是有值的
                        
                        
                        if dis(fz(n))>dis(gfz(g,v))+J(gfz(g,v),fz(n))
                            st=gfz(g,v);%（添加内容）(上一跳)用来存储上一跳的用户编号
                            for t=1:(G+1)
                                if qzsz(st,t)==0%（添加内容）如果一开始就发现超级节点，可以松弛
                                    dis(fz(n))=dis(gfz(g,v))+J(gfz(g,v),fz(n));
                                    %                                         dfs(fz(n))=gfz(g,v);%并更新树的前缀节点
                                    fangtongzu;
                                    tcjd=(fz(n));%记录下跳出时节点的值（跳出节点  的拼音）
                                    flagfh=1;%一旦发现负环，立即跳出，更新标记值
                                    break;
                                end
                                if w(fz(n))==w(qzsz(st,t))%（添加内容）发现同组用户
                                    if qzsz(st,t)==fz(n)%（添加内容）是同一用户，允许松弛
                                        dis(fz(n))=dis(gfz(g,v))+J(gfz(g,v),fz(n));
                                        %                                         dfs(fz(n))=gfz(g,v);%并更新树的前缀节点
                                        fangtongzu;
                                        tcjd=(fz(n));%记录下跳出时节点的值（跳出节点  的拼音）
                                        flagfh=1;%一旦发现负环，立即跳出，更新标记值
                                        break%可以退出循环了
                                    else%（添加内容）同一组但是不是同一用户，不允许松弛
                                        break%可以退出循环了
                                    end%这里不加任何操作是对的吗？不对，还要加上一句的break
                                else
                                   
                                end
                                %                                 st=dfs(st);%%（添加内容）不能忘了回溯       （修改位置后）
                            end
                            panduanfuhuan;
                        end
                        %                     flagfh;
                        if flagfh==1%（添加内容）
                            break;%（添加内容）
                        end%（添加内容）
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
end
if fuhuan(1)==0
    flagJ=0;
end
qzsz;