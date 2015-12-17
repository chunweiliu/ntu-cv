function hw4_sh()

img = imread( '../dat/lena.bmp' );

% binarize
out = im2bw( img );
imwrite( out, '../out/lena_binarized.png' );

% dilation
out1 = bin_dilation( img );
imwrite( out1, '../out/lena_dilation.png' );

% erosion
out2 = bin_erosion( img );
imwrite( out2, '../out/lena_erosion.png' );

% opening = erosion + dilation
out3 = bin_dilation( out2 );
imwrite( out3, '../out/lena_opening.png' );

% closing = dilation + erosion
out4 = bin_erosion( out1 );
imwrite( out4, '../out/lena_closing.png' );

end
