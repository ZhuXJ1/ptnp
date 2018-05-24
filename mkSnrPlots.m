function mkSnrPlots(midSNR,SNRt,detprob,f,t,mark,label)
% Make plots for SNR and detection probability
% t in years, f - frequency bins
% label - additional text for plots, that would distinguish them

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
title(['SNR-components before summing: ' label ' Color: pulsar pairs.'])
grid on
print('-dpng',['output/demo_' mark '_SNRmidsum']);
close all;

% Shows how SNR grows with time
logtyr = log10(t);
logSNRt = log10(SNRt);

loglog(logtyr,logSNRt)
xlabel('log_{10}(T/c.yr)')
ylabel('log_{10}SNR')
grid on
title(['SNR(t): ' label])
print('-dpng',['output/demo_' mark '_SNRt']);
close all;

% Plot detection probability
plot(t,detprob)
xlabel('T, years')
ylabel('P_{det}')
title(['Detection probability: ' label])
print('-dpng',['output/demo_' mark '_detprob'])
close all;

return