% 4. Iterative factorial calculation

/*
.---------- N -----------.
e1 e2 ... ei e(i+1) ... en
             '----i-1----'

Current calculation result: A
Remaining calculation: i-1 ~ 1
That is, the intermediate state can be represented by (A,i).
Furthermore, the initial state is (1,N).
The next state of a state (1,N) is (A*i,i-1).
From this, the following function is obtained.
*/

fun {Fact N}
   fun {FactIter N A}
      if N==1 then A
      else {Fact N-1 N*A} end
   end
in
   {FactIter N 1}
end
