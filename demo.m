function demo

% Step 1. Demonstrating SNR(f)

sigma_typical = 100e-9; % typical pulsar timing noise
f1 = 1e-7;
f2 = 1e-9;

f = linspace(f1,f2,1000);
SNRf = sqrt(2)*Sh0_model(f)/(sigma_typical);

logf = log10(f);
logSNRf = log10(SNRf);

loglog(logf,logSNRf)
xlabel('lg(f)');
ylabel('lg(SNR)');
grid on;
print('-dpng','output/demo_lgSNRlgf');
close all;

% Step 2. Demonstrating SNR(t), where SNR is for f=1/T, T - obs. time

yr = 365*24*60*60; % year in seconds
t1 = 1;
t2 = 10;

t = linspace(t1*yr,t2*yr,1000);
tyr = linspace(t1,t2,1000);
SNRt = sqrt(2)*Sh0_model(1./t)/(sigma_typical);

logtyr = log10(tyr);
logSNRt = log10(SNRt);

loglog(logtyr,logSNRt)
xlabel('lg(t/year)');
ylabel('lg(SNR)');
grid on;
title('SNR for lowest available frequency f=1/T, T - obs. time');
print('-dpng','output/demo_lgSNRlgt');
close all;

% Step 3. Demonstrating detection SNR(t) for 4 IPTA pulsars, using their
% sky positions, assuming timing noise is 100 ns (down to 10ns)

% Sky positions in hours, seconds, minutes
ra = [04 37 15.8961747 ; 17 13 49.5327232 ; 17 44 29.405794 ; 19 09 47.4346740];
dec = [47 15 09.11071 ; 07 47 37.49790 ; 11 34 54.6809 ; -37 44 14.46670];

% Opening angle ? between two ra-dec angles: cos ? = cos ? cos ?p cos(? ? ?p) + sin ? sin ?p
% Where ? and ?p - right accentions, ? and ?p - declinations.
% From below Eq. 3 in: https://arxiv.org/pdf/1502.06001.pdf

t1 = 2;
t2 = 20;
t = linspace(t1*yr,t2*yr,1000);

midSNR1 = (olf(costheta)*reshape(Sh0_model(f),1,1,length(f))/sigma_typical)^2;

return