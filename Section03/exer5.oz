% 5. Iterative SumList

/*
Initial state: (0,Xs)
Intermediate state: (current result, remaining list) = (A,Ys)
Relation with the following state: (A,Ys) => (A+Y,Yr))
*/

declare
fun {SumList Xs}
   fun {SumListIter Ys A}
      case Ys
      of nil then A
      [] Y|Yr then {SumListIter Yr A+Y} end
   end
in
   {SumListIter Xs 0}
end
