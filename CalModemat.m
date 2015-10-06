mkdir('modematrix');
for i = 267:267
    lambda = 1600000/(1503492+i);
    [a,b] = ModeMat(lambda);
    name = num2str(i);
    name = strcat('modematrix/mm',name,'.dat');
    dlmwrite(name,b,'precision',16);
    i
end;