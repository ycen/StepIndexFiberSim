function Fun = ModeFun(l,m,b,cs,lambda)
% generate function for mode lm, cs is polariztion

a=105/2;
%lambda=1.064;
NA=0.12;
n2=1.45;
n1=sqrt(NA^2+n2^2);
V=2*pi/lambda*a*NA;

%b=FiberMode(l);
%if m>length(b)
%    display('ERROR: This mode does NOT exist!');
%    return;
%end; 

%W=V*sqrt(b(m));
%U=V*sqrt(1-b(m));
W=V*sqrt(b);
U=V*sqrt(1-b);
[X,Y]=meshgrid(linspace(-55,55,110));
[theta,r]=cart2pol(X,Y);

if cs==0
    c=besselj(l,U*r/a).*cos(l*theta);
    ind=find(r>a);
    c(ind)=besselk(l,W*r(ind)/a).*cos(l*theta(ind))/besselk(l,W)*besselj(l,U);
end;
    

if cs==1
    c=besselj(l,U*r/a).*sin(l*theta);
    ind=find(r>a);
    c(ind)=besselk(l,W*r(ind)/a).*sin(l*theta(ind))/besselk(l,W)*besselj(l,U);
end;
    

Norm=sum(sum(c.*c));
if Norm~=0
   Fun=c/sqrt(Norm);
else
   Fun=c;
end;
   

%imagesc(linspace(-1*a,a,296),linspace(-1*a,a,296),Fun);
%axis image;
%colorbar;