function y = noiseReduction(x)
% noiseReduction reduce noise using wavelets
% x - the input Matlab sound file
% THR - the threshold
% SORH - for soft or hard thresholding
% KEEPAPP - allows you to keep 
[thr,sorh,keepapp] = ddencmp( 'den' , 'wv' ,x);  
[y, ~, ~, ~, ~] = wdencmp( 'gbl' ,x, 'db3' ,2,thr,sorh,keepapp); 
end

