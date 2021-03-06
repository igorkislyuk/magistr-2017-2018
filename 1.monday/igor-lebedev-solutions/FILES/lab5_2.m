%c = input('c=');
%r = input('r=');
%l = input('L=');
%disp('Enter [a,b] and k:');
%a = input('a=');
%b = input('b=');
%k = input('k=');
%er = input('error=');
[c1,c2,r1, r2, L1, L2,a,b,k,er] = textread('matlab2.txt','%f %f %f %f %f %f %f %f %f %f');
wp1 = sqrt(1/(L1*c1))/(2*pi);
wp2 = sqrt(1/(L2*c2))/(2*pi);
w = 2*pi*a : 2*pi*k : 2*pi*b;
g = r1./(r1^2+(w*L1-1./(w*c1)).^2)+r2./(r2^2+(w*L2-1./(w*c2)).^2);
pogr = (rand(1,length(g))-0.5)*2*er;
new = g+g.*pogr;
figure(1);
plot(w,g,w,new);
legend('theroretic calc', 'empiric calc');
