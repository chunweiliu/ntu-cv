function out = equalimg( img )
%EQUALIMG histogram equalization by transfer function
%   input:  n x m   uchar   gray level image
%   output: n x m   uchar   gray level image

y = img(:);
[f, x] = ecdf( y );

L = 256;        % # of grey level use
%MIN_X = min(x); % for indexing the right place of the pixel
out = y;
for m = 1:length(y)
    ind = find( x == y(m) );
    out(m) = f(ind(1)) * (L-1);
    %out(m) = f(y(m)-MIN_X+1) * (L-1);   % heuristic of indexing
end
out = uint8(out);
out = reshape(out, size(img,1), size(img,2) );