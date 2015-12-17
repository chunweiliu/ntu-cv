function img_rgb = connected_component( img )
%CONNECTED_COMPONENT labeling the different label on binary image input
img_bw = im2bw( img );
img_label = bwlabel( img_bw );

for label = 1:max( max( img_label ) )
    [r, c] = find( img_label == label );
    if( length(r) < 500 )
        for n = 1:length(r)
            img_label(r(n), c(n)) = 0;
        end
    end
end

img_rgb = label2rgb( img_label );
imwrite( img_rgb, 'lena_cc.png' );