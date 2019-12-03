[timeArray, Fs] = audioread('input.wav');
info = audioinfo('input.wav');
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);
vol= db2mag(10);
y=vol*timeArray;
z= zeros(1,length(t));
for i = 1:length(t)
    z(1,i) = mag2db(timeArray(i));
end;
%y = powerCompression(timeArray, 100, Fs);
subplot(311);
plot(t, timeArray);
subplot(312);
plot(t, y);
%sound(timeArray, Fs);
sound(y, Fs);
subplot(313);
plot(t, z);