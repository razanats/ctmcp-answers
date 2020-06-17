% 8. Iterative append

% "Limit to calculate only values" means "calculate only complete values".
fun {Append Xs Ys}
   fun {ReverseAppendIter Xs Ys}
      case Xs
      of nil then Ys
      [] X|Xr then {ReverseAppendIter Xr X|Ys} end
   end
   fun {Reverse Xs}
      fun {ReverseIter Xs A}
	 case Xs
	 of nil then A
	 [] X|Xr then {ReverseIter Xr X|A} end
      end
   in
      {ReverseIter Xs nil}
   end
in
   {ReverseAppendIter {Reverse Xs} Ys}
end
