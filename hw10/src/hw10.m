function hw10()
%HW10 
    im = imread('../../hw9/dat/lena.bmp');
    
    
    % Laplacian
%     kernel = [0  1  0;
%               1 -4  1;
%               0  1  0];
%     t = 25;
%     out = zc( kernel, t, im );    
%     imwrite(out, 'laplacian_25.png');
%     
%     % min-variance laplacian
%     kernel = [ 2 -1  2;
%               -1 -4 -1;
%                2 -1  2].*(1/3);
%     t = 15;
%     out = zc( kernel, t, im );
%     imwrite(out, 'min_laplacian_15.png');
%     
%     % laplacian of gaussian
%     kernel = [0,0,0,-1,-1,-2,-1,-1,0,0,0;
% 					   0,0,-2,-4,-8,-9,-8,-4,-2,0,0;
% 					   0,-2,-7,-15,-22,-23,-22,-15,-7,-2,0;
% 					   -1,-4,-15,-24,-14,-1,-14,-24,-15,-4,-1;
% 					   -1,-8,-22,-14,52,103,52,-14,-22,-8,-1;
% 					   -2,-9,-23,-1,103,178,103,-1,-23,-9,-2;
% 					   -1,-8,-22,-14,52,103,52,-14,-22,-8,-1;
% 					   -1,-4,-15,-24,-14,-1,-14,-24,-15,-4,-1;
% 					   0,-2,-7,-15,-22,-23,-22,-15,-7,-2,0;
% 					   0,0,-2,-4,-8,-9,-8,-4,-2,0,0;
% 					   0,0,0,-1,-1,-2,-1,-1,0,0,0];
%     t = 2800;
%     out = zc( kernel, t, im );
%     imwrite(out, 'laplacian_gaussian_2800.png');
    
    % difference of gaussian
    kernel = zeros(11,11);
    for n = 1:11
        for m = 1:11
            a = exp( -((n-5)^2+(m-5)^2)/(2*(1^2)) ) / ((2*pi*(1^2)) ^0.5);
            b = exp( -((n-5)^2+(m-5)^2)/(2*(3^2)) ) / ((2*pi*(3^2)) ^0.5);
            kernel(n,m) = a-b;            
        end
    end
    %kernel = kernel / max(max(kernel));    
    t = 0;
    out = zc(kernel, t, im);    
    imwrite(out, 'difference_gaussian_0.png');
end

function out = zc (kernel, t, im)
    im = double(im);
    [row, col] = size(im);
    [kr, kc] = size(kernel);
    kr = (kr-1)/2;
    kc = (kc-1)/2;
    tmp = zeros(row, col);
    for n = 1+kr:row-kr
        for m = 1+kc:col-kc
            mask = im(n-kr:n+kr, m-kc:m+kc);
            s = sum(sum(mask .* kernel));
            tmp(n,m) = s;
        end
    end    
    
    out = zeros(row,col,'uint8');
    for n = 2:row-1
        for m = 2:col-1 
            if(tmp(n,m)>t)
                p = -1;                

                for a = -1:1
                    for b = -1:1
                        if(tmp(n+a,m+b)<=-t)
                            p = 1;
                        end
                    end
                end
                if(p) 
                    out(n,m) = 0;
                else
                    out(n,m) = 255;
                end
                
            elseif tmp(n,m)<-t
                p = -1;
                
                for a = -1:1
                    for b = -1:1
                        if(tmp(n+a,m+b)>=t)
                            p = 1;
                        end
                    end
                end
                if(p) 
                    out(n,m) = 0;
                else
                    out(n,m) = 255;
                end
            else
                out(n,m) = 255;
            end
            
        end
    end    
end


