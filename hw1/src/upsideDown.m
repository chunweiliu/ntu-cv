function ud_b_img = upsideDown( b_img )
%UPSIDE-DOWN an input binary image
r = size(b_img, 1);
ud_b_img = b_img;
for n = 1:r
    ud_b_img(n, :) = b_img(r-n+1, :);
end
imwrite(ud_b_img, 'lena_upside_down.jpg');
