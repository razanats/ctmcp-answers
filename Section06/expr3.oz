% Emulate state with concurrency

declare
fun {MakeState Init}
   proc {Loop S V}
      case S of access(X)|S2 then
	 X=V
	 {Loop S2 V}
      [] assign(X)|S2 then
	 {Loop S2 X}
      else skip
      end
   end
   S
in
   thread {Loop S Init} end
   S
end

% SumList by stream container
declare
fun {SumList Xs S}
   Cs = {MakeState S}
   fun {Iter Xs Cs}
      case Xs
      of nil then C|Cr=Cs Y in
	 C=access(Y)
	 Y
      [] X|Xr then C1|C2|Cr=Cs Y  in
	 C1=access(Y)
	 C2=assign(X+Y)
	 {Iter Xr Cr}
      end
   end
in
   {Iter Xs Cs}
end

{Browse {SumList [1 2 3] 0}}

% If there is no state to keep between calls like SumList, you can use the stream container without changing the appearance by adding an accumulator internally.
% Even if you try to add SumCount, there is no accumulator between function calls, so you can only access the stream container at the time of function definition. Therefore, SumCount cannot be added without changing the appearance.
