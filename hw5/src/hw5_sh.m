function hw5_sh()

img = imread( '../dat/lena.bmp' );
% dilation
out1 = dilation( img );
imwrite( out1, '../out/lena_dilation.png' );

% erosion
out2 = erosion( img );
imwrite( out2, '../out/lena_erosion.png' );

% opening = erosion + dilation
out3 = dilation( out2 );
imwrite( out3, '../out/lena_opening.png' );

% closing = dilation + erosion
out4 = erosion( out1 );
imwrite( out4, '../out/lena_closing.png' );

end
