tmaps = zeros(110,110); %pulse duration shg
tmapf = zeros(110,110); %fundamental
pmap = zeros(110,110); %peak number
dmap = zeros(110,110); %delay time of max peak
mmap = zeros(110,110); %maximum

for x=1:110
    for y=1:110
        outf = zeros(1,375);
        fout;
        outff = abs(hilbert(outf)).^2;
        outfs = abs(hilbert(outf)).^4;
        [mmap(x,y),dmap(x,y)] = max(outff);
        ind = find((outff)>(max(outff)/2));
        tmapf(x,y) = max(ind)-min(ind);
        ppp=ind(2:length(ind))-ind(1:length(ind)-1);
        pmap(x,y) = length(find(ppp~=1))+1;
        %pmap(x,y) = tt(1,2);
        ind = find((outfs)>(max(outfs)/2));
        tmaps(x,y) = max(ind)-min(ind);
    end;
    fprintf('calculate maps:')
    x
end;