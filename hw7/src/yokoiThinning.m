function out = yokoiThinning( bw )
%YOKOITHINNING Doing the following operation
%   1. Computing yokoi #
%   2. Pair relationship computing
%   3. Connective shrinking
%   input:
%       bw      m x n       bool        input black and white pixel
%   output:
%       out     m x n       bool        output black and white pixel
    
    %yokoi_number = readYokoi;
    bw = im2bw( bw );
    bw = sample(bw);
    outname = sprintf('../out/lena_thin_0.png');
    imwrite( bw, outname );
    n = 1;
    while(1)        
        %yokoi_number = yokoi( bw );        
        %pair_number = pairRelation( yokoi_number );
        %out = connectedShrink( pair_number, bw );
        
        yokoi_number = yokoiKuei( bw );        
        pair_number = pairRelationKuei( yokoi_number );
        out = connectedShrinkKuei( pair_number, bw );        
        if( bw == out )
            break;
        end
        bw = out;
        outname = sprintf('../out/lena_thin_%d.png', n);
        imwrite( bw, outname );
        n = n + 1;
    end
    
end

function out = sample( bw )
    [row, col] = size( bw );
    out = zeros( row/8, col/8 );
    for n = 1:row/8
        for m = 1:col/8
            out(n,m) = bw(8*(n-1)+1, 8*(m-1)+1 );
        end
    end
end

function out = yokoiKuei( in )
    [row, col] = size( in );
    out = zeros( row, col );
    frame = zeros( row+2, col+2 );
    frame(2:end-1, 2:end-1) = in;
    %for m = 1:col
    %    for n = 1:row
    for n = 1:row
        for m = 1:col
            if( frame(n+1,m+1) == 0 )
                out(n, m) = 0;
            else
                               
                if( frame(n+1, m+2)==0 )
                    a1 = 's';
                elseif( (frame(n+1,m+2)==1) && (frame(n,m+2) == 1) && (frame(n,m+1) == 1 ))
                    a1 = 'r';
                else
                    a1 = 'q';
                end
                
                if( frame(n, m+1)==0 )
                    a2 = 's';
                elseif( frame(n,m+1)==1 && frame(n,m)==1 && frame(n+1,m)==1 )
                    a2 = 'r';
                else
                    a2 = 'q';
                end
                
                if( frame(n+1,m)==0 )
                    a3 = 's';
                elseif ( frame(n+1, m)==1 && frame(n+2, m) == 1 && frame(n+2, m+1) == 1 )
                    a3 = 'r';
                else
                    a3 = 'q';
                end
                
                if( frame(n+2,m+1) == 0 )
                    a4 = 's';
                elseif ( frame(n+2, m+1) == 1 && frame(n+2, m+2) == 1 && frame(n+1, m+2) == 1 )
                    a4 = 'r';
                else
                    a4 = 'q';
                end
                
                if( a1 == 'r' && a2 == 'r' && a3 == 'r' && a4 == 'r' )
                    out(n,m) = 5;
                else
                    out(n, m) = (a1=='q') + (a2=='q') + (a3=='q') + (a4=='q');
                end
            end
        end
    end   
    
end

function out = pairRelationKuei( in )
    [row, col] = size( in );
    out = zeros( row, col );
    
    for n = 1:row
        for m = 1:col
            if( in(n, m) == 0 )
                out(n, m) = 0;
            else
                if (in(n,m) ~= 1 )
                    out(n, m) = 1; %q
                elseif ( (m+1 <= col && in(n,m+1) == 1) || (m-1 >= 1 && in(n,m-1) == 1) || ...
                         (n+1 <= row && in(n+1,m) == 1) || (n-1 >= 1 && in(n-1,m) == 1) )
                    out(n, m) = 2; %p
                else
                    out(n, m) = 1;
                end
            end
        end
    end
end

