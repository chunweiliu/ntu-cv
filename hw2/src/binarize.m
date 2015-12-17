function o_img = binarize( img )
%BINARIZE thesholding gray input image
o_img = img;
[r, c] = size(o_img);
for n = 1 : r*c
    if(o_img(n) > 128)
        o_img(n) = 255;
    else
        o_img(n) = 0;
    end
end
imwrite(o_img, 'lena_binarize.jpg');
