function r0 = myradius(x,r,x_ini)
% % x_ini=x_ini*1e-3;%in m
% x=x*1e-3;%in m
%r0=interp1(x_ini, r, x, 'linear');

[~,b]=min(abs(x_ini-x)); %find x closest and use that value
r0=r(b);

 end