clear all;
close all;

%plot([0:0.05:10]',1*sin(pi*[0:0.05:10]'))

p0 = [0,9];
p1 = [0,1];
p2 = [0,-3];

[x,y] = meshgrid(-10:0.1:10);

vA = [3,-1];
vB = [3,0];
vC = [3,1];
vD = [3,2];

v1 = [0,1];
v2 = [0.3,1];


% Linear equations of lines
lA = vA(1)*(x-p0(1))+vA(2)*(y-p0(2));
lB = vB(1)*(x-p0(1))+vB(2)*(y-p0(2));
lC = vC(1)*(x-p0(1))+vC(2)*(y-p0(2));
lD = vD(1)*(x-p0(1))+vD(2)*(y-p0(2));

l1 = v1(1)*(x-p1(1))+v1(2)*(y-p1(2));
l2 = v2(1)*(x-p2(1))+v2(2)*(y-p2(2));

% b vectors in AX=b
sA = vA(1)*p0(1)+vA(2)*p0(2);
sB = vB(1)*p0(1)+vB(2)*p0(2);
sC = vC(1)*p0(1)+vC(2)*p0(2);
sD = vD(1)*p0(1)+vD(2)*p0(2);

s1 = v1(1)*p1(1)+v1(2)*p1(2);
s2 = v2(1)*p2(1)+v2(2)*p2(2);

% Intersections along line 1
iA = inv([vA;v1])*[sA;s1];
iB = inv([vB;v1])*[sB;s1];
iC = inv([vC;v1])*[sC;s1];
iD = inv([vD;v1])*[sD;s1];
iXY = [iA,iB,iC,iD]';

% Intersection along line 2
jA = inv([vA;v2])*[sA;s2];
jB = inv([vB;v2])*[sB;s2];
jC = inv([vC;v2])*[sC;s2];
jD = inv([vD;v2])*[sD;s2];
jXY = [jA,jB,jC,jD]';



%fplot(l1, [0,10])
%fplot(l, [-3,3], [-3,3]);
figure;
hold on;

contour(x,y,lA,[0 0],'b');
contour(x,y,lB,[0 0],'b');
contour(x,y,lC,[0 0],'b');
contour(x,y,lD,[0 0],'b');

contour(x,y,l1,[0 0],'r');
contour(x,y,l2,[0 0],'g');

plot(iXY(:,1)',iXY(:,2)','r','marker','*');
plot(jXY(:,1)',jXY(:,2)','g','marker','*');



iDA = norm(iD-iA);
iDB = norm(iD-iB);
iCA = norm(iC-iA);
iCB = norm(iC-iB);
iCACB = iCA / iCB;
iDADB = iDA / iDB;
iCross = iCACB / iDADB;

jDA = norm(jD-jA);
jDB = norm(jD-jB);
jCA = norm(jC-jA);
jCB = norm(jC-jB);
jCACB = jCA / jCB;
jDADB = jDA / jDB;
jCross = jCACB / jDADB;


