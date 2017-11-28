NIND=40;
MAXGEN=300;
NVAR=20;
PRECI=20;
GGAP=0.9;

%
FieldD = [rep(PRECI,[1,NVAR]);rep([-512;512],[1,NVAR]);rep([1;0;1;1],[1,NVAR])];

%Initial population
Chrom = crtbp(NIND, NVAR*PRECI); 

gen = 0;

%Evaluate
ObjV = objfun1(bs2rv(Chrom, FieldD));

while gen < MAXGEN
   FitnV = ranking(ObjV); 
   
   SelCh = select('sus', Chrom, FitnV, GGAP);
   
   SelCh = recombin('xovsp', SelCh, 0.7);
   
   SelCh = mut(SelCh);
   
   ObjVSel = objfun1(bs2rv(SelCh, FieldD));
   
   [Chrom, ObjV] = reins(Chrom, SelCh, 1, 1, ObjV, ObjVSel);
   
   gen = gen +1;
end