tic;
intf = zeros(1,137);
ints = zeros(1,137);
%map = zeros(1,137);
maxint = 0;
tphase = 0;
D = zeros(1,2);
%x=55; y=55;


for num = 1:137
    C = zeros(1,3);
    for i = 1:3
    	map(num) = (i-1)/2*pi;
        outf = zeros(1,375);
        for m = 1:182
            as = sum(squeeze(amps(:,m)) .* exp(1i*(map+randshift(m,:)))');
            ap = sum(squeeze(ampp(:,m)) .* exp(1i*(map+randshift(m,:)))');
            phases = phase(as);
            abss = abs(as) * wvfuns(m,y,x);
            phasep = phase(ap);
            absp = abs(ap) * wvfunp(m,y,x);
            outf = outf + abss*(squeeze(cosp(m,:))*cos(phases)-squeeze(sinp(m,:))*sin(phases)) ...
                        + absp*(squeeze(cosp(m,:))*cos(phasep)-squeeze(sinp(m,:))*sin(phasep));
        end;
        C(i) = sum((outf.*outf).^2);
        %break;
    end;
    B = (C(1)+C(3))/2;
    if (C(1)-B)==0
       if B-C(2)<0
          phi = -1*pi/2;
       else
          phi = pi/2;
       end;
    else    
       phi = atan((B-C(2))/(C(1)-B));
    end;
    if phi<0
        p1 = -1*phi;
        p2 = p1+pi;
    else
        p1 = pi-phi;
        p2 = p1+pi;
    end;
    map(num) = p1;
    outf = zeros(1,375);
    for m = 1:182
        as = sum(squeeze(amps(:,m)) .* exp(1i*(map+randshift(m,:)))');
        ap = sum(squeeze(ampp(:,m)) .* exp(1i*(map+randshift(m,:)))');
        phases = phase(as);
        abss = abs(as) * wvfuns(m,y,x);
        phasep = phase(ap);
        absp = abs(ap) * wvfunp(m,y,x);
        outf = outf + abss*(squeeze(cosp(m,:))*cos(phases)-squeeze(sinp(m,:))*sin(phases)) ...
                    + absp*(squeeze(cosp(m,:))*cos(phasep)-squeeze(sinp(m,:))*sin(phasep));
    end;
    C(1) = sum(outf.*outf);  
    D(1) = sum((outf.*outf).^2); 
    map(num) = p2;
    outf = zeros(1,375);
    for m = 1:182
        as = sum(squeeze(amps(:,m)) .* exp(1i*(map+randshift(m,:)))');
        ap = sum(squeeze(ampp(:,m)) .* exp(1i*(map+randshift(m,:)))');
        phases = phase(as);
        abss = abs(as) * wvfuns(m,y,x);
        phasep = phase(ap);
        absp = abs(ap) * wvfunp(m,y,x);
        outf = outf + abss*(squeeze(cosp(m,:))*cos(phases)-squeeze(sinp(m,:))*sin(phases)) ...
                    + absp*(squeeze(cosp(m,:))*cos(phasep)-squeeze(sinp(m,:))*sin(phasep));
    end;
    C(2) = sum(outf.*outf);
    D(2) = sum((outf.*outf).^2); 
    if D(1)>D(2)
        map(num) = p1;
        maxint = D(1);
        intf(num) = C(1);
    else
        map(num) = p2;
        maxint = D(2);
        intf(num) = C(2);
    end;
    %num
    %maxint
    ints(num) = maxint;
end;
toc;
maxint

     