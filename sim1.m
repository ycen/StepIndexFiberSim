Initialv5;
x = [10,20,30,40,50,60,70,80,90,100];
y = x;
[X,Y] = meshgrid(x,y);
inpuldurf = zeros(1,100);
inpuldurs = zeros(1,100);
fpuldurf = zeros(1,100);
fpuldurs = zeros(1,100);
abcints = zeros(1,100);
abcintf = zeros(1,100);

for inx=1:100
    map = zeros(1,137);
    outf = zeros(1,375);
    x = X(inx)
    y = Y(inx)
    if (sqrt((x-55)^2+(y-55)^2)<55.1)
       fout;
       outff = abs(hilbert(outf)).^2;
       outfs = abs(hilbert(outf)).^4;
       ind = find((outff)>(max(outff)/2));
       inpuldurf(inx) = max(ind)-min(ind);
       ind = find((outfs)>(max(outfs)/2));
       inpuldurs(inx) = max(ind)-min(ind);
    
       focus;
       focus;
    
       outf = zeros(1,375);
       fout;
       outff = abs(hilbert(outf)).^2;
       outfs = abs(hilbert(outf)).^4;
       ind = find((outff)>(max(outff)/2));
       fpuldurf(inx) = max(ind)-min(ind);
       ind = find((outfs)>(max(outfs)/2));
       fpuldurs(inx) = max(ind)-min(ind);
    
       abcints(inx) = sum(outf.^4);
       abcintf(inx) = sum(outf.^2);
    end;
    inx
end;

mkdir('result1');
dlmwrite('result1/Repeatinpuldurf.dat',inpuldurf);
dlmwrite('result1/Repeatinpuldurs.dat',inpuldurs);
dlmwrite('result1/Repeatfpuldurf.dat',fpuldurf);
dlmwrite('result1/Repeatfpuldurs.dat',fpuldurs);
dlmwrite('result1/Repeatints.dat',abcints);
dlmwrite('result1/Repeatintf.dat',abcintf);