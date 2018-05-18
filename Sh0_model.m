function Sh0 = Sh0_model(f)
% Power spectral density of the SMBH SGWB
% Formula 25 in Pablo Rosado's paper: https://arxiv.org/pdf/1503.04803.pdf

A = 1e-15;
%yr = 1; % not sure what it is
yr = 365*24*60*60; % year in seconds?
Sh0 = A^2*yr^(-4/3).*f.^(-13/3)/(12*pi^2);

return