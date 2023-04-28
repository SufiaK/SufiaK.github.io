clear all;
close all;
clc;

load('L.mat');
load('t.mat');

load('Lr.mat');
load('tr.mat');

noise_L=10*1e-3;
L_noise=L+noise_L*randn(size(L));
Lr_noise=Lr+noise_L*randn(size(Lr));
L=L_noise;
Lr=Lr_noise;

%%%moving average
lag=3;
L = movavg(L,'simple',lag);
Lr = movavg(Lr,'simple',lag);
t = movavg(t,'simple',lag);
tr = movavg(tr,'simple',lag);

L=L(lag:end);
Lr=Lr(lag:end);
t=t(lag:end);
tr=tr(lag:end);
% 
t=t*60;
tr=tr*60;
t=t;%+0.1*randn(size(t));
tr=tr;%+0.1*randn(size(tr));

dL=L(2)-L(1);
dLr=Lr(2)-Lr(1);

N=length(L);

alpha=0.18; %gamma*cos(theta)/mu

r=zeros(N-1,1);

dt=diff(t);
dtr0=diff(tr);

dtr=dtr0(end:-1:1);

f=0.25*(dt/dL+dtr/dLr);

x=(L(1:N-1)+L(2:N))/2; %to plot radius at mid point.

r=f.^(1/3).*trapz(x,f.^(-4/3))/alpha;

r = movavg(r,'simple',3);
x = movavg(x,'simple',3);
load('x_actual_new.mat');
load('r_actual_new.mat');

figure(1);
plot(x,r,'o');
hold on
plot(x_actual_new, r_actual_new);
legend('inverse solution','true');
xlabel('x [mm]');
ylabel('r [{\mu}m]');

Lspan=L;
l0=1e-14;
[L_predict,t_predict] = ode23(@(L,t) myfunc(L,t,alpha,r,x), Lspan, l0); %ODE solver. ODEs are defined in calc_flux function
[Lr_predict,tr_predict] = ode23(@(Lr,tr) myfunc_r(Lr,tr,alpha,r,x), Lspan, l0); %ODE solver. ODEs are defined in calc_flux function

figure(2);
plot(L_predict, t_predict, 'bo');
hold on;
plot(L,t, 'b-');
plot(53-Lr_predict, tr_predict, 'ro');
plot(53-Lr,tr, 'r-');
legend('using inverse solution', 'true','using inverse solution', 'true')
xlabel('x [mm]');
ylabel('t [s]');