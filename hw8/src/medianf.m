function out = medianf( img, k )
%MEDIANF apply median filter on input image img
%   input:  img     n x m   uchar   gray level image
%   output: out     n x m   uchar   gray level image

padded = padding_img( img, k );
[r, c] = size( img );
out = zeros(r, c);
for m = 1:c
    for n = 1:r
        block = padded(n:n+k-1, m:m+k-1);
        block = block(:);
        out(n, m) = median( block );
    end
end