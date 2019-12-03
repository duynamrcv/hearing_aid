[timeArray, Fs] = audioread('input.wav');
info = audioinfo('input.wav');
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);
newArray = zeros(length(t),1);
for i = 1:length(t)
    if timeArray(i) < 0.2
        newArray(i) = 4*timeArray(i);
    else
        if timeArray < 0.4
            newArray(i) = 2 * timeArray(i);
        else
            newArray(i) = timeArray(i);
        end;
    end;
end;
%disp('Raw');
%sound(timeArray, Fs);
disp('New');
sound(newArray, Fs);