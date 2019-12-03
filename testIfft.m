Fs = 100;
T = 1/Fs;
t = 0:T:5;
x = cos(2*pi*30*t) + cos(2*pi*50*t) + cos(2*pi*2*t);
subplot(3,1,1);
plot(t,x);
title('Time Domain');
xlabel('Time (s)');
ylabel('x');

x_len = length(x);
n = nextpow2(x_len);
N = 2^n;
y = fft(x, N);
f = linspace(0,Fs/2,N);
%f = f(1:256);
subplot(3,1,2);
plot(f,abs(y));
title('Frequency Domain');

ifftArray = ifft(y, N);
ifftArray = ifftArray(1:x_len);
subplot(3,1,3);
plot(t,ifftArray);