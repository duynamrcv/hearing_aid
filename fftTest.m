Fs = 100;
T = 1/Fs;
t = 0:T:5;
x = cos(2*pi*30*t) + cos(2*pi*50*t) + cos(2*pi*2*t);
subplot(3,1,1);
plot(t,x);
title('Time Domain');
xlabel('Time (s)');
ylabel('x');


y = fft(x, 256);
f = linspace(0,Fs/2,256);
%f = f(1:256);
subplot(3,1,2);
plot(f,abs(y));
title('Frequency Domain');

y1 = zeros(length(f),1);
for i = 1:length(f)
    if f(i) > 5
        y1(i) = y(i);
    end;
end;

subplot(3,1,3);
plot(f, abs(y1));