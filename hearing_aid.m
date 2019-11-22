% Record voice input
disp('Start record voice:');
voiceInput = audiorecorder;
recordblocking(voiceInput, 5);
disp('End record.');

% Convert to double array
doubleArray = getaudiodata(voiceInput);
subplot(3,1,1);
plot(doubleArray);
title('Digital Input Signal');
xlabel('Time (ms)');
ylabel('Value');

% Fourier transform doubleArray
fftArray = fft(doubleArray);
subplot(3,1,2);
plot(fftArray);
title('');