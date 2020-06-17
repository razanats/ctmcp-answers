% 4. if and case statements
% (a) Definition of if statement by case statement
% if X：if <x> then <s>1 else <s>2

if X then <s>1 else <s>2 end ::=

case X
of true then
   <s>1
[] else
   <s>2
end

/* If you think of it as a language abstract, it is correct to add an exception handling clause as a 'else' clause.*/
   

% (b) Definition of case statement by if statement

case <x> of <label>(<feat>1:<x>1 ... <feat>n:<x>n) then <s>1 else <s>2 end ::=

if {Label <x>}==<label> then
   if {Arity <x>}==[<feat>1 ... <feat>n] then
      local <x>1=<x>.<feat>1 ... <x>n=<x>.<feat>n in
	 <s>1
      end
   else <s>2 end
else <s>2 end

% Action not confirmed
