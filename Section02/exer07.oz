% 7. Lexical scope closure
declare Max3 Max5
proc {SpecialMax Value ?SMax}
   fun {SMax X} 
      if X>Value then X else Value end
   end
end
{SpecialMax 3 Max3} 
{SpecialMax 5 Max5}

% The following is a little rewrite.
proc {SpecialMax Value ?SMax}
   SMax = fun {$ X} 
	     if X>Value then X else Value end
	  end
end

% The execution is as follows.
{Browse [{Max3 4} {Max5 4}]} % => [4 5]

