function Gamma = olf(costhetaij)
% Calculating overlap reduction function, from cosine of angles between
% two pulsars. Assuming it is not the same pulsar.
% Formula 24 in Pablo Rosado's paper: https://arxiv.org/pdf/1503.04803.pdf

gamma = 0.5*(1 - costhetaij);
Gamma = 1.5*gamma.*log(gamma) - 0.25*gamma + 0.5;

return