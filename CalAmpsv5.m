% Generate amplitudes    
    %tic;
    %matlabpool open 2;
    %numprocs = matlabpool('size');
    %toc;
    a = Allffts;
    a = a(:,65:174,65:174);
    %a = zeros(110,110);
    %a(45,45) = 1;
    %[N, Modemat] = ModeMat(Lambda);
    %Modemat = dlmread('modematrix/mm1.dat');
    %N = length(Modemat(1,:));
    mkdir('amplitudev5');
    for i = 267:267
        tic;
        filename = strcat('modematrix/mm',num2str(i),'.dat');
        Modemat = dlmread(filename);
        N = length(Modemat(1,:));
        Lambda = 1600000/(1503492+i);
        wvfuns = zeros(N,110,110);
        wvfunp = zeros(N,110,110);
        for k = 1:N
            wvfuns(k,:,:) = Modefun(Modemat(1,k),Modemat(2,k),Modemat(3,k),0,Lambda);
            wvfunp(k,:,:) = Modefun(Modemat(1,k),Modemat(2,k),Modemat(3,k),1,Lambda);
        end;
        amps = zeros(137,N);
        ampp = zeros(137,N);    
        for k = 1:137
            inf = squeeze(a(k,:,:));
            for l = 1:N
                amps(k,l) = sum(sum(inf.*squeeze(wvfuns(l,:,:))));
                ampp(k,l) = sum(sum(inf.*squeeze(wvfunp(l,:,:))));
            end;    
        end;    
        filename = strcat('amplitudev5/amps',num2str(i),'.dat');
        dlmwrite(filename,amps);
        filename = strcat('amplitudev5/ampp',num2str(i),'.dat');
        dlmwrite(filename,ampp);
        i
        toc;
    end;
    %matlabpool close;