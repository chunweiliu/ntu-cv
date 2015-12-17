function enhance_stream()
%ENHANCE_STREAM enhance the local detail of a raw image
%   histogram equalization


path = '../dat/*.bmp';
raws = dir( path );

img_type = path( length(path) - 2 : length(path) );
img_path = path(1: length(path) - (length(img_type)+2)); % 2 = *.
         
for n = 1:length(raws)
    name  = raws(n).name;
    img   = imread( strcat(img_path, name) );
    
    % process image here ----
    out = equalimg( img );   
    out = uint8(out);
    % -----------------------
    out_path = sprintf( '../out/hist_%s', name );
    imhist(img);
    xlabel('intensity');
    ylabel('amount of pixels');
    title('histogram of original image');
    saveas( gcf, out_path );
    
    out_path = sprintf( '../out/hist_equal_%s', name );
    imhist(out);
    xlabel('intensity');
    ylabel('amount of pixels');
    title('histogram of equalized image');    
    saveas( gcf, out_path );
    
    out_path = sprintf( '../out/equal_%s', name );    
    imwrite( out, out_path );
end