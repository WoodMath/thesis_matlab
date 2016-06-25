clear all;
close all;

v_a=[2,4,2];
v_b=[2,4,1];

v_a=v_a/v_a(3);
v_b=v_b/v_b(3);

figure;
hold on;
plot(v_a(1),v_a(2),'or');
plot(v_b(1),v_b(2),'og');

v_c=cross(v_a,v_b);

v_x = [-5:5]';
v_y = (v_c(1)*v_x+v_c(3))/-v_c(2);

plot(v_x,v_y,'-b');