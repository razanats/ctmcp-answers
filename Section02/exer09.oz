% 9. Tail recursion
fun {Sum1 N}
   if N==0 then 0 else N+{Sum1 N-1} end
end
fun {Sum2 N S}
   if N==0 then S else {Sum2 N-1 N+S} end
end

% (a) Expansion to nuclear language
% * Expand only the 'else' clause.
declare 
fun {Sum1 N}
   if N == 0 then 0
   else Mid in
      Mid = {Sum1 N-1}
      N + Mid
   end
end
fun {Sum2 N S}
   if N == 0 then S
   else Mid1 Mid2 in
      Mid1 = N-1
      Mid2 = N+S
      {Sum2 Mid1 Mid2}
   end
end
{Browse {Sum1 10}}

% (b)
Sum1 = proc {$ N ?S}
	  if N == 0 then S = 0
	  else Mid NMid in
	     NMid = N-1
	     {Sum NMid Mid}
	     S = N + Mid
	  end
       end
% N = 0 when: ( [ ({Sum1 NMid Mid},{N=>n1,NMid=>n0,S=>m1,Mid=>m0}),(S=N+Mid,{N=>n1,NMid=>n0,S=>m1,Mid=>m0}),...,(S=N+Mid,{N=>n10,NMid=>n9,S=>res,Mid=>m9}) ], {res,m9,...,m0,n10=10,...,n0=0} )
% As shown in, both the semantic stack and the storage area are proportional to N.

Sum2 = proc {$ N S ?Sn}
	  if N == 0 then Sn = S
	  else NMid SMid in
	     NMid = N-1
	     SMid = N+S
	     {Sum2 NMid SMid Sn}
	  end
       end
% N = 0 when:( [ ({Sum2 NMid Mid Sn},{Sn=>res,N=>n1,NMid=>n0,S=>s1,SMid=>s2}) ], {res,n10=10,...,n0=0,s10=10,...,s0=55} )
% (Optimized storage area by GC) => {res,n1=1,n0=0,s1=54,s0=55}
% Like, the meaning stack is always below a certain number. In the storage area, the number of variables that can be reached is always less than a certain number.


% (c)
{Browse {Sum1 100000000}} % => About 20 seconds
{Browse {Sum2 100000000 0}} % => Over 4 minutes (unknown) Stack overflow?
