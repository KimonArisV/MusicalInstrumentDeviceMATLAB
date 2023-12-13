clear
clc
format long
format compact

% Kimon Vogt & Drew P.
% B.Telephone (Phone numbers)
% Table where for every index the sum of f1, f2
% gives the unique digit frequency 0123456789
% Signal Processing Toolbox needs to be installed
%% B.1
f1 = [941 697 697 697 770 770 770 852 852 852];
f2 = [1336 1209 1336 1477 1209 1336 1477 1209 1336 1477];
phone = [1 4 7 2 5 8 0 3 6 9];
fs = 8000;
delay = delay_function(fs, 0.05);
dur = 0.7;
y1 = [];

for i = 1:length(phone)
    ndx = phone(i) + 1;
    tone1 = single_note_gen(f1(ndx), fs, dur);
    tone2 = single_note_gen(f2(ndx), fs, dur);
    y1 = [y1 (tone1 + tone2) delay];
end

listen = false;

if listen
    plot(y1)
    sound(y1, fs);
    sound(y1, 0.5 * fs);
    sound(y1, 2 * fs);
    % Prevent the notes from different sections from playing
    % all together
end

%% C.1
% Music Scales
fc = 16.35;
a = nthroot(2, 12);
ym = [];
dur = 0.2;

for i = 0:8
    for j = 0:11
        fn = fc * a^(12 * i + j);
        tone = single_note_gen(fn, fs, dur);
        ym = [ym tone delay];
    end
end

listen1 = false;

if listen1
    sound(ym, fs);
    figure
    plot(ym)
end

%% D.1
% Playing notes
freq_notes = [587.3 659.3 523.3 261.6 392.0];
y3 = [];

for i = 1:length(freq_notes)
    tone1 = single_note_gen(freq_notes(i), fs, dur);
    y3 = [y3 tone1 delay];
end

listen2 = false;

if listen2
    sound(y3, fs);
    figure;
    plot(y3);
end


%% D.2 
% Play the letters
song = [329.6 329.6 277.2 261.6 329.6 392.0 370.0 261.6 ... 
        392.0 329.6 ...
        440.0 466.2 392.0 329.6 392.0 440.0 349.2 392.0 ... 
        329.6 261.6];
y4 = [];
for i = 1:length(song)
    tone2 = single_note_gen(song(i), fs, dur);
    y4 = [y4 tone2 delay];
end

listen3 = false;
if listen3
    sound(y4, fs);
    keyboard;
    figure
    plot(y4)
end

%% D.3 
% Remove every other sample
y5 = [];
y5 = decimate(double(y4), 2);

listen4 = false;
if listen4
    sound(y5, fs);
    %keyboard;
    figure
    plot(y5)
end

%% D.4 
song2 = fliplr(y5);

listen5 = false;
if listen5
    sound(song2, fs);
    %keyboard;
    figure
    plot(song2)
end

%% D.5
% % ADSR
amplitude = [1, 0.7, 0.7, 0];
dur_amp = [170, 150, 150, 130];
tot_dur = sum(dur_amp) / 1000;
y7 = [];
for i = 1:length(song)
    a = adsr_classic_gen(fs, amplitude, dur_amp)';
    sig = single_note_gen(song(i), fs, tot_dur);
    y7 = [y7 a .* sig delay];
end

listen6 = false;
if listen6
    sound(y7, fs);
    keyboard;
    figure
    subplot(2, 2, 1)
    plot(a)
    hold on
    subplot(2, 2, 2)
    plot(sig)
    subplot(2, 2, 3)
    plot(y7)
    hold off
end

