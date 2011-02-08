prologues := 1.5

u=2cm;
pair W;
pair Q;
pair A;
pair B;
pair C;
pair D;
pair P;
pair alpha;
pair beta;

beginfig(1);

Q:= (0,3u);
W:= (6u,8u);

D:= (9u,0);

C:= (Q--D) intersectionpoint (W--(3u,0));
B:= (W--D) intersectionpoint (Q--(9u,6u));
A:= (W--C) intersectionpoint (Q--B);

alpha := (Q--(Q shifted (10u,0))) intersectionpoint (W--D);
beta := (W--(W shifted (0,-10u))) intersectionpoint (Q--D);

P:= (Q--alpha) intersectionpoint (W--beta);

draw Q--D;
draw Q--B;
draw W--D;
draw W--C;

draw Q--alpha dashed evenly;
draw W--beta dashed evenly;


dotlabel.lft(btex $Q$ etex,Q);
dotlabel.lft(btex $W$ etex,W);

dotlabel.lrt(btex $D$ etex,D);
dotlabel.llft(btex $C$ etex,C);
dotlabel.ulft(btex $A$ etex,A);
dotlabel.urt(btex $B$ etex,B);

dotlabel.urt(btex $P$ etex,P);

label.ulft(btex $\alpha$ etex,(Q--alpha) intersectionpoint (W--C));
label.ulft(btex $\beta$ etex,(W--beta) intersectionpoint (Q--B));
endfig;

