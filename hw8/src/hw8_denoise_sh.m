function hw8_denoise_sh()
%HW8_DENOISE_SH 

path = '../dat/';
type = '*.png';
dats = dir( [path type] );

SNR  = zeros( 6, 4 );
for n = 1:length(dats)
    name = dats(n).name;
    
    img = imread( [path  name] );        
    
    % low-pass
    out = lowpassf( img, 3 );
    out = uint8(out);
    outname = sprintf( '../out/%s_box3.png', name(1:end-4));
    imwrite( out, outname );
    SNR(1, n) = snr( img, out );
       
    out = lowpassf( img, 5 );
    out = uint8(out);
    outname = sprintf( '../out/%s_box5.png', name(1:end-4));
    imwrite( out, outname );
    SNR(2, n) = snr( img, out );        
    
    % median
    out = medianf( img, 3 );
    out = uint8(out);
    outname = sprintf( '../out/%s_med3.png', name(1:end-4));
    imwrite( out, outname );
    SNR(3, n) = snr( img, out );
    
    out = medianf( img, 5 );
    out = uint8(out);
    outname = sprintf( '../out/%s_med5.png', name(1:end-4));
    imwrite( out, outname );
    SNR(4, n) = snr( img, out );
    
    % closing
    out = dilation( img );
    out = erosion( out );
    outname = sprintf( '../out/%s_close.png', name(1:end-4));
    imwrite( out, outname );
    SNR(5, n) = snr( img, out );
    
    % opening
    out = erosion( img );
    out = dilation( out );
    outname = sprintf( '../out/%s_open.png', name(1:end-4));
    imwrite( out, outname );
    SNR(6, n) = snr( img, out );
        
end
save('../out/SNR.mat', 'SNR' );

end

