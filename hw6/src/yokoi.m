%function out = yokoi( img )
function out = yokoi( bw )
%YOKOI Counting a yokoi number of given grey level image
%   input:
%           img         m x n       0 or 1      grey level image
%   output:
%           out         m x n       uchar       0~5 yokoi number

    %bw = im2bw( img );      % binarize the image
    [row, col] = size( bw );
    out = zeros( row, col );
    
    tmp = zeros( row+2, col+2 );
    [row, col] = size( tmp );
    tmp(2:row-1, 2:col-1) = bw;
    
    for n = 2:row-1
        for m = 2:col-1
            mask = tmp( n-1:n+1, m-1:m+1 );
            if ( mask(2, 2) == 0 ) 
                continue; 
            end
            b = mask(2, 2); c = mask(2, 3); d = mask(1, 3); e = mask(1, 2);
            a1 = h(b, c, d, e);
            b = mask(2, 2); c = mask(1, 2); d = mask(1, 1); e = mask(2, 1);
            a2 = h(b, c, d, e);
            b = mask(2, 2); c = mask(2, 1); d = mask(3, 1); e = mask(3, 2);
            a3 = h(b, c, d, e);
            b = mask(2, 2); c = mask(3, 2); d = mask(3, 3); e = mask(2, 3);
            a4 = h(b, c, d, e);
            y = f(a1, a2, a3, a4);
            out(n-1, m-1) = y;
        end
    end
    
    fid = fopen( '../out/out.yokoi', 'w' );
    [row, col] = size( out );
    for n = 1:row
        for m = 1:col
            if( out(n, m) == 0 )
                fprintf( fid, ' ' );
            else
                s = out( n, m );
                fprintf( fid, '%d', s );
            end
        end
        fprintf( fid, '\n' );
    end
    fclose( fid );
end

function a = h(b, c, d, e)
%H find a relationship between four elements in counter clock-wise
%   output:
%           a           1 x 1       uchar       q == 1
%                                               r == 2
%                                               s == 3
    t = ((d == b) & ( e == b ));
    if ( b == c )
        if ~t
            a = 1;
        else
            a = 2;
        end
    else
        a = 3;
    end
end

function y = f(a1, a2, a3, a4)
%F find the yokoi number
%   output:
%           y           1 x 1       uchar       0~5
    if ( (a1 == 2) && (a2 == 2) && (a3 == 2) && (a4 == 2) )
        y = 5;
    else      
        y = ((a1 == 1) + (a2 == 1) + (a3 == 1 ) + (a4 == 1));
    end
end