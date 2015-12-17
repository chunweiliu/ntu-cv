function rl_b_img = rightsideLeft( b_img )
%RIGHTSIDE-LEFT an input binary image
c = size(b_img, 2);
rl_b_img = b_img;
for n = 1:c
    rl_b_img(:, n) = b_img(:, c-n+1);
end
imwrite(rl_b_img, 'lena_rightside_left.jpg');