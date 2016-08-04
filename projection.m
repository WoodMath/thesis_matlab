clear all;
close all;

figure;
hold on;
set(gca,'xlim',[-10 10]);
set(gca,'ylim',[-10 10]);

v10 = [1,0,0.5];
v01 = [0,1,0];
p00 = [2,-3,2];
p10 = p00+v10/norm(v10)*8;
p01 = p00+v01/norm(v01)*6;
p11 = p00+v10/norm(v10)*8+v01/norm(v01)*6;

h00 = p00/p00(3);
h01 = p01/p01(3);
h10 = p10/p10(3);
h11 = p11/p11(3);


line([h00(1) h01(1)],[h00(2) h01(2)], 'linestyle', '-', 'color', 'r');
line([h01(1) h11(1)],[h01(2) h11(2)], 'linestyle', '-', 'color', 'r');
line([h11(1) h10(1)],[h11(2) h10(2)], 'linestyle', '-', 'color', 'r');
line([h10(1) h00(1)],[h10(2) h00(2)], 'linestyle', '-', 'color', 'r');








