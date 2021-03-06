x = rand(500,1);
m1 = mean(x)
d1 = var(x) %dispersion
s1 = std(x)

m=0.5;
Dm = abs((m1-m)/m)*100;
fprintf('\nRelative error in Mean value: %g%%\n', Dm);

d = 1/12;
Dd = abs((d1-d)/d)*100;
fprintf('\nRelative error in Dispersion: %g%%\n', Dd);

s = sqrt(d);
Ds = abs((s1-s)/s)*100;
fprintf('\nRelative error in Standart Deviation: %g%%\n', Ds);

fig1 = figure(1);
set(fig1, 'name', 'Random values of rand()');
%plot(x, 'o', 'MarkerSize', 3);
hist(x, 20);
str = '\bf\fontsize{11}\fontname{times}Checking uniform random';
title(str);
xlabel('\bf\fontsize{11}\fontname{times} Random nubmers');

F0 = unifcdf(x,0,1);
H = kstest(x, [x,F0]);
fprintf('Kolmogorov-Smirnov test criteria value: %.2f\n', H);