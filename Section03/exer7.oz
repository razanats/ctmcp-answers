% 7. Another append function
fun {CorrectAppend Ls Ms}
   case Ls
   of nil then Ms
   [] L|Lr then L|{Append Lr Ms}
   end
end

fun {Append Ls Ms}
   case Ms
   of nil then Ls
   [] X|Mr then {Append {Append Ls [X]} Mr}
   end
end

% Focusing on the inner recursive call, it does not terminate because the second argument never becomes nil.
