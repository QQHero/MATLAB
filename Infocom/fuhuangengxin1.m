for i=2:(G+N)
    if fuhuan(i+1)~=0
        if fuhuan(i)<=N
            if fuhuan(1)<=N%˵������������ʵ�û�������ʹ�ý�������
                GF=move(GF,qpx,w(fuhuan(i)),fuhuan(i),w(fuhuan(1)),h,rr,rh);%�ⲿ�ֻ�Ҫ�ú����ã��Ƿ�����������
                GF=move(GF,qpx,w(fuhuan(1)),fuhuan(1),w(fuhuan(i)),h,rr,rh);%
                %GF=exchangemn(GF,qpx,w(fuhuan(i)),fuhuan(i),w(fuhuan(1)),fuhuan(1),h,rr,rh);%����ÿ�ν������Ǻ͵�һ������
                www=w(fuhuan(i));%����w����
                w(fuhuan(i))=w(fuhuan(1));%����w����
                w(fuhuan(1))=www;%����w����
            else%˵��fuhuan(1)�������û�
                GF=move(GF,qpx,w(fuhuan(i)),fuhuan(i),w(fuhuan(1)),h,rr,rh);%�ⲿ�ֻ�Ҫ�ú����ã��Ƿ�����������
                www=w(fuhuan(i));%����w����
                w(fuhuan(i))=w(fuhuan(1));%����w����
                w(fuhuan(1))=www;%����w����
            end
        else %����fuhuan(i)�������û�
            if fuhuan(1)<=N%˵��fuhuan(1)����ʵ�û�
                GF=move(GF,qpx,w(fuhuan(1)),fuhuan(1),w(fuhuan(i)),h,rr,rh);%
                www=w(fuhuan(i));%����w����
                w(fuhuan(i))=w(fuhuan(1));%����w����
                w(fuhuan(1))=www;%����w����
            else%������������������ֻ�п������������������û���GF����Ҫ�仯
                www=w(fuhuan(i));%����w����
                w(fuhuan(i))=w(fuhuan(1));%����w����
                w(fuhuan(1))=www;%����w����
            end
        end
    else
        break;
    end
end

                
            
        
            
    