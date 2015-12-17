function out = readYokoi()
%READYOKOI Summary of this function goes here

    fid = fopen( '../dat/yokoi.txt' );
    out = zeros( 64, 64 );
    for n = 1:64
        a = fgets(fid, 66);
        for m = 1:64                       
            out(n, m) = uint8(a(m))-48;            
        end
        %c = fgets(fid,1);
    end
    fclose(fid);


end

