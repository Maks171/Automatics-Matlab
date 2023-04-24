function[MSE] = kupf1(wej, obj)
T = wej(1);
tau = wej(2);
n = obj;
load pomiary_3out.mat;
y = pomiary_3out;
y=pomiary_3out(:,n) - pomiary_3out(1,n);
k=y(300,1)-y(1,1);
[ld,md]=pade(tau,10);
[l,m]=series(ld,md,[k],[T,1]);
czas=1:1:300;
ym = step(l,m,czas);
MSE= sum((y-ym).^2);
u = ones(size(y));
yexper = iddata(y, u, 1);
ymodel = tf(l, m);
compare(yexper, ymodel, 300);
grid;
end