function out = connectedShrinkKuei( in, bw )
    [row, col] = size( in );
    %out = bw;
    frame = zeros( row+2, col+2 );
    frame(2:end-1, 2:end-1) = bw;
    for n = 1:row
        for m = 1:col
            if( in(n, m) == 2 )
                sh = 0;
                if ( frame(n+1, m+2) == frame(n+1, m+1) && (frame(n,m+2)~=frame(n+1,m+1) || frame(n,m+1) ~= frame(n+1,m+1)) )
                    sh = sh + 1;
                end
                if ( frame(n, m+1) == frame(n+1, m+1) && (frame(n,m)~=frame(n+1,m+1) || frame(n+1,m) ~= frame(n+1,m+1)) )
                    sh = sh + 1;
                end
                if ( frame(n+1, m) == frame(n+1, m+1) && (frame(n+2,m)~=frame(n+1,m+1) || frame(n+2,m+1) ~= frame(n+1,m+1)) )
                    sh = sh + 1;
                end
                if ( frame(n+2, m+1) == frame(n+1, m+1) && (frame(n+2,m+2)~=frame(n+1,m+1) || frame(n+1,m+2) ~= frame(n+1,m+1)) )
                    sh = sh + 1;
                end
                if ( sh == 1 )
                    frame(n+1, m+1) = 0;
                end
            end
        end
    end
    out = frame(2:end-1,2:end-1);
end

function out = connectedShrink( in, bw )
    [row, col] = size( in );
    
    frame = zeros( row+2, col+2 );
    frame(2:end-1, 2:end-1) = bw;
    
    out = bw;    
    for n = 2:size(frame,1)-1
        for m = 2:size(frame,2)-1    
            if( in(n-1, m-1) == 2 )
                b = frame(n, m); c = frame(n, m+1); d = frame(n-1, m+1); e = frame(n-1, m);
                a1 = h( b, c, d, e );
                b = frame(n, m); c = frame(n-1, m); d = frame(n-1, m-1); e = frame(n, m-1);
                a2 = h( b, c, d, e );
                b = frame(n, m); c = frame(n, m-1); d = frame(n+1, m-1); e = frame(n+1, m);
                a3 = h( b, c, d, e );
                b = frame(n, m); c = frame(n+1, m); d = frame(n+1, m+1); e = frame(n, m+1);
                a4 = h( b, c, d, e );
                count = a1 + a2 + a3 + a4;
                if( count == 1  )                    
                    out(n-1, m-1) = 0; 
                end
            end
        end
    end
end

function out = pairRelation( yokoi_number )
%   output:
%           out         n x m       uint8       q == 1
%                                               p == 2
    [row, col] = size( yokoi_number );
    frame = zeros( row+2, col+2 );
    frame(2:end-1, 2:end-1) = yokoi_number;        
    
    out = zeros( row, col );
    for n = 2:row+1
        for m = 2:col+1
    %for n = 2:row-1
    %    for m = 2:col-1
            y = frame(n, m);
            %y = yokoi_number(n, m);
            if ( y == 0 )
                out(n-1, m-1) = 0;
                %out(n, m) = 0;
            else
                if ( y ~= 1 )
                    out(n-1, m-1) = 1;
                    %out(n, m) = 1;
                else
                    if ( frame(n-1, m) == 1 || frame(n+1, m) == 1 || ...
                         frame(n, m-1) == 1 || frame(n, m+1) == 1 )
                    %if( yokoi_number(n-1, m) == 1 || yokoi_number(n+1, m) == 1 ||...
                    %    yokoi_number(n, m-1) == 1 || yokoi_number(n, m+1) == 1 )
                        out(n-1, m-1) = 2;
                    %    out(n, m) = 2;
                    else
                        out(n-1, m-1) = 1;
                    %    out(n, m) = 1;
                    end
                end
            end
        end
    end
    
end


function a = h(b, c, d, e)
    a = ((b == c) && ( b ~= d || b ~= e ));    
end
