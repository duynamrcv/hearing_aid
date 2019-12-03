[timeArray, Fs] = audioread('input.wav');
info = audioinfo('input.wav');
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);

timeArray = awgn(timeArray,30);
%sound(timeArray, Fs);

denoiseArray = noiseReduction(timeArray);
sound(denoiseArray, Fs);
subplot(311);
plot(t, timeArray);
subplot(312);
plot(t, denoiseArray);
subplot(313);
plot(t, denoiseArray-timeArray);