clear all;close all;clc
%%Time specifications:
Fs = 20000;                   % samples per second
ts = 1/Fs;                   % seconds per sample

t11 = -1.5:0.00014:-1;
t12 = -1:0.00014:0;
t122 = 0:0.00014:1;
t13 = 1:0.00014:1.5;
t = [t11 t12 t122 t13];

%Generation of message singnal 1
x1 = zeros(size(t11));
x2 = ones(size(t12));
x3 = ones(size(t122));
x4 = zeros(size(t13));
m1 = [x1 x2 x3 x4];
plot(t,m1);
axis([-2 2 0 1.5]);

%Generation of message singnal 2
x1 = zeros(size(t11));
x2 = t12+1;
x3 = -1.*t122+1;
x4 = zeros(size(t13));
m2 = [x1 x2 x3 x4];
figure(2)
plot(t,m2)

%Generation of Carrier singnals
c1 = 5*sin(2*pi*7000.*t);
c2 = 5*sin(2*pi*6000.*t);

%Modulation of signals
fm1 = m1.*c1;
fm2 = m2.*c2;

%Adding modulated signals
fm = fm1+fm2;
figure
plot(t,fm);


%0-8KHz channel
Wn = 8000/(Fs/2);
[b,a] = butter(6, Wn, 'low');
filteredSignal = filter(b, a, fm);
figure
plot(t,filteredSignal);

%Demodulating message signal 1
Wn = 7000/(Fs/2);
[b,a] = butter(6, Wn, 'low');
rm11 = filter(b, a, filteredSignal);
rm1 = rm11.*c1;
Wn = 110/(Fs/2);
[b,a] = butter(6, Wn, 'low');
m11 = filter(b, a, rm1);
figure
plot(t,m11);


%Demodulating message signal 2
Wn = 6000/(Fs/2);
[b,a] = butter(6, Wn, 'low');
rm22 = filter(b, a, filteredSignal);
rm2 = rm22.*c2;

Wn = 100/(Fs/2);
[b,a] = butter(6, Wn, 'low');
m22 = filter(b, a, rm2);
figure
plot(t,-1.*m22);


