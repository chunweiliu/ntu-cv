function out = erosion( img )%, kernel )
%input: img	    n x m   uint8   :binary image
%	kernel	    a x b   uint8   :kernel of dilation
%output:out	    n x m   uint8   :dilated image

% binarize the input image, then apply dilation function
img = double(img);
kernel = [ 9 1 1 1 9;
	   1 1 1 1 1;
	   1 1 1 1 1;
	   1 1 1 1 1;
	   9 1 1 1 9];

r   = size(img, 1);
c   = size(img, 2);
a   = size(kernel, 1);
b   = size(kernel, 2);
a_2 = floor(a / 2);
b_2 = floor(b / 2);

out = zeros( r, c, 'uint8' );
out(:,1:2) = img(:,1:2);
out(1:2,:) = img(1:2,:);
out(end-1:end,:) = img(end-1:end,:);
out(:,end-1:end) = img(:,end-1:end);

for n = 1+a_2:r-a_2
    for m = 1+b_2:c-b_2
        mask = img(n-a_2:n+a_2, m-b_2:m+b_2) .* kernel;  
        out(n, m) = min(min(mask));
    end
end
out = uint8(out);
end