%% E.1 
% Playing Song: Twinkle Twinkle (the one from Mozart on the project/paper)
twinkle = [261.6 261.6 392 392 440 440 392 392 349.2 ...
    349.2 329.6 329.6 293.7 293.7 329.6 261.6 392 392 349.2 349.2 ...
    329.2 329.2 293.7 293.7 392.0 392.0 349.2 349.2 329.6 329.6 ...
    293.7 329.6 349.2 329.6 293.7 ...
    261.6 261.6 392 392 ...
    440 440 392.0 392.0 349.2 349.2 329.6 329.6 ...
    293.7 329.6 293.7 329.6 ...
    293.7 329.6 261.6];

dur = 0.6;
delay_2 = delay_function(fs, 0.05 * 0.5);
delay_3 = delay_function(fs, 0.05 * 0.25);
delay_4 = delay_function(fs, 0.05 * 2);

y_twinkle = [];
for i = 1:13
    tone_twinkle = single_note_gen(twinkle(i), fs, dur);
    y_twinkle = [y_twinkle tone_twinkle delay];
end

y_twinkle = [y_twinkle single_note_gen(twinkle(14), fs, dur) delay_2];
y_twinkle = [y_twinkle single_note_gen(twinkle(15), fs, dur) delay_2];
y_twinkle = [y_twinkle single_note_gen(twinkle(16), fs, 2 * dur) delay_4];

for i = 17:28
    tone_twinkle = single_note_gen(twinkle(i), fs, dur);
    y_twinkle = [y_twinkle tone_twinkle delay];
end

y_twinkle = [y_twinkle single_note_gen(twinkle(29), fs, 0.25 * dur) delay_3];
y_twinkle = [y_twinkle single_note_gen(twinkle(30), fs, 0.25 * dur) delay_3];


y_twinkle = [y_twinkle single_note_gen(twinkle(31), fs, 0.25 * dur) delay_3];
y_twinkle = [y_twinkle single_note_gen(twinkle(32), fs, 0.25 * dur) delay_3];
y_twinkle = [y_twinkle single_note_gen(twinkle(33), fs, 0.5 * dur) delay_2];
y_twinkle = [y_twinkle single_note_gen(twinkle(34), fs, 0.5 * dur) delay_2];

for i = 35:48
    tone_twinkle = single_note_gen(twinkle(i), fs, dur);
    y_twinkle = [y_twinkle tone_twinkle delay];
end

y_twinkle = [y_twinkle single_note_gen(twinkle(49), fs, 0.25 * dur) delay_3];
y_twinkle = [y_twinkle single_note_gen(twinkle(50), fs, 0.25 * dur) delay_3];
y_twinkle = [y_twinkle single_note_gen(twinkle(51), fs, 0.25 * dur) delay_3];
y_twinkle = [y_twinkle single_note_gen(twinkle(52), fs, 0.25 * dur) delay_3];
y_twinkle = [y_twinkle single_note_gen(twinkle(53), fs, 0.5 * dur) delay_2];
y_twinkle = [y_twinkle single_note_gen(twinkle(54), fs, 0.5 * dur) delay_2];
%y_twinkle = [y_twinkle single_note_gen(twinkle(55), fs, 2 * dur) delay_4];

listen7 = false;

if (listen7)
    sound(y_twinkle, 0.7 * fs);
    keyboard;
    figure;
    plot(y_twinkle);
end

%% E.2
y_adsr = [];
dur_amp2 = [85 150 150 130];
dur_amp3 = [42.5 150 150 130];
dur_amp4 = [340 150 150 130];
tot_dur2 = sum(dur_amp) / 1000;
tot_dur3 = sum(dur_amp) / 1000;
tot_dur4 = sum(dur_amp) / 1000;

for i = 1:13
    a = adsr_classic_gen(fs, amplitude, dur_amp)';
    sig = single_note_gen(twinkle(i), fs, tot_dur);
    y_adsr = [y_adsr a .* sig delay];
end

sig = single_note_gen(twinkle(14), fs, tot_dur2);
y_adsr = [y_adsr a .* sig delay_2];

sig = single_note_gen(twinkle(15), fs, tot_dur2);
y_adsr = [y_adsr a .* sig delay_2];

