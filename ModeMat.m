function [N, Modemat] = ModeMat(lambda)
	% N is number of modes for wavelength lambda, Modemat is N*4 matrix
	% Modemat(N,1)=l, (N,2)=m, (N,3)=b, (N,4)=beta
	% lambda in um
	NoMode = 1;
	N = 0;
	N1 = [];
	N2 = [];
	N3 = [];
	N4 = [];
	% mode number l
	lmode = 0;
	while NoMode ~= 0
	    [a, b] = Beta(lmode,lambda);
        %length(a)
        N = N + length(a);
        N1 = [N1, ones(1,length(a))*lmode];
        N2 = [N2, 1:length(a)];
        N3 = [N3, a];
        N4 = [N4, b];
        lmode = lmode + 1;
        NoMode = length(a);
    end;
    % generate modemat
    Modemat = zeros(4,N);
    Modemat(1,:) = N1;
    Modemat(2,:) = N2;
    Modemat(3,:) = N3;
    Modemat(4,:) = N4;
