(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



Needs["RiemannHilbert`"];
FT;
iFT;
LS;
LSGetnu;
LSSetnu;
Begin["Private`"];


CME[x_]:=Chop[x,$MachineEpsilon];
FT[q_,n_,el_]:=Module[{qf,qfb,Dm,Dmb,IIm,IImb,P,Pb,id,Q,R,Qb,Rb,DM,DMb,q\[Sigma]1,q\[Sigma]1b,J\[Sigma]3,J\[Sigma]31,J\[Sigma]3b,J\[Sigma]31b,rhs,A,Ab},
 qf=Fun[q,Line[{-el,0}],n];
qfb=Fun[q,Line[{0,el}],n];
Print[{qfb[el],DCTPlot[qfb]}];
Dm=DerivativeMatrix[qf];
Dmb=DerivativeMatrix[qfb];
IIm=ReduceDimensionIntegrateMatrix[qf];
IImb=(ReduceDimensionIntegrateMatrix[(qfb//ReverseOrientation)]//Transpose//Reverse//Transpose//Reverse);
id=IdentityMatrix[n];
Q = IIm.Values[qf];
Qb = IImb.Values[qfb];

FT[Q,Qb,id,IIm,IImb]];
FT[Q_,Qb_,id_,IIm_,IImb_][w_]:=Module[{ans0,ans1,rhs,lhs,n,s1,s2,qb,q,r,rb},
ans0 = LinearSolve[id -I w IIm//CME,Q//CME];
ans1=LinearSolve[id-I w IImb //CME, Qb //CME];
ans0[[-1]]-ans1[[1]]
];
iFT[q_,n_,el_]:=Module[{qf,qfb,Dm,Dmb,IIm,IImb,P,Pb,id,Q,R,Qb,Rb,DM,DMb,q\[Sigma]1,q\[Sigma]1b,J\[Sigma]3,J\[Sigma]31,J\[Sigma]3b,J\[Sigma]31b,rhs,A,Ab},
 qf=Fun[q,Line[{-el,0}],n];
qfb=Fun[q,Line[{0,el}],n];
Print[{qfb[el],qfb//DCTPlot}];
Dm=DerivativeMatrix[qf];
Dmb=DerivativeMatrix[qfb];
IIm=ReduceDimensionIntegrateMatrix[qf];
IImb=(ReduceDimensionIntegrateMatrix[(qfb//ReverseOrientation)]//Transpose//Reverse//Transpose//Reverse);
id=IdentityMatrix[n];
Q = IIm.Values[qf];
Qb = IImb.Values[qfb];

iFT[Q,Qb,id,IIm,IImb]];
iFT[Q_,Qb_,id_,IIm_,IImb_][w_]:=Module[{ans0,ans1,rhs,lhs,n,s1,s2,qb,q,r,rb},
ans0 = LinearSolve[id +I w IIm//CME,Q//CME];
ans1=LinearSolve[id+I w IImb //CME, Qb //CME];
(ans0[[-1]]-ans1[[1]])/(2 Pi)
];
LSSetnu[nu1_]:=Module[{},nu=nu1];
LSGetnu[]:=nu;
LS[FT_,x_,t_]:=Module[{n,L,strip,tcrit,integrand,\[Gamma],fun,z,k0,a,fun1,fun2,fun3,Lt,Lend,Rend},
n = 70; (*interpolation points per contour*)
L = 25;
Lend=100;
strip = nu;
tcrit = 8;
integrand[k_]:=1/(2*Pi)*Exp[I*x*k+I*k^2*t]*FT[k];
If[t ==0.,
\[Gamma] = Sign[x];
fun = Fun[integrand,Line[{-L+I*\[Gamma]*strip,L+I*\[Gamma]*strip}],3*n];
z=DomainIntegrate[fun];
];
If[t>0&&t<=tcrit,k0=-x/(2 t);
a=strip*Exp[I*Pi/4];
If[Abs[k0]<L-Sqrt[2],fun1=Fun[integrand,Line[{-L-a,-a+k0}],n];
fun2=Fun[integrand,Line[{-a+k0,a+k0}],n];
fun3=Fun[integrand,Line[{a+k0,a+L}],n];
(*Print[{fun1,fun2,fun3}];*)z=DomainIntegrate[{fun1,fun2,fun3}];,\[Gamma]=Sign[x];
fun=Fun[integrand,Line[{-L+I*\[Gamma],L+I*\[Gamma]}],3*n];
z=DomainIntegrate[fun];];];
If[t > tcrit,
k0 = -x/(2t);
a = strip*Exp[I*Pi/4]/Sqrt[t];
Lt =L/Sqrt[t];
(*If[Abs[k0]<Lt-0*Sqrt[2]/Sqrt[t],*)
fun1 = Fun[integrand,Line[{-Lt-a+k0,-a+k0}],n];
fun2 = Fun[integrand,Line[{-a+k0,a+k0}],n];
fun3 = Fun[integrand,Line[{a+k0,a+Lt+k0}],n];
(*Print[{fun1,fun2,fun3}];
Print[{a+k0,a+Lt}//N];*)
z = DomainIntegrate[{fun1,fun2,fun3}];
];
z
];


End[];
