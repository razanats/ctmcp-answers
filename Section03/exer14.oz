% 14. FIFO queue
declare
fun {NewQueue} X in q(0 X X) end
fun {Insert Q X}
   case Q of q(N S E) then E1 in
      E=X|E1
      q(N+1 S E1)When such an operation is added to the empty difference list, the next insertion operation becomes as follows. To the end, unify with X1|X=X2|E using the value X2 to be inserted and the unbound variable E.
   end
end
fun {Delete Q X}
   case Q of q(N S E) then
      q(N-1 S.2 E)
   end
end
fun {IsEmpty Q} case Q of q(N S E) then N==0 end end

% (a)
/*
The difference list is from X#X to X#(X1|X). Here, X1 is unbound.
When such an operation is added to the empty difference list, the next insertion operation becomes as follows. To the end, unify with X1|X=X2|E using the value X2 to be inserted and the unbound variable E.この結果、Eには、X1|Xではなく、Xが束縛される。X1がキャンセラーの役目を果たし、挿入と同時に削除されたかのように振舞う。
*/

% (b)
% When it is not empty, for example, in (X1|E)#E, I want X1|E==E to be false, but since it may be equal, it blocks.