sig = single_note_gen(twinkle(16), fs, tot_dur4);
y_adsr = [y_adsr a .* sig delay_4];

for i = 17:28
    a = adsr_classic_gen(fs, amplitude, dur_amp)';
    sig = single_note_gen(twinkle(i), fs, tot_dur);
    y_adsr = [y_adsr a .* sig delay];
end

sig = single_note_gen(twinkle(29), fs, tot_dur3);
y_adsr = [y_adsr a .* sig delay_3];

sig = single_note_gen(twinkle(30), fs, tot_dur3);
y_adsr = [y_adsr a .* sig delay_3];

sig = single_note_gen(twinkle(31), fs, tot_dur3);
y_adsr = [y_adsr a .* sig delay_3];

sig = single_note_gen(twinkle(32), fs, tot_dur3);
y_adsr = [y_adsr a .* sig delay_3];

sig = single_note_gen(twinkle(33), fs, tot_dur2);
y_adsr = [y_adsr a .* sig delay_2];

sig = single_note_gen(twinkle(34), fs, tot_dur2);
y_adsr = [y_adsr a .* sig delay_2];

for i = 35:48
    a = adsr_classic_gen(fs, amplitude, dur_amp)';
    sig = single_note_gen(twinkle(i), fs, tot_dur);
    y_adsr = [y_adsr a .* sig delay];
end

sig = single_note_gen(twinkle(49), fs, tot_dur3);
y_adsr = [y_adsr a .* sig delay_3];

sig = single_note_gen(twinkle(50), fs, tot_dur3);
y_adsr = [y_adsr a .* sig delay_3];

sig = single_note_gen(twinkle(51), fs, tot_dur3);
y_adsr = [y_adsr a .* sig delay_3];

sig = single_note_gen(twinkle(52), fs, tot_dur3);
y_adsr = [y_adsr a .* sig delay_3];

sig = single_note_gen(twinkle(53), fs, tot_dur2);
y_adsr = [y_adsr a .* sig delay_2];

sig = single_note_gen(twinkle(54), fs, tot_dur2);
y_adsr = [y_adsr a .* sig delay_2];

% sig = single_note_gen(twinkle(55), fs, tot_dur4);
y_adsr = [y_adsr a .* sig delay_4];

listen8 = true;

if (listen8)
    sound(y_adsr, fs);
    keyboard;
    figure;
    plot(y_adsr);
    figure;
    subplot(2, 2, 1);
    plot(a);
    hold on;
    subplot(2, 2, 2);
    plot(sig);
    subplot(2, 2, 3);
    plot(y_adsr);
    hold off;
end


%% E.3
freq_au = [164.8 146.8 196 196 196 220 246.9 220 196 246.9 220 220 196 196 196 220 246.9 220 196 246.9 220 220 196];
y_au = [];

for i = 1:length(freq_au)
    dur_au = 0.6 / 4;
    delay_au = delay_function(fs, 0.05);

    if (mod(i, 11) == 5 || mod(i, 11) == 6)
        dur_au = 0.6 / 2;
        delay_au = delay_function(fs, 0.1);
    end

    if (mod(i, 11) == 0)
        dur_au = 0.6;
        delay_au = delay_function(fs, 0.2);
    end

    au = single_note_gen(freq_au(i), fs, dur_au);
    y_au = [y_au au delay_au];
end

listen9 = false;

if (listen9)
    sound(y_au);
    keyboard;
    figure;
    plot(y_au);
end

 
%%E.4
y_adsr_au = [];
dur_amp_ = [85 150 150 130];
dur_amp_double = [170 150 150 130];
dur_amp_quad = [340 150 150 130];
tot_dur_ = sum(dur_amp_) / 1000;
tot_dur_double = sum(dur_amp_double) / 1000;
tot_dur_quad = sum(dur_amp_quad) / 1000;

