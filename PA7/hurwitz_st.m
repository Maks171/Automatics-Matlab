function [] = hurwitz_st(k, Ti, Td)
T = 0.01;
Go = tf([10], [1 2 2 1]);
Gr = tf([k*Ti*(T+Td),k*(T+Ti),k],[Ti*T, Ti, 0]);
G = series(Go, Gr);
Gz = feedback(G, 1);
[~, den] = tfdata(Gz);
p = cell2mat(den);

n = numel(p)-1;
p1 = p(2:2:end);
p2 = p(1:2:end);
if isnumeric(p)
    H = zeros(n,n);
    delta = zeros(n,1);
else
    H = sym(zeros(n,n));
    delta = sym(zeros(n,1));
end
i = 0;
for k = 1:n
    if mod(k,2)
        H(k,i+[1:numel(p1)]) = p1;
    else
        H(k,i+[1:numel(p2)]) = p2;
        i = i + 1;
    end
end
for k = 1:n
    delta(k) = det(H(1:k,1:k));
end
signs = sign(delta);
a = ismember(-1, signs);
if a == 1
    msgbox('Układ niestabilny!')
else
    msgbox('Układ stabilny!')
end