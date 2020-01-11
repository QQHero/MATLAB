for i=2:(G+N)
    if fuhuan(i+1)~=0
        if fuhuan(i)<=N
            if fuhuan(1)<=N%说明两个都是真实用户，可以使用交换函数
                GF=move(GF,qpx,w(fuhuan(i)),fuhuan(i),w(fuhuan(1)),h,rr,rh);%这部分还要好好斟酌，是否会有这种情况
                GF=move(GF,qpx,w(fuhuan(1)),fuhuan(1),w(fuhuan(i)),h,rr,rh);%
                %GF=exchangemn(GF,qpx,w(fuhuan(i)),fuhuan(i),w(fuhuan(1)),fuhuan(1),h,rr,rh);%好像每次交换都是和第一个交换
                www=w(fuhuan(i));%更新w数据
                w(fuhuan(i))=w(fuhuan(1));%更新w数据
                w(fuhuan(1))=www;%更新w数据
            else%说明fuhuan(1)是虚拟用户
                GF=move(GF,qpx,w(fuhuan(i)),fuhuan(i),w(fuhuan(1)),h,rr,rh);%这部分还要好好斟酌，是否会有这种情况
                www=w(fuhuan(i));%更新w数据
                w(fuhuan(i))=w(fuhuan(1));%更新w数据
                w(fuhuan(1))=www;%更新w数据
            end
        else %就是fuhuan(i)是虚拟用户
            if fuhuan(1)<=N%说明fuhuan(1)是真实用户
                GF=move(GF,qpx,w(fuhuan(1)),fuhuan(1),w(fuhuan(i)),h,rr,rh);%
                www=w(fuhuan(i));%更新w数据
                w(fuhuan(i))=w(fuhuan(1));%更新w数据
                w(fuhuan(1))=www;%更新w数据
            else%如果不是以上情况，就只有可能是两个都是虚拟用户，GF不需要变化
                www=w(fuhuan(i));%更新w数据
                w(fuhuan(i))=w(fuhuan(1));%更新w数据
                w(fuhuan(1))=www;%更新w数据
            end
        end
    else
        break;
    end
end

                
            
        
            
    