pair A,B,C,D;
pair P;
numeric j;
numeric delkax, delkay;
numeric it;

u=1mm;
A=(38u,34u);
B=(277u,65u);
D=(19u,177u);
C=(301u,185u);

delkax=1500u;
delkay=300u;
P=(100u,100u);

beginfig(1);

draw A--B--C--D--cycle;
draw fullcircle scaled 10u shifted P withcolor blue;

numeric k,l,m,n,g,h,i,j;
path ab,bc,cd,ad;
pair Ws,Qs,Wp,Qp;

k=(((ypart A) - (ypart B)) )/((xpart A) - (xpart B));
l=(ypart A)- k*(xpart A);

ab= ((0,l)--(delkax,k*delkax+l));

m=(((ypart C) - (ypart D)) )/((xpart C) - (xpart D));
n=(ypart C)- m*(xpart C);    

cd= ((0,n)--(delkax,m*delkax+n));
    
Qp:=((n-l)/(k-m),0);
Qp:=(xpart Qp,(xpart Qp)*k+l);
    
draw ab;
draw cd;

Qs=ab intersectionpoint cd;
draw fullcircle scaled 1u shifted Qs;
draw fullcircle scaled 10u shifted Qp withcolor blue;

g=(((ypart A) - (ypart D)) )/((xpart A) - (xpart D));
h=(ypart A)- g*(xpart A);

ad=((0,h)--(delkay,g*delkay+h));

i=(((ypart B) - (ypart C)) )/((xpart B) - (xpart C));
j=(ypart B)- i*(xpart B);    

bc= ((0,j)--(delkay,delkay*i+j));
    
Wp:=((j-h)/(g-i),0);
Wp:=(xpart Wp,(xpart Wp)*g+h);
    
draw bc;
draw ad;

Ws=bc intersectionpoint ad;
draw fullcircle scaled 1u shifted Ws;
draw fullcircle scaled 10u shifted Wp withcolor blue;


draw Wp--P dashed evenly;
draw Qp--P dashed evenly;

numeric e,f,o,p;
numeric levy,horni;

if ((xpart A)<(xpart D)):
    if ((xpart A)>(xpart Qp)): levy:=1;
    else: levy:=0;
    fi;
else:
    if ((xpart D)>(xpart Qp)): levy:=1;
    else: levy:=0;
    fi;
fi;

if ((xpart A)<(xpart B)):
    if ((xpart A)>(xpart Wp)): horni:=1;
    else: horni:=0;
    fi;
else:
    if ((xpart D)>(xpart Wp)): horni:=1;
    else: horni:=0;
    fi;
fi;

draw (0,0)--(100u,100u);

e=(((ypart Qp) - (ypart P)) )/((xpart Qp) - (xpart P));
f=(ypart Qp)- e*(xpart Qp);

o=(((ypart Wp) - (ypart P)) )/((xpart Wp) - (xpart P));
p=(ypart Wp)- o*(xpart Wp);

draw (0,f)--(delkax,delkax*e+f);
draw (0,o)--(.5u,.5u*p+o);

pair alfa,beta;

alfa:=((h-f)/(e-g),0);
alfa:=(xpart alfa,(xpart alfa)*e+g);

beta:=((n-p)/(o-m),0);
beta:=(xpart beta,(xpart beta)*o+p);

draw fullcircle scaled 10u shifted alfa withcolor red;
draw fullcircle scaled 10u shifted beta withcolor red;





  

endfig;