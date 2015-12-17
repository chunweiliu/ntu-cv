function mirror_b_img = mirror( b_img )
%MIRROR the binary input image
[r, c] = size(b_img);
mirror_b_img = b_img;
for n = 1:r*c
    mirror_b_img(n) = b_img(r*c-n+1);
end
imwrite(mirror_b_img, 'lena_mirror.jpg');
