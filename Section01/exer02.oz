% 2. Calculation of combinations
% (a)
declare Perm FastComb
fun {Perm N K}
   if K==0 then 1
   else N*{Perm N-1 K-1} end
end
fun {FastComb N K}
   if K==0 then 1
   else {Perm N K} div {Perm K K} end
end

{Browse {FastComb 5 3}}

%(b)

% n*(n-1)*...*(n-k+1)/k!=n*(n-1)*...*(n-(k-1))/k!= 1 time And (k-1)+(k-1)=2k-2 times multiplication
% n*(n-1)*...*(n-k+1)/k!=n*(n-1)*...*(n-(k-1))/k!= 1 time And multiplication of (k-1)+(k-1)=2k-2 times n*(n-1)*...*(n-(nk)+1)/(nk)!=n* (n-1)*...*(n-(nk-1))/(nk)!= 1 division and (nk-1)+(nk-1)=2n-2k-2 multiplications
% Therefore, nCk is faster (or the same) when 2k-2<=2n-2k-2 ⇔ 2k<=n

declare VeryFastComb
fun {VeryFastComb N K}
   if 2*K =< N then {Comb N K}
   else {Comb N N-K} end
end

{Browse {VeryFastComb 4 2}}

declare Fact Comb
fun {Fact N}
   if N==0 then 1
   else N*{Fact N-1} end
end
fun {Comb N K}
   if K==0 then 1
   else {Fact N}div({Fact N-K}*{Fact K}) end
end
