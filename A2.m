% Specify the path to CSV file
filename = '/Users/Aash/MATLAB-Drive/subject_09.csv';

% Read data from the CSV file
data = readmatrix(filename);

% Define the sampling rate (assuming it's 512 Hz for this example)
Fs = 512; % Adjust according to your actual sampling rate

% Define the low-pass filter parameters
low_cutoff = 50; % Upper cutoff frequency in Hz

% Design the low-pass filter
d = designfilt('lowpassiir', ...
    'FilterOrder', 4, ...
    'HalfPowerFrequency', low_cutoff, ...
    'SampleRate', Fs);

% Extract the time vector and the column to be filtered
time = data(:, 1);
signal_to_filter = data(:, 4); % Column 3929 

% Apply zero-phase low-pass filter
filtered_signal = filtfilt(d, signal_to_filter);

% Calculate the removed artifacts
removed_artifacts = signal_to_filter - filtered_signal;

% Plot the original and filtered signals
figure;
subplot(3, 1, 1);
plot(time, signal_to_filter);
title('Original Signal');
xlabel('Time (s)');
ylabel('Frequency');
hold on; 
plot(time, filtered_signal,"r");


subplot(3, 1, 3);
plot(time, filtered_signal);
title('EOG Artifact');
xlabel('Time (s)');
ylabel('Frequency');

% Plot the removed artifacts
subplot(3, 1, 2);
plot(time, removed_artifacts);
title('Filtered EEG Artifact');
xlabel('Time (s)');
ylabel('Frequency');

