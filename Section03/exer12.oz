% 12. List flattening complexity
fun {Flatten Ls}
   case Ls
   of nil then nil
   [] X|Xr andthen {IsList X} then {Append {Flatten X} {Flatten Xr}}
   [] X|Xr then X|{Flatten Xr}
   end
end

/*
Check the calculation amount of the subroutine. IsList is a fixed time. Append has a calculation amount proportional to the length of the first list. (T_Append=k4*n, where n is the length of the first list.)

First, it is considered that the worst case input Ls is as follows under the condition that the number of elements is n and the maximum nesting depth is k.
[ ... [ A1 A2 ... An ] ... ]
Since I want to obtain the calculation amount of procedure Flatten, T_Flatten(size(Ls)), as a parameter characterizing size(Ls),
size(Ls) = (n,k)
And (However, nil = [] is (0,1))
Create a recurrence formula for each case of the'case' statement.
T_Flatten((0,1)) = k1
T_Flatten((n,1)) = k2 + T_Flatten((n-1,1)) (when n > 0)
T_Flatten((n,k)) = k3 + T_Flatten((n,k-1)) + T_Flatten((0,1)) + k4*n（when n > 0, k > 0）
Than this (as k3+k1 ::= k5)
T_Flatten((n,k))
= (k5 + k4*n) + T_Flatten((n,k-1))
= (k5 + k4*n) + ... + (k5 + k4*n) + T_Flatten((n,1))
= (k-1)*(k5 + k4*n) + k2 + ... + k2 + k1
= (k-1)*(k5 + k4*n) + n*k2 + k1
Next to T_Flatten((n,k))は、O(n*k).

Note 1: In the definition of computational complexity of the book, the maximum of all cases is taken for the'case' statement, but it is strange to adopt an impossible case. It's understandable to take the worst case in the case of "completely random", but if not, I think it's appropriate to formulate a recurrence formula individually.
*/

/* Worst case 2
Check the calculation amount of the subroutine. IsList is a fixed time. Append has a calculation amount proportional to the length of the first list, but as described below, the length of the first list is always 1, so a constant time.

First, the worst case input Ls is considered to be as follows when the number of elements is n and the maximum nesting depth is k.
[ [...[A1]...] [...[A2]...] ... [...[An]...] ]
Here, [...[At]...] is k-1 nesting. Consider this as input.
Since we want to obtain the computational complexity of the procedure Flatten, T_Flatten(size(Ls)), here is a parameter that characterizes size(Ls) and Here, [...[At]...] is k-1 nesting. Consider this as input. do it,
size(Ls) = (n,k)
And (However, when n=0, it means nil regardless of the value of k.)
Build a recurrence formula for each case of the'case' statement.Solve this and still O(n*k).
T_Flatten((0,k)) = k1 (n = 0, k: when arbitrary)
T_Flatten((n,k)) = k2 + T_Flatten((1,k-1)) + T_Flatten((n-1,k))（n > 0, k > 0 のとき）
T_Flatten((1,0)) = k3 + T_Flatten（（0,0）） （n = 1, k = 0 のとき）
Solve this and still O(n*k).
*/

declare
fun {Flatten Xs}
   proc {FlattenD Xs ?Ds}
      case Xs
      of nil then Y in Ds=Y#Y
      [] X|Xr andthen {IsList X} then Y1 Y2 Y3 Y4 in
	 {FlattenD X Y1#Y2}
	 {FlattenD Xr Y3#Y4}
	 Y2=Y3
	 Ds=Y1#Y4
      [] X|Xr then Y1 Y2 in
	 {FlattenD Xr Y1#Y2}
	 Ds=(X|Y1)#Y2
      end
   end
   Ys
in
   {FlattenD Xs Ys#nil}
   Ys
end

/*
Details are omitted.
The only difference is that the connection is constant time, so in the worst case 1 above it will be O(n), and in case 2 it will be O(k*n).
Therefore, the worst time seems to be the same regardless of the average time.
*/
