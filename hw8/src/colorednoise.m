function out = colorednoise(type, imSize)
%COLOREDNOISE generate colored noises
%   input:
%           type    1 x c   uchar   'red', 'white', 'blue'
%   output:
%           out

%imSize = 256;

white = randn(imSize,imSize);
White = fft2c(white);

x = ones(imSize,1)*(1:imSize);
y = x';
dist = sqrt((x-(imSize/2+1)).^2 + (y-(imSize/2+1)).^2); % distance from center of image

sqrtRamp = sqrt(dist/max(dist(:))); % normalized 1/sqrt(rho) filter
redFilt = sqrt(1-dist/max(dist(:)));

B = White.*sqrtRamp;
b = ifft2c(B);

blue = b*sqrt(mean(white(:).^2)/mean(b(:).^2)); % scale blue noise to same MSE as white
Blue = fft2c(blue);

R = White.*redFilt;
r = ifft2c(R);

red = r*sqrt(mean(white(:).^2)/mean(r(:).^2)); % scale red noise to same MSE as white
Red = fft2c(red);

Max = max(max([white red blue]));
Min = min(min([white red blue]));

if strcmp(type, 'white')    
    out = (white-Min)/(Max-Min);    
elseif strcmp(type, 'red')    
    out = (red-Min)/(Max-Min);
elseif strcmp(type, 'blue')    
    out = (blue-Min)/(Max-Min);
end
    
end

