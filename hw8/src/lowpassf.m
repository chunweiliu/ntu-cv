function out = lowpassf( img, k )
%LOWPASSF apply low-pass filter (average) on input image
%   input:  img     n x m   uchar   grey level input image
%   output: out     n x m   uchar   grey level average mage

padded = padding_img( img, k );
[r, c] = size( img );
out = zeros(r, c);
for m = 1:c
    for n = 1:r
        block = padded(n:n+k-1, m:m+k-1);
        block = block(:);
        out(n, m) = mean( block );
    end
end