for i = 1:length(freq_au)
    if (mod(i, 11) == 5 || mod(i, 11) == 6)
        % dur_au = 0.6/2;
        delay_au = delay_function(fs, 0.05);
        a = adsr_classic_gen(fs, amplitude, dur_amp_double)';
        sig = single_note_gen(freq_au(i), fs, tot_dur_double);
    elseif (mod(i, 11) == 0)
        % dur_au = 0.6;
        delay_au = delay_function(fs, 0.1);
        a = adsr_classic_gen(fs, amplitude, dur_amp_quad)';
        sig = single_note_gen(freq_au(i), fs, tot_dur_quad);
    else
        % dur_au = 0.6/4;
        delay_au = delay_function(fs, 0.025);
        a = adsr_classic_gen(fs, amplitude, dur_amp_)';
        sig = single_note_gen(freq_au(i), fs, tot_dur_);
    end

    y_adsr_au = [y_adsr_au a .* sig delay_au];
end

listen10 = false;

if (listen10)
    sound(y_adsr_au);
    keyboard;
    figure;
    plot(y_adsr_au);
    figure;
    plot(a);
    figure;
    plot(sig);
end

function delay = delay_function(fs, duration)
    % create pause between tone generation
    % depends on sample frequency and duration
    delay = single(zeros(1, round(fs * duration)));
end

% the function that converts a single note
function Y = single_note_gen(f, fs, duration)
    % change domains from continuous time to samples
    number_samples = round(fs * duration);
    N = 0:number_samples;
    Y = single(sin(2 * pi * f / fs * N));
end
% 
function a = adsr_classic_gen(fs, final_value, duration_ms)
    % Error checking
    if (length(final_value) ~= length(duration_ms) || ~isvector(final_value) || ~isvector(duration_ms))
        disp('***Error: array sizes not equal or they are not vectors (adsr_classic)');
        a = [];
        return
    end

    total_time_ms = sum(duration_ms);
    a = zeros(fs * total_time_ms / 1000, 1);
    num_phases = length(duration_ms);

    % convert from time to samples {t->n}
    duration_ms = round(fs * duration_ms / 1000);

    % All phases together
    stop = 1;

    for phase = 1:num_phases
        start = stop;
        stop = start + duration_ms(phase);
        slope = (final_value(phase) - a(start)) / duration_ms(phase);

        for i = start:stop
            a(i) = slope * (i - start) + a(start);
        end
    end
end
 
%% Appendix F.1
% % Simple FM synthesis
% f_carrier = 440;
% f_modulator = 10;
% amplitude_fm = 0.5;
% duration_fm = 2;
% fs_fm = 10000;
% 
% t_fm = 0:1/fs_fm:duration_fm;
% carrier = cos(2 * pi * f_carrier * t_fm);
% 
% modulator = cos(2 * pi * f_modulator * t_fm);
% 
% fm_signal = cos(2 * pi * f_carrier * t_fm + amplitude_fm * modulator);
% 
% listen11 = false;
% 
% if (listen11)
%     sound(fm_signal, fs_fm);
%     keyboard;
%     figure;
%     plot(fm_signal);
% end
% 
% % Appendix G.1
% % White noise generation
% duration_noise = 2;
% fs_noise = 10000;
% 
% noise = randn(1, round(fs_noise * duration_noise));
% 
% listen12 = false;
% 
% if (listen12)
%     sound(noise, fs_noise);
%     keyboard;
%     figure;
%     plot(noise);
% end
% 
% % Appendix H.1
% % Chirp signal
% f_start = 100;
% f_end = 1000;
% duration_chirp = 2;
% fs_chirp = 10000;
% 
% t_chirp = 0:1/fs_chirp:duration_chirp;
% chirp_signal = chirp(t_chirp, f_start, duration_chirp, f_end);
% 
% listen13 = false;
% 
% if (listen13)
%     sound(chirp_signal, fs_chirp);
%     keyboard;
%     figure;
%     plot(chirp_signal);
% end
