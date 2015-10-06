%map = zeros(1,137*4);
outf = zeros(1,375);
for m = 1:182
     %as = sum(squeeze(amps(:,m)) .* exp(j*map)');
     %ap = sum(squeeze(ampp(:,m)) .* exp(j*map)');
    as = sum(squeeze(amps(:,m)) .* exp(j*(map+randshift(m,:)))');
    ap = sum(squeeze(ampp(:,m)) .* exp(j*(map+randshift(m,:)))');
    sp(m) = ap;
    ss(m) = as;
    phases = phase(as);
    abss = abs(as) * wvfuns(m,y,x);
    phasep = phase(ap);
    absp = abs(ap) * wvfunp(m,y,x);
    outf = outf + (abss*(squeeze(cosp(m,:))*cos(phases)-squeeze(sinp(m,:))*sin(phases)) ...
                + absp*(squeeze(cosp(m,:))*cos(phasep)-squeeze(sinp(m,:))*sin(phasep)));
end;