tic;
%map = zeros(1,137);
out1 = zeros(110,110);
out2 = zeros(110,110);
%randshift = zeros(182,137);
sp = zeros(1,182);
ss = zeros(1,182);
for x = 1:110
    for y = 1:110
        outf = zeros(1,375);
        for m = 1:182
            as = sum(squeeze(amps(:,m)) .* exp(1i*(map+randshift(m,:)))');
            ap = sum(squeeze(ampp(:,m)) .* exp(1i*(map+randshift(m,:)))');
            sp(m) = ap;
            ss(m) = as;
            phases = phase(as);
            abss = abs(as) * wvfuns(m,y,x);
            phasep = phase(ap);
            absp = abs(ap) * wvfunp(m,y,x);
            outf = outf + (abss*(squeeze(cosp(m,:))*cos(phases)-squeeze(sinp(m,:))*sin(phases)) ...
                        + absp*(squeeze(cosp(m,:))*cos(phasep)-squeeze(sinp(m,:))*sin(phasep)));
        end;
        %plot(outf.*outf);
        out1(y,x) = sum(outf.*outf);
        out2(y,x) = sum((outf.*outf).^2);
    end;
    fprintf('calculate initial image: ');
    x
end;        
toc;
%dlmwrite('output/out1.dat',out1);
%dlmwrite('output/out2.dat',out2);