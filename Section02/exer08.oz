% 8. Control abstraction
% (a)
<expression>1 andthen <expression>2 ::= if <expression>1 then <expression>2 else false end
% Produces the same result. ({BP2} is not called when {BP1} is false)

% (b)
<expression>2 orelse <expression>2 ::= if <expression>1 then true else <expression>2 end

fun {OrElse BP1 BP2}
   if {BP1} then true else {BP2} end
end
