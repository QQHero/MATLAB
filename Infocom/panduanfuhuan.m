%判断有无负环
dfss=zeros(1,(N+G));
tttt=tcjd;
for rrrr=1:(N+G)
    if tttt==0
        flagfh=0;
        break
    else
        tttt=qzsz(tcjd,rrrr);
%         qzsz(tcjd,:)
        if dfss(tttt)>0%有环
            
            dfss(tttt)=dfss(tttt)+1;
            break;
        else
            dfss(tttt)=dfss(tttt)+1;
        end
    
    end
%     tttt;
%     tttt=dfs(tttt);
end