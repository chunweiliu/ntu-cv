function hw8_noise_sh()
%HW8_SH 

I = imread( '../dat/lena.bmp' );
I = double( I );
[row, col] = size(I);

N = colorednoise( 'white', col );

ampletude = 10;
IN = I + ampletude*(2*N-1); %N(0.5,0.5) -> N(0,1)
IN = uint8(IN);
imwrite( IN, '../out/lena_gaussian10.png' );

ampletude = 30;
IN = I + ampletude*(2*N-1);
IN = uint8(IN);
imwrite( IN, '../out/lena_gaussian30.png' );

threshold = 0.05;
IN = I;
for n = 1:row
    for m = 1:col
        r = rand(1,1);
        if ( r < threshold )
            IN(n, m) = 0;
        elseif( r > (1-threshold) )
            IN(n, m) = 255;
        end
    end
end
IN = uint8(IN);
imwrite( IN, '../out/lena_bw005.png' );

threshold = 0.1;
IN = I;
for n = 1:row
    for m = 1:col
        r = rand(1,1);
        if ( r < threshold )
            IN(n, m) = 0;
        elseif( r > (1-threshold) )
            IN(n, m) = 255;
        end
    end
end
IN = uint8(IN);
imwrite( IN, '../out/lena_bw01.png' );

end

