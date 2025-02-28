%% PORT CONFIGURATION
clear
clc
close all

% List available serial ports
availablePorts = serialportlist;

% If no ports are available, display an error
if isempty(availablePorts)
    error('No serial ports available.');
end

% Display a dialog to select the serial port
[selectedPort, ok] = listdlg('PromptString', 'Select a serial port:', ...
                             'SelectionMode', 'single', ...
                             'ListString', availablePorts);

% If the user cancels the dialog, exit the script
if ~ok
    disp('User canceled port selection.');
    return;
end

% Get the selected port
serialPort = availablePorts{selectedPort};

% Specify the baud rate
baudRate = 115200;

% Create the serial object
s = serialport(serialPort, baudRate);

% Set the terminator (optional)
configureTerminator(s, "LF"); % or 'CR', 'CR/LF', etc. depending on your device

% Specify the timeout (in seconds)
timeout = 10;  % You can adjust this as needed
s.Timeout = timeout;

% Read data continuously
disp('Reading serial data...');
while true
    % Check if data is available
    if s.NumBytesAvailable > 0
        % Read the available data
        data = readline(s);  % Read a line of data as a string
        disp(data);  % Display the data
    end
    
    % Add a break condition (e.g., if you want to stop after some condition)
    % Uncomment the following lines to stop the loop after receiving a specific command
    % if contains(data, 'STOP') % Replace 'STOP' with your termination condition
    %     break;
    % end
end

% Close the serial port (this line won't be reached in the infinite loop above)
fclose(s);
delete(s);
clear s;