
qzjd(fz(n),:)=qzjd(gfz(g,v),:);
qzjd(fz(n),gfz(g,v))=1;
qzfz(fz(n),:)=qzfz(gfz(g,v),:);
qzfz(fz(n),w(gfz(g,v)))=1;
qzsz(fz(n),2:end)=qzsz(gfz(g,v),1:(N+G-1));
qzsz(fz(n),1)=gfz(g,v);
if qzsz(fz(n),(G+1))~=0
    flagtcl=1;
    tcjd=fz(n);
end






            
        