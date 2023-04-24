function [] = nyquist_st(k, Ti, Td)
T = 0.01;
Go = tf([10], [1 2 2 1]);
Gr = tf([k*Ti*(T+Td),k*(T+Ti),k],[Ti*T, Ti, 0]);
G = series(Go, Gr);
nyquist(G)
end