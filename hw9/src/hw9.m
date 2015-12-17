function hw9()
%HW9 Summary of this function goes here
%   Detailed explanation goes here

    im = imread('../dat/lena.bmp');
    [row, col] = size(im);
    im = double(im)./255;
    
    % Robert's operator: 12 
    out = zeros(row, col, 'double');
    for n = 1:row
        for m = 1:col
            if n < row && m < col
                r1 = im(n+1,m+1) - im(n,m);
                r2 = im(n+1,m) - im(n,m+1);
                out(n,m) = (r1^2+r2^2)^.5;
            end
        end
    end
    imwrite(out, '../out/robert_operator_12.png');
    
    % Prewitt's edge detector: 24    
    mask1 = [-1 -1 -1; 0 0 0; 1 1 1];
    mask2 = [-1 0 1; -1 0 1; -1 0 1];
    out = zeros(row, col, 'double');
    for n = 2:row-1
        for m = 2:col-1
            mask = im(n-1:n+1,m-1:m+1);
            p1 = sum(sum(mask.*mask1));
            p2 = sum(sum(mask.*mask2));
            out(n,m) = (p1^2+p2^2).^5;
        end
    end
    imwrite(out, '../out/prewitt_operator_24.png');
    
    % Sobel's edge detector: 38
    mask1 = [-1 -2 -1; 0 0 0; 1 2 1];
    mask2 = [-1 0 1; -2 0 2; -1 0 1];
    out = zeros(row, col, 'double');
    for n = 2:row-1
        for m = 2:col-1
            mask = im(n-1:n+1,m-1:m+1);
            p1 = sum(sum(mask.*mask1));
            p2 = sum(sum(mask.*mask2));
            out(n,m) = (p1^2+p2^2).^5;
        end
    end
    imwrite(out, '../out/sobel_operator_38.png');
    
    % Frei and Chen's edge detector: 30   
    mask1 = [-1 -2^0.5 -1; 0 0 0; 1 2^0.5 1];
    mask2 = [-1 0 1; -2.^0.5 0 2^0.5; -1 0 1];
    out = zeros(row, col, 'double');
    for n = 2:row-1
        for m = 2:col-1
            mask = im(n-1:n+1,m-1:m+1);
            p1 = sum(sum(mask.*mask1));
            p2 = sum(sum(mask.*mask2));
            out(n,m) = (p1^2+p2^2).^5;
        end
    end
    imwrite(out, '../out/frei_operator_30.png');
    
    % Kirsch's compass operator: 125
    mask_cell = {[-3 -3 5; -3 0 5; -3 -3 5],...
                 [-3 5 5; -3 0 5; -3 -3 -3],...
                 [5 5 5; -3 0 -3; -3 -3 -3],...
                 [5 5 -3; 5 0 -3; -3 -3 -3],...
                 [5 -3 -3; 5 0 -3; 5 -3 -3],...
                 [-3 -3 -3; 5 0 -3; 5 5 -3],...
                 [-3 -3 -3; -3 0 -3; 5 5 5],...
                 [-3 -3 -3; -3 0 5; -3 5 5]};
    out = zeros(row, col, 'double');
    for n = 2:row-1
        for m = 2:col-1
            mask = im(n-1:n+1,m-1:m+1);
            p = zeros(1,8);
            for k = 1:8
                mask1 = mask_cell{k};
                p(1,k) = sum(sum(mask*mask1));
            end
            if max(p) > 135
                out(n,m) = 0;
            else
                out(n,m) = 1;
            end
        end
    end
    imwrite(out, '../out/kirsh_operator_135.png');        
    
end

