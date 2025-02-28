% Asynchronous Serial Communication Script
% Author: Your Name
% Date: Today's Date

clear
clc
close all

%% Step 1: Create & Configure a Serial Port Object

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

configureTerminator(s, "CR/LF");  % Set the terminator to Carriage Return/Line Feed
set(s, 'Timeout', 10);  % Set timeout to 10 seconds

%% Step 2: Asynchronous Write
stringToSend = "Samuele"; % This is the only part you need to modify
write(s, stringToSend, "string");

%% Step 3: Cleanup (Optional)
% If you want to close the serial port and clear the object, uncomment the lines below
% clear s;
% disp('Serial port closed and object cleared.');