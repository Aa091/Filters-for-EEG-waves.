% Import data from CSV file
data = readmatrix('/Users/Aash/MATLAB-Drive/subject_09.csv');


% Extract the first column as the time vector (assuming it's the first column)
time = data(:,1);

% Extract the data to be filtered (assuming it starts from the second column)
signal = data(:,2:end);

% Define the sampling frequency
fs = 1 / (time(2) - time(1)); % Assuming the time vector is evenly spaced

% Design the low-pass filter
    fc = 50; % Cutoff frequency (adjust as needed)
order = 4; % Filter order
[b, a] = butter(order, fc / (fs/2), 'low');

% Apply the filter to each column of the signal
filtered_signal = zeros(size(signal));
for i = 1:size(signal, 2)
    filtered_signal(:,i) = filtfilt(b, a, signal(:,i));
end
removed_artifacts=signal-filtered_signal;
% Plot original and filtered signals
figure;
subplot(3,1,1);
plot(time, signal);
title('Original Signals');
xlabel('Time');
ylabel('Frequency');

subplot(3,1,3);
plot(time, filtered_signal);
title('Filtered Signals');
xlabel('Time');
ylabel('frequency');

subplot(3, 1, 2);
plot(time, removed_artifacts);
title('EEG ARTIFACT');
xlabel('Time (s)');
ylabel('Frequency');
