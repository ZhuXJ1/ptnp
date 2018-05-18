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
rasz = size(ra);
radeccomb = combnk(linspace(1,rasz(1),rasz(1)),2);
rdpsz = size(radeccomb);

% Opening angle theta between two ra-dec angles:
% cos(theta) = cos(dec1) cos(dec2) cos(ra1 - ra2) + sin(dec1) sin(dec2)
% From below Eq. 3 in: https://arxiv.org/pdf/1502.06001.pdf

tobs = 20;
tsam = 2*7*24*60*60; % Sampling time, two weeks between observations.

hfb = floor(tobs*yr/(2*tsam));
f = linspace(1/(tobs*yr),hfb/(tobs*yr),hfb);

midSNR = 0;
for ii=1:hfb
  for jj=1:rdpsz(1)
    midcos1 = cos(dmsToRad(dec(radeccomb(jj,1),:)))*cos(dmsToRad(dec(radeccomb(jj,2),:)));
    midcos2 = cos( hmsToRad(ra(radeccomb(jj,1),:)) - hmsToRad(ra(radeccomb(jj,2),:)) );
    midcos3 = sin(dmsToRad(dec(radeccomb(jj,1),:)))*sin(dmsToRad(dec(radeccomb(jj,2),:)));
    costheta = midcos1*midcos2 + midcos3;
    midSNR(ii,jj) = ( olf(costheta)*Sh0_model(f(ii)) / sigma_typical )^2;
  end
end

SNR = sqrt(2*sum(sum(midSNR)));
fprintf('SNR = %i, for %i years of obs. with IPTA, noise PSD %i, and 4 pulsars \n',SNR,tobs,sigma_typical);


image(midSNR)
xlabel('Combination of a pulsar pair')
ylabel('Observation time, n/20 years')
hcb = colorbar;
ylabel(hcb,'SNR midsum: ?^2 S^2 / P^2')
close all;

return
