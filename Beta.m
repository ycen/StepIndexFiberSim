function [bb, beta] = Beta(l,lambda)

a=105/2; % radius of fiber
%lambda=1.064-dlambda; % wavelength
NA=0.12; % numerical aperture
n2=1.45; % fiber index n2
n1=sqrt(NA^2+n2^2); % fiber index n1
V=2*pi/lambda*a*NA; % normalized waveguide parameter
b=0:0.000001:1; % normalized propagation constant
pos=[]; % find index for b

% find fundamental mode
if l==0
   LHS=V*(1-b).^(1/2).*besselj(1,V*(1-b).^(1/2))./besselj(0,V*(1-b).^(1/2));
   RHS=V*b.^(1/2).*besselk(1,V*b.^(1/2))./besselk(0,V*b.^(1/2));
   diff=LHS-RHS;
end;

% find other modes
if l>0
   LHS=V*(1-b).^(1/2).*besselj(l-1,V*(1-b).^(1/2))./besselj(l,V*(1-b).^(1/2));
   RHS=-1*V*b.^(1/2).*besselk(l-1,V*b.^(1/2))./besselk(l,V*b.^(1/2));
   diff=RHS-LHS;
end;    

% find the zero point
for i=1:length(b)-1
    if diff(i)*diff(i+1)<0
        if diff(i)>0
            pos=[pos i];
        end;    
    end;    
end;

% find all b
beta=zeros(1,length(pos));
for i=1:length(pos)
    b1=b(pos(i)); v1=diff(pos(i));
    b2=b(pos(i)+1); v2=diff(pos(i)+1);
    while b2-b1>1e-14
        bm=(b1+b2)/2;
        if l==0
           LHSm=V*(1-bm)^(1/2)*besselj(1,V*(1-bm)^(1/2))/besselj(0,V*(1-bm)^(1/2));
           RHSm=V*bm^(1/2)*besselk(1,V*bm^(1/2))/besselk(0,V*bm^(1/2));
           vm=LHSm-RHSm;
        end;
        if l>0
           LHSm=V*(1-bm)^(1/2)*besselj(l-1,V*(1-bm)^(1/2))/besselj(l,V*(1-bm)^(1/2));
           RHSm=-1*V*bm^(1/2)*besselk(l-1,V*bm^(1/2))/besselk(l,V*bm^(1/2));
           vm=RHSm-LHSm;
        end;    
        if vm>0
            b1=bm;
            v1=vm;
        end;    
        if vm<0
            b2=bm;
            v2=vm;
        end;    
    end;
    beta(i)=(b1+b2)/2;
end;    

bb = flipud(beta')';
% calculate all beta
beta=2*pi/lambda*sqrt(bb*NA^2+n2^2);