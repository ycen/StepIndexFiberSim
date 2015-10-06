function Allffts = Allffts
	% Generate all fft matrix accordingly to each segment on DM
	% #138 is for the rest part of DM #139 DM part #140 Gauss
	% each matrix is 600*600 corresponding to 45mm*45mm
	MSize = 200;
	% grid before lens
    %[X,Y] = meshgrid(linspace(-22.5,22.5,MSize));
    % grid after lens
    f = 15000; % focal length 1.5cm
    Lambda = 1.064; % wavelength
    L = 15000; % side length
    %Lfft = Lambda * f / L * MSize; % side length after lens in um
    %[X,Y] = meshgrid(linspace(-Lfft/2,Lfft/2,MSize));
    [X,Y] = meshgrid(linspace(-L/2,L/2,MSize));
	% Gaussian beam width is 3mm
	w = 3000;
	Gauss = exp(- ((X-0).^2 + (Y-0).^2) / w^2);
	Gauss = Gauss / sqrt(sum(sum(Gauss.*Gauss)));
	% rest mask
	rest = ones(MSize,MSize);
	% DM mask
	DM = zeros(MSize,MSize);
	% Generate
	Allffts = zeros(140,MSize,MSize);
	for i = 1:137
		m = Mask(i);
		rest = rest - m;
		DM = DM + m;
		m = Gauss.*m;
        Allffts(i,:,:) = fftshift(fft2(ifftshift(m)));
    end;	
    Allffts(138,:,:) = fftshift(fft2(ifftshift(rest.*Gauss)));
    Allffts(139,:,:) = fftshift(fft2(ifftshift(DM.*Gauss)));
    %Allffts(140,:,:) = fftshift(fft2(ifftshift(Gauss)));
    Allffts(140,:,:) = Gauss;
%-------------test--------------
    % %imagesc(Gauss);
    % %axis image;
    % for i = 1:140
	   %  imagesc(abs(squeeze(Allffts(i,65:174,65:174))));
	   %  axis image;
	   %  pause(0.1);
    % end;
        

