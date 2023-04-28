function r0 = myradius_r(x,r,x_ini)


 x=x_ini(end)-x;
[~,b]=min(abs(x_ini-x)); %find x closest and use that value
r0=r(b);
 end