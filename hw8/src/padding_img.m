function out = padding_img( img, k )
%PADDING_IMG padding image for filter
%   input:  img     n x m   uchar   input grey level image
%   output: out   n+2 x m+2 uchar   output grey level padded image

[r, c] = size( img );
out = zeros( r+(k-1), c+(k-1) );
w = (k-1)/2;
out( 1+w:r+w, 1+w:c+w ) = img;
