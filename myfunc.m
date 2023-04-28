function dtdL = myfunc(L,t,alpha,r,x_ini)

rL=myradius(L,r,x_ini);

xx=linspace(0,L,500);

I=trapz(xx,myradius(xx,r,x_ini).^(-4));

%dLdt= alpha*r/(4*L);
dtdL= (4*rL^3*I)/alpha;
end