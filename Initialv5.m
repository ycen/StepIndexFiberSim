%Initialization
x = -60000:0.2:15000;
ii = 1:375001;
tx = x/3e2;
ts = tx(find(mod(ii,1000)==0));
map = zeros(1,137);
modemat = dlmread('modematrix/mm267.dat');
amps = dlmread('amplitudev5/amps267.dat');
ampp = dlmread('amplitudev5/ampp267.dat');
randshift = dlmread('randshift.dat');
%randshift = zeros(182,137);
%amps = ones(137,182);
%ampp = ones(137,182);
cosp = zeros(182,375);
sinp = zeros(182,375);
for i = 1:182
	cosp(i,:) = dlmread(strcat('pixel/pcos',num2str(i),'.dat'));
	sinp(i,:) = dlmread(strcat('pixel/psin',num2str(i),'.dat'));
end;	
%addpath ..;
Lambda = 1600000/(1503492+267);
wvfuns = zeros(182,110,110);
wvfunp = zeros(182,110,110);
for i = 1:182
	wvfuns(i,:,:) = Modefun(modemat(1,i),modemat(2,i),modemat(3,i),0,Lambda);
	wvfunp(i,:,:) = Modefun(modemat(1,i),modemat(2,i),modemat(3,i),1,Lambda);
end;

%-------------------Spread mode-------------------------%
spramps = zeros(137,182);
sprampp = zeros(137,182);
beta = modemat(4,:);
[nouse,bind] = sort(beta);
% for i = 1:182
%     if find(bind == i)<6
%        si = 1; ei = 11;
%     elseif find(bind == i)>177
%        si = 172; ei = 182; 
%     else
%        si = find(bind == i) - 5;
%        ei = find(bind == i) + 5;   
%     end;
%     %spramps(:,i) = spramps(:,i) + (sqrt(10)/5.2273)*amps(:,i);
%     %sprampp(:,i) = sprampp(:,i) + (sqrt(10)/5.2273)*ampp(:,i);
%     %spramps(:,bind(si:ei)) = spramps(:,bind(si:ei)) + (1/5.2273)*(ones(11,1)*amps(:,i)')';
%     %sprampp(:,bind(si:ei)) = sprampp(:,bind(si:ei)) + (1/5.2273)*(ones(11,1)*ampp(:,i)')';
%     spramps(:,i) = spramps(:,i) + (sqrt(10))*amps(:,i);
%     sprampp(:,i) = sprampp(:,i) + (sqrt(10))*ampp(:,i);
%     spramps(:,bind(si:ei)) = spramps(:,bind(si:ei)) + (1)*(ones(11,1)*amps(:,i)')';
%     sprampp(:,bind(si:ei)) = sprampp(:,bind(si:ei)) + (1)*(ones(11,1)*ampp(:,i)')';
% end;
for i = 1:182
    if find(bind == i)<11
       si = 1; ei = 21;
    elseif find(bind == i)>172
       si = 162; ei = 182; 
    else
       si = find(bind == i) - 10;
       ei = find(bind == i) + 10;   
    end;
    %spramps(:,i) = spramps(:,i) + (sqrt(10)/5.2273)*amps(:,i);
    %sprampp(:,i) = sprampp(:,i) + (sqrt(10)/5.2273)*ampp(:,i);
    %spramps(:,bind(si:ei)) = spramps(:,bind(si:ei)) + (1/5.2273)*(ones(11,1)*amps(:,i)')';
    %sprampp(:,bind(si:ei)) = sprampp(:,bind(si:ei)) + (1/5.2273)*(ones(11,1)*ampp(:,i)')';
    spramps(:,i) = spramps(:,i) + (sqrt(15))*amps(:,i);
    sprampp(:,i) = sprampp(:,i) + (sqrt(15))*ampp(:,i);
    spramps(:,bind(si:ei)) = spramps(:,bind(si:ei)) + (1)*(ones(21,1)*amps(:,i)')';
    sprampp(:,bind(si:ei)) = sprampp(:,bind(si:ei)) + (1)*(ones(21,1)*ampp(:,i)')';
end;
amps = spramps;
ampp = sprampp;

%-------------------Rotate wave function-----------------------%
angle = dlmread('flatrotshg/angle.dat');
for i = 1:182
	a1 = imrotate(squeeze(wvfuns(i,:,:)),angle(1,i));
    a2 = imrotate(squeeze(wvfunp(i,:,:)),angle(2,i));
    l1 = size(a1);
    l2 = size(a2);
    if mod(l1(1),2)==0
        n1 = (l1(1)-110)/2+1;
        n2 = n1 + 110 - 1;
        b1 = a1(n1:n2,n1:n2);
    else
        n1 = (l1(1)-110-1)/2+1;
        n2 = n1 + +110 -1;
        b1 = a1(n1:n2,n1:n2);
    end;
    if mod(l2(1),2)==0
        n1 = (l2(1)-110)/2+1;
        n2 = n1 + 110 - 1;
        b2 = a2(n1:n2,n1:n2);
    else
        n1 = (l2(1)-110-1)/2+1;
        n2 = n1 + +110 -1;
        b2 = a2(n1:n2,n1:n2);
    end;
    wvfuns(i,:,:) = b1;
    wvfunp(i,:,:) = b2;
end;
