sigma = 0.2;
k = 2;

colors = ['gh'; 'rd'; 'co'; 'ms'; 'yh';  'wo'; 'gs'; 'rh'; 'cd'; 'mo'; 'ys'; 'wd'; 'go'; 'rs'; 'ch'; 'md'; 'yo'; 'wh'];

data = dlmread('data/twocircles.data');
figure(); 
clf; 
hold on;

[n,m] = size(data);

W = zeros(n, n);
for i=1:n
    for j=1:n
        if i ~= j
            dist = norm(data(i, :)-data(j, :));
            W(i, j) = exp(-(dist * dist)/(2*sigma*sigma));
        end
    end
end

D = diag(sum(W));
DSR = inv(sqrtm(D));

L = DSR *  W * DSR;
[X1, DD] = eigs(L, k, 'LM');

Y = zeros(n, k);
for i=1:n
    Y(i, :) = X1(i, :)./norm(X1(i, :));
end

[MInd, kM] = kmeans(Y, k);

for i=1:k
    scatter(data(MInd == i,1), data(MInd == i,2), 15,  char(colors(i, :)));
end
hold off;