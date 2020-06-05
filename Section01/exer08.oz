% 8. Explicit states and functions
% Problem: Since the memory cell is declared and initialized in the function, each argument is saved in another storage area. → Count is not retained

declare
local Acc in
   Acc={NewCell 0}
   fun {Accumulate N}
      Acc:=@Acc+N
      @Acc
   end
end

{Browse {Accumulate 5}}
{Browse {Accumulate 10}}
{Browse {Accumulate 34}}
