beginfig(1);
j=1mm;
%Pi
%numeric pi;
%pi=3.141592;
%Rozliseni
pair aO,bO,dO;
aO=(0,0);
bO=(0,100);
dO=(100,0);

%Kalibracni body
pair a,b,c,d;

a=(1j,1j);
b=(0j,8j);
c=(9j,9j);
d=(8j,0j);

%(0,8)    (9,9)
%  B        C
%  A        D
%(1,1)    (8,0)

%Pocatecni vykresleni

draw a--b--c--d--cycle;
draw aO--bO--(xpart dO,ypart bO)--dO--cycle;

%Posouvame do pocatku
b:=b shifted -a;
d:=d shifted -a;
c:=c shifted -a;
a:=a shifted -a;

%Vykresleni
draw a--b--c--d--cycle withcolor .8white;

%Otacime...snad to pujde...
numeric uhel;
pair c.b;
uhel:=angle(b);
b:= b rotated(90-uhel);
c.b:= c rotated(90-uhel);

%Vykresleni
draw a--b--c--d--cycle  withcolor .7white;
draw fullcircle scaled 1mm shifted d withcolor blue;

%Otacime...snad to pujde...
numeric uhel;
pair c.d;
uhel:=angle(d);
d:= d rotated(-uhel);
c.d:= c rotated(-uhel);

%hledame c
c:=(b--c.b) intersectionpoint (d--c.d);

%Vykresleni
draw a--b--c--d--cycle  withcolor (1,0,1);
draw fullcircle scaled 1mm shifted d withcolor blue;

%Menime velikost
numeric pomer;
pomer=(ypart bO/ypart b);
show pomer;
b:= b scaled pomer;
c:= c scaled pomer;
d:= d scaled pomer;

%Vykresleni
draw a--b--c--d--cycle  withcolor .7white;
draw fullcircle scaled 1mm shifted d withcolor blue;

%Menime velikost
numeric pomer;
pomer=(xpart dO/xpart d);
show pomer;
d:= d scaled pomer;
c:= c scaled pomer;

%Vykresleni
draw a--b--c--d--cycle  withcolor red;

endfig;