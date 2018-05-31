%% calculate radiometer and jitter noise levels for some PPTA pulsars
fid = fopen('PPTA10p_psrcat.txt');
psrDat = textscan(fid, '%d %s %s %f64 %f64 %f64 %d %s %f64 %d %s %f64 %d %s %f64 %d %s %f64');
fclose(fid);
%
pp=psrDat{4}.*(pi/180); % raj
sp=psrDat{5}.*(pi/180); % dec in degree
dp=psrDat{18};
Perd0=psrDat{6}; % period, in sec
Perd1=psrDat{9}; % Pdot
W50=psrDat{12}; % pulse width, in ms
S1400=psrDat{15}; % flus density in mJy, at 1.4 GHz
Jname=psrDat{2};
%
Np=length(dp);
Ssys=20/16.5; % Tsys=20K, G=16.5 K Jy^-1, see 1407.0435 for FAST
tobs=30*60; % integration time, 30 min
deltaf=800; % bandwidth, in MHz
for j=1:Np
    xw50=W50(j);
    sigRad1=((1e-3*xw50)^(3/2))*Ssys/(1e-3*S1400(j)*sqrt(2e6*deltaf*tobs*(Perd0(j)-1e-3*xw50))); % radiometer noise
    sigJ=0.2*1e-3*xw50*sqrt(Perd0(j)/tobs); % Jitter noise, eq. 2 1407.0435
    fprintf('%s %4.4g %4.4g %4.4g \n',Jname{j},sigRad1,sigJ,sigRad1+sigJ);
end
