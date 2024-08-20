% Step 1: Import the Data
eeg_data = readmatrix('/Users/Aash/MATLAB-Drive/subject_09.csv'); % Assuming the file is in the same directory as MATLAB script

% Step 2: Bandpass Filter the Data
fs = 1 / (eeg_data(2, 1) - eeg_data(1, 1)); % Sampling frequency (assuming uniform sampling)
fc_low = 0.5; % Low cutoff frequency for the bandpass filter (in Hz)
fc_high = 13; % High cutoff frequency for the bandpass filter (in Hz)
order = 4; % Order of the filter (you can adjust this as needed)
[b, a] = butter(order, [fc_low, fc_high] / (fs / 2), 'bandpass'); % Design the Butterworth bandpass filter
filtered_data = filtfilt(b, a, eeg_data(:, 2:end)); % Apply the filter to each column of the EEG data

% Step 3: Plot the Pre-Filtered Data
time = eeg_data(:, 1); % Time vector
figure;
subplot(3, 1, 1);
plot(time, eeg_data(:, 2:end));
xlabel('Time (s)');
ylabel('Original EEG Data');
title('Original EEG Data');
grid on;
legend('Channel 1', 'Channel 2', 'Channel 3', 'Channel 4', 'Channel 5', 'Channel 6', 'Channel 7', 'Channel 8', 'Channel 9', 'Channel 10', 'Channel 11', 'Channel 12', 'Channel 13', 'Channel 14', 'Channel 15', 'Channel 16', 'Channel 17');

% Step 4: Plot the Filtered Data
subplot(3, 1, 2);
plot(time, filtered_data);
xlabel('Time (s)');
ylabel('Filtered EEG Data');
title('Filtered EEG Data');
grid on;
legend('Channel 1', 'Channel 2', 'Channel 3', 'Channel 4', 'Channel 5', 'Channel 6', 'Channel 7', 'Channel 8', 'Channel 9', 'Channel 10', 'Channel 11', 'Channel 12', 'Channel 13', 'Channel 14', 'Channel 15', 'Channel 16', 'Channel 17');

% Step 5: Plot the Removed Artifact (Original - Filtered)
artifact_data = eeg_data(:, 2:end) - filtered_data;
subplot(3, 1, 3);
plot(time, artifact_data);
xlabel('Time (s)');
ylabel('Artifact EEG Data');
title('Artifact EEG Data (Original - Filtered)');
grid on;
legend('Channel 1', 'Channel 2', 'Channel 3', 'Channel 4', 'Channel 5', 'Channel 6', 'Channel 7', 'Channel 8', 'Channel 9', 'Channel 10', 'Channel 11', 'Channel 12', 'Channel 13', 'Channel 14', 'Channel 15', 'Channel 16', 'Channel 17');

disp('Bandpass filtering EEG data completed.');
