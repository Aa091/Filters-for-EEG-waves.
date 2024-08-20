% Specify the path to CSV file
filename = '/Users/Aash/MATLAB-Drive/subject_09.csv';

% Read data from the CSV file
data = readmatrix(filename);

% Define the sampling rate 
Fs = 512; 

% Define the bandpass filter parameters
bandpass_freq = [0.5, 12]; 

% Design the bandpass filter
d = designfilt('bandpassiir', ...
    'FilterOrder', 4, ...
    'HalfPowerFrequency1', bandpass_freq(1), ...
    'HalfPowerFrequency2', bandpass_freq(2), ...
    'SampleRate', Fs);

% Extract the time vector and the column to be filtered
time = data(:, 1);
signal_to_filter = data(:, 6); % Column with values around 3929 (adjust the column index if needed)

% Apply zero-phase bandpass filter
filtered_signal = filtfilt(d, signal_to_filter);

% Calculate the removed artifacts
removed_artifacts = signal_to_filter - filtered_signal;

% Plot the original, filtered, and removed artifact signal
figure;
subplot(3, 1, 1);
plot(time, signal_to_filter);
title('Original Signal');
xlabel('Time (s)');
ylabel('Frequency');
hold on; 
plot(time, filtered_signal ,"r");

subplot(3, 1, 2);
plot(time, filtered_signal);
title('EOG signal');
xlabel('Time (s)');
ylabel('Frequency');

subplot(3, 1, 3);
plot(time, removed_artifacts);
title('EEG ARTIFACT');
xlabel('Time (s)');
ylabel('Amplitude');

