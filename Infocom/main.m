%output:user grouping strategy(GF1&GF1)

clear all;
close all;
set=20;
buchang=20;
PAsc36=zeros(7,set);
start=buchang;
dy=465;
dnnn=35;
N=40;
ddcs1=zeros(1,set);
ddcs2=zeros(1,set);
BAN=1.8*10^5;alph=1;
groupnum=set;
PA1=0;
PA2=0;
RRR=0;
h=zeros(groupnum,N);
[qpy,qpx]=sort(h,2,'descend');%信道状况全排序,降序
r=(rand(1,N)*7.5+0.5);
hsi=0;
d=rand(1,N)*dy+dnnn;%假设小区半径，基站周围三米无用户
for hs=1:9999
    xxxy=rand*(dy+dnnn);
    yyyx=rand*(dy+dnnn);
    sssyyy=xxxy^2+yyyx^2;
    if sssyyy<=(dy+dnnn)^2
        if sssyyy>=dnnn^2
            hsi=hsi+1;
            d(hsi)=sqrt(sssyyy);
        end
    end
    if hsi==N
        break;
    end
end
ddd=sort(d)/1000;
Pw=1;
Noise=3.981071705534951e-21;%噪声功率
fc=900000000;
for g=1:groupnum
    RL=abs(randn(1,N)+1i*(randn(1,N))).^2/2;
    PL=128.1+37.6.*log10(ddd);
    h(g,:)=RL./(10.^(PL/10))/(BAN*Noise);
end
rf=2.^r;
rr=(2.^r-1);
R=1:N;
rh=zeros(groupnum,N);
for g=1:groupnum
    rh(g,:)=rr./h(g,:);
end

GraphALL;

PA1=PA1+sum(max(GF'));
GF1=GF;

Graphgreedy_jiandanchushihua_jiacan_buchongfu;
PA2=PA2+sum(max(GF'));

GF2=GF;

