filename = '/Users/Aash/MATLAB-Drive/subject_09.csv';

% Read data from the CSV file
data = readmatrix(filename);

% Define the sampling rate 
Fs = 512; 
t= data(:,1);

% Extract the data to be filtered (assuming it starts from the second column)
signal = data(:,2:end);


% Design the notch filter
 d = designfilt('bandstopiir', ...
               'FilterOrder',2, ...
               'HalfPowerFrequency1',0.5, ...
               'HalfPowerFrequency2',12, ...
               'DesignMethod', ...
               'butter', ...
               'SampleRate',Fs);
 
buttLoop = filtfilt(d,data);

figure;
subplot(2,1,1);
plot(t, signal);
title('Original Signals');
xlabel('Time');
ylabel('Frequency');

subplot(2,1,2);
plot(t, buttLoop);
title('Filtered Signals');
xlabel('Time');
ylabel('frequency');
