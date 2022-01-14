clear all;
close all;

% Генерируем сигнал
[ref, L, spec_pilot] = generateSig(50e6);
% Отправляем в генератор cxg
sendToCxg(getInstrID('cxg'), ref,50e6);
% Получаем данные с анализатора exa
a = getFromExa(getInstrID('exa'), 50e6);
% Демодулируем
demod(a, ref, L, spec_pilot);

%%  WG + OSCI

[~,~,~,~,sig] = generateSig(50e6);
sendToWg(getInstrID('wg'), sig, 20e6);
rx = getFromOsci(getInstrID('dsox'));

specRx = fft(rx);

figure;
subplot(2, 1, 1);
plot(rx);
subplot(2, 1, 2);
plot(abs(specRx(2:end)));