function out = snr( I, N )
%SNR Signal Noise Ratio 
%   input:
%       I           n x m       uint8       gray level input image
%       N           n x m       uint8       gray level noise image
%   output:
%       out         1 x 1       double      snr of input and noise image

I       = double(I);
N       = double(N);
meanI   = mean( I(:) );
meanN   = mean( N(:)-I(:) );
out     = 20*log10((sum( sum((I - meanI).^2) ) ./ sum( sum((N-meanN-I).^2) )).^0.5);
%out = 10*log10(sum(I(:).^2) ./ sum(N(:).^2));
end

