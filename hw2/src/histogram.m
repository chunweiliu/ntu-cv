function histogram( img )
%HISTOGRAM output the histogram of img
[r, c] = size( img );
bins = zeros( 256, 1 );
hist(bins);
for n = 1 : r*c
    bins( img(n), 1) = bins( img(n), 1 ) + 1;
end

plot( 0:255, bins );
xlabel( 'pixel value' );
ylabel( 'number of pixel' );
title( 'histogram of lena.bmp' );
saveas( gcf, 'lena_histogram.jpg' );