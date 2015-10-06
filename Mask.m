function d = Mask (SegNum)
    % Give mask for Segment #Num
    % Number of segments
    Num = 137;
    % Postion of each segment
    DMx = [ 2  1  0 -1 -2  4  3  2  1  0 -1 -2 -3 -4 ...
            5  4  3  2  1  0 -1 -2 -3 -4 -5  5  4  3 ...
            2  1  0 -1 -2 -3 -4 -5  6  5  4  3  2  1 ...
            0 -1 -2 -3 -4 -5 -6  6  5  4  3  2  1  0 ...
           -1 -2 -3 -4 -5 -6  6  5  4  3  2  1  0 -1 ...
           -2 -3 -4 -5 -6  6  5  4  3  2  1  0 -1 -2 ...
           -3 -4 -5 -6  6  5  4  3  2  1  0 -1 -2 -3 ...
           -4 -5 -6  5  4  3  2  1  0 -1 -2 -3 -4 -5 ...
            5  4  3  2  1  0 -1 -2 -3 -4 -5  4  3  2 ...
            1  0 -1 -2 -3 -4  2  1  0 -1 -2];
    DMy = [-6 -6 -6 -6 -6 -5 -5 -5 -5 -5 -5 -5 -5 -5 ...
           -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -3 -3 -3 ...
           -3 -3 -3 -3 -3 -3 -3 -3 -2 -2 -2 -2 -2 -2 ...
           -2 -2 -2 -2 -2 -2 -2 -1 -1 -1 -1 -1 -1 -1 ...
           -1 -1 -1 -1 -1 -1  0  0  0  0  0  0  0  0 ...
            0  0  0  0  0  1  1  1  1  1  1  1  1  1 ...
            1  1  1  1  2  2  2  2  2  2  2  2  2  2 ...
            2  2  2  3  3  3  3  3  3  3  3  3  3  3 ...
            4  4  4  4  4  4  4  4  4  4  4  5  5  5 ...
            5  5  5  5  5  5  6  6  6  6  6];
    % Simulation size
    SegSize = 4; % 20 pixels for each segment
    DMSize = 200; % L = 600 pixels
    % Generate maske
    a = DMSize / 2; % Number of pixels
    d = zeros( DMSize , DMSize );
    dview = zeros( 14 , 14 );
    %for i = 1:Num
    i = SegNum;
    %i = ((SegNum-1)-mod(SegNum-1,4))/4+1;
        x1 = DMx(i) * SegSize - (SegSize / 2) + 1;
        x2 = DMx(i) * SegSize + (SegSize / 2);
        y1 = DMy(i) * SegSize - (SegSize / 2) + 1;
        y2 = DMy(i) * SegSize + (SegSize / 2);
        yy1 = a + x1;
        yy2 = a + x2;
        xx1 = a + y1;
        xx2 = a + y2;
        d(xx1:xx2,yy1:yy2) = 1;
        % if mod(SegNum, 4)==0
        %     d(xx1:xx1+1,yy1:yy1+1) = 1;
        % end;
        % if mod(SegNum, 4)==1
        %     d(xx2-1:xx2,yy1:yy1+1) = 1;
        % end;
        % if mod(SegNum, 4)==2
        %     d(xx1:xx1+1,yy2-1:yy2) = 1;
        % end;
        % if mod(SegNum, 4)==3
        %     d(xx2-1:xx2,yy2-1:yy2) = 1;
        % end;
        %dview(DMy(i)+7,DMx(i)+7) = i;
    %end;	
%-------------test--------------
    %pcolor(dview); colorbar;
    %imagesc(d); axis image; colorbar;