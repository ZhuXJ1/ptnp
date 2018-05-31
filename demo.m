function demo

b = basics;
c = constants;

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

t1 = 1;
t2 = 10;

t = linspace(t1*c.yr,t2*c.yr,1000);
tc.yr = linspace(t1,t2,1000);
SNRt = sqrt(2)*Sh0_model(1./t)/(sigma_typical);

logtc.yr = log10(tc.yr);
logSNRt = log10(SNRt);

loglog(logtc.yr,logSNRt)
xlabel('lg(t/year)');
ylabel('lg(SNR)');
grid on;
title('SNR for lowest available frequency f=1/T, T - obs. time');
print('-dpng','output/demo_lgSNRlgt');
close all;

clear SNRt;
clear SNRf;
clear logSNRt;
clear logSNRf;

% Step 3. Demonstrating detection SNR(t) for 4 IPTA pulsars, using their
% sky positions, assuming timing noise is 100 ns (down to 10ns)

% Sky positions in hours, seconds, minutes
ra = [04 37 15.8961747 ; 17 13 49.5327232 ; 17 44 29.405794 ; 19 09 47.4346740];
dec = [47 15 09.11071 ; 07 47 37.49790 ; 11 34 54.6809 ; -37 44 14.46670];
sigma = [100e-9 ; 100e-9 ; 100e-9 ; 100e-9];
tobs = 20;
tsam = 2*7*24*60*60; % Sampling time, two weeks between observations.

f = b.ftso(tsam,tobs);
t = b.tfromf(f);
[SNRa, midSNRa, SNRta] = snrAstat(ra,dec,sigma,tobs,tsam);
[SNRb, midSNRb, SNRtb] = snrBstat(ra,dec,sigma,tobs,tsam);
fprintf('A-statisic: SNR = %i, for %i years of obs. with PPTA, mean noise PSD %i, and 4 pulsars \n',SNRa,tobs,mean(sigma));
fprintf('B-statisic: SNR = %i, for %i years of obs. with PPTA, mean noise PSD %i, and 4 pulsars \n',SNRb,tobs,mean(sigma));

% Detection probability
% Eq.15 in Pablo Rosado's paper: https://arxiv.org/pdf/1503.04803.pdf
alpha0=0.001;
detprobA = 0.5*erfc(erfcinv(2*alpha0)-SNRta/sqrt(2));
detprobB = 0.5*erfc(erfcinv(2*alpha0)-SNRtb/sqrt(2));

mkSnrPlots(midSNRa,SNRta,detprobA,f,t,'ppta4_100ns_Astat','PPTA4, 100ns, A-stat.')
mkSnrPlots(midSNRb,SNRtb,detprobB,f,t,'ppta4_100ns_Bstat','PPTA4, 100ns, B-stat.')

return
