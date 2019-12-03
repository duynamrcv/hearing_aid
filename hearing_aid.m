% Read a wav input file
[timeArray, Fs] = audioread('input.wav');
%sound(timeArray, Fs);
info = audioinfo('input.wav'); %get infomation about input file

% Create vector t has same length with y
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);

% Plot audio file
subplot(3,2,1);
plot(t, timeArray);
title('Input Voice (Time Domain)');
xlabel('Time (s)');

% Frequency shaping filter
len = length(t);
n = nextpow2(len);
N = 2^n;
fftArray = fft(timeArray, N);
f = linspace(0, Fs/2, N);
subplot(3,2,2);
plot(f, abs(fftArray));
title('Input Voice (Frequency Domain)');
xlabel('Frequency (Hz)');
ylim([-10 200]);

% Remove frequency < 250 and > 4000
renoiseArray = zeros(length(f),1);
for i = 1:length(f)
    if f(i) <= 4000 && f(i) >= 250
        renoiseArray(i) = fftArray(i);
    end;
end;
subplot(3,2,4);
plot(f, abs(renoiseArray));
title('Voice after filter (Frequency Domain)');
xlabel('Frequency (Hz)');
ylim([-5 50]);

% Convert frequency to small range that hearing impaired can hear
% about 1000-2000Hz
newF = zeros(length(f),1);
for i = 1:length(f)
    newF(i) = f(i)*(2000-1000)/(4000-250)+1000;
end;
subplot(3,2,6);
plot(newF, abs(renoiseArray));
title('New signal(Frequency Domain)');
xlabel('Frequency (Hz)');
ylim([-5 50]);

% Inverse fourier transform
ifftArray = real(ifft(renoiseArray, N));
ifftArray = ifftArray(1:len);
subplot(3,2,3);
plot(t,ifftArray);
title('Voice after filter (Time Domain)');
xlabel('Time (s)');
%sound(ifftArray, Fs);

% Amplify signal
final = zeros(len,1);
for i = 1:length(t)
    if abs(ifftArray(i)) < 0.005
        final(i) = 0*ifftArray(i);
    elseif abs(ifftArray(i)) < 0.05
        final(i) = 3.5 * ifftArray(i);
    elseif abs(ifftArray(i)) < 0.1
        final(i) = 2.5 * ifftArray(i);
    elseif abs(ifftArray(i)) < 0.15
        final(i) = 1.5 * ifftArray(i);
    else
        final(i) = ifftArray(i);
    end;
end;

% Increase signal 10db
vol= db2mag(10);
final=vol*final;

subplot(3,2,5);
plot(t, final);
title('Output voice');
xlabel('Time (s)');
%sound(final, Fs);
output = 'output.wav';
audiowrite(output, final, Fs);