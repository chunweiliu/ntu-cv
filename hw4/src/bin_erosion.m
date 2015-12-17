function out = bin_erosion( img )%, kernel )
%input: img	    n x m   uint8   :binary image
%	kernel	    a x b   uint8   :kernel of dilation
%output:out	    n x m   uint8   :dilated image

% binarize the input image, then apply dilation function
img = im2bw( img, 128/256 );

kernel = [ 0 1 1 1 0;
	   1 1 1 1 1;
	   1 1 1 1 1;
	   1 1 1 1 1;
	   0 1 1 1 0];

r   = size(img, 1);
c   = size(img, 2);
a   = size(kernel, 1);
b   = size(kernel, 2);
a_2 = floor(a / 2);
b_2 = floor(b / 2);

out = zeros( r, c );
for n = 1+a_2:r-a_2
    for m = 1+b_2:c-b_2
	mask = img(n-a_2:n+a_2, m-b_2:m+b_2);
	if( sum(sum( mask == kernel ) ) >= 21);
	    out( n, m ) = 255;
	end
    end
end
out = im2bw( out, 1/256 );
out = out.*255;
out = uint8( out );
end
