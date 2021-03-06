c1 = 2;
c2 = 4;
c3 = -1;
c4 = -2;

f = @(x1,x2)(c1*x1 +c2*x2 + c3*x1^2 +c4*x2^2);

A = [-1 2; 2 1];
b = [3;4];
lb = zeros(2,1);
d = 0.00001;

x1 = 0;
x2 = 0;

k = 1;
kmax = 100;

x1trace = [x1];
x2trace = [x2];

i=2;
while k<kmax;
    gr1 = c1 + 2*c3*x1;
    gr2 = c2 + 2*c4*x2;
    Z = linprog([-gr1; -gr2], A, b, [], [], lb);
    g = -((c1 + 2*c3*x1)*(Z(1) -x1) + ...
        (c2 + 2*c4*x2)*(Z(2) -x2))/ ...
        (2*c3*(Z(1) - x1)^2 + 2*c4*(Z(2) - x2)^2);
    new_x1 = x1 + g*(Z(1) - x1);
    new_x2 = x2 + g*(Z(2) - x2);
    new_f = f(new_x1, new_x2);
    old_f = f(x1,x2);
    x1trace(i) = new_x1;
    x2trace(i) = new_x2;
    i = i+1;
    x1 = new_x1;
    x2 = new_x2;
    if (new_f - old_f) / old_f <= d;
        break;
    end
    k = k+1;
end

x = 0 : 0.1 : 2;
y = 0 : 0.1 : 2;
[X, Y] = meshgrid(x,y);
plot([0 1], [1.5 2], 'r-', 'LineWidth', 3);
hold on;
plot([1 2], [2 0], 'r-', 'LineWidth', 3);
Z = c1*X + c2* Y + c3*X.^2 + c4*Y.^2;
[C, h] = contour(X, Y, Z);
clabel(C, h);

plot(x1trace, x2trace, '-');
text(x1trace(1) - 0.1, x2trace(1) - 0.1, 'M0');
text(x1 + 0.1, x2+ 0.1, ...
    strvcat(['x1 = ' num2str(x1)],...
            ['x2 = ' num2str(x2)],...
            ['k = ' num2str(k)]));