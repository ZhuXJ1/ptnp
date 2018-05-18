function Gamma = olf(i,j,costhetaij)
% Calculating overlap reduction function, from cosine of angles between
% two pulsars
% Formula 24 in Pablo Rosado's paper: https://arxiv.org/pdf/1503.04803.pdf

if i==j
    delta = 1;
elseif i~=j
    delta = 0;
end

gamma = 0.5*(1 - costhetaij);
Gamma = 1.5*gamma*log(gamma) - 0.25*gamma + 0.5 + 0.5*delta;

return