% 11. Mutual recursion
fun {IsEven X}
   if X==0 then true else {IsOdd X-1} end
end
fun {IsOdd X}
   if X==0 then false else {IsEven X-1} end
end

/*
([({IsEven X},{X=>x1})],{x1=N1})
About the induction stage,
([({IsOdd X},{X=>x2})],{x2=N2})
Therefore, the meaning stack and storage area do not grow. The reverse is also true.
Since this process is repeated, it can be seen that it can be executed with a certain semantic stack and storage area.
*/
