function [SNR,midSNR,SNRt] = snrAstat(ra,dec,sigma,tobs,tsam)
% A-statistic of Pablo Rosado's paper: https://arxiv.org/pdf/1503.04803.pdf
% ra, dec: pulsar coordinates.
% ra: lines of hh,mm,ss (3 columns); dec: lines of dd,mm,ss (3 columns);
% tsam - sampling time in seconds; tobs - observation time in years
% sigma: uncertainty
% ----------- 
% Author: Boris Goncharov, goncharov.boris@physics.msu.ru

b = basics;
c = constants;

% Make combinations of pulsar pairs
rasz = size(ra);
radeccomb = combnk(linspace(1,rasz(1),rasz(1)),2);
rdpsz = size(radeccomb);

% Defining frequency bins for integration
f = b.ftso(tsam,tobs);

% Summing over frequency bins and pulsar pairs
midSNR = 0;
for ii=1:length(f)
  for jj=1:rdpsz(1)
    midcos1 = cos(dmsToRad(dec(radeccomb(jj,1),:)))*cos(dmsToRad(dec(radeccomb(jj,2),:)));
    midcos2 = cos( hmsToRad(ra(radeccomb(jj,1),:)) - hmsToRad(ra(radeccomb(jj,2),:)) );
    midcos3 = sin(dmsToRad(dec(radeccomb(jj,1),:)))*sin(dmsToRad(dec(radeccomb(jj,2),:)));
    costheta = midcos1*midcos2 + midcos3;
    midSNR(ii,jj) = ( olf(costheta)*Sh0_model(f(ii)) / sigma(1) )^2;% / (sigma(radeccomb(jj,1))*sigma(radeccomb(jj,2)));
  end
end

SNR = sqrt(2*sum(sum(midSNR)));

midsum = sum(midSNR,2);
for ii=1:size(midSNR,1)
    SNRt(ii) = sqrt(2*sum(midsum(end-ii+1:end)));
end

return
