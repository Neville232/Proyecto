%% Inicializar

clc
clear all
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
close all
clc

%% Abrir puerto serial
global puerto;

data = serial(puerto);
set(data, 'DataBits', 8);
set(data, 'StopBits', 1);
set(data, 'BaudRate', 9600);
set(data, 'Parity', 'none');
fopen(data);
