prologues := 1

u=.5cm;
path ctverec;
ctverec = (0,0)--(0,1u)--(1u,1u)--(1u,0)--cycle;

beginfig(1);
draw ctverec;
draw ctverec shifted (0,1u);
draw ctverec shifted (0,-1u);
draw ctverec shifted (1u,0);
draw ctverec shifted (-1u,0);


draw ctverec shifted (0,5u);
draw ctverec shifted (0,-5u);
draw ctverec shifted (5u,0);
draw ctverec shifted (-5u,0);

label("P",(.5u,.5u));

label("I",(.5u,.5u) shifted (0,1u));
label("I",(.5u,.5u) shifted (0,-1u));
label("I",(.5u,.5u) shifted (1u,0));
label("I",(.5u,.5u) shifted (-1u,0));

label("O",(.5u,.5u) shifted (0,5u));
label("O",(.5u,.5u) shifted (0,-5u));
label("O",(.5u,.5u) shifted (5u,0));
label("O",(.5u,.5u) shifted (-5u,0));
endfig;
