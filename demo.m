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
tobs = 20;
tsam = 2*7*24*60*60; % Sampling time, two weeks between observations.

f = b.ftso(tsam,tobs);
[midSNR, SNR] = snrAstat(ra,dec,sigma_typical,tobs,tsam);
fprintf('SNR = %i, for %i years of obs. with IPTA, noise PSD %i, and 4 pulsars \n',SNR,tobs,sigma_typical);

% Shows how mid-sum-SNR (before summing over frequencies and pulsar pairs)
% looks like for different pulsar pairs for IPTA.
loglog(f,midSNR(:,1))
hold on
for ii=2:size(midSNR,2)
  hold on
  loglog(f,midSNR(:,ii))
end
xlabel('Frequency, Hz')
ylabel('SNR midsum: Gamma^2 S^2 / P^2')
grid on
print('-dpng','output/demo_ipta_SNRmidsum');
close all;

% Shows how SNR grows with time for IPTA.
tc.yr = fliplr((1./f)/c.yr);
midsum = sum(midSNR,2);
for ii=1:size(midSNR,1)
    SNRt(ii) = sqrt(2*sum(midsum(end-ii+1:end)));
end
logtc.yr = log10(tc.yr);
logSNRt = log10(SNRt);

loglog(logtc.yr,logSNRt)
xlabel('log_{10}(T/c.yr)')
ylabel('log_{10}SNR')
grid on
title('SNR(f) for IPTA pulsars, assuming fixed noise')
print('-dpng','output/demo_ipta_SNRt');
close all;

% Detection probability
% Eq.15 in Pablo Rosado's paper: https://arxiv.org/pdf/1503.04803.pdf
alpha0=0.001;
detprob = 0.5*erfc(erfcinv(2*alpha0)-SNRt/sqrt(2));

plot(tc.yr,detprob)
xlabel('T, years')
ylabel('P_{det}')
print('-dpng','output/demo_ipta_detprob')
close all;

return
