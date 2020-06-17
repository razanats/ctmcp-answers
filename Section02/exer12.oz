% 12. Exception with finally clause
% There are two requirements: executing <s>1 and then executing <s>2, and if an exception occurs, ensure that the exception is communicated to the outside. Therefore,

% If you can use variable variables, it looks like this.
try <s>1 finally <s>2 end ::=

local Boolean = {NewCell false} E in
   try
      <s>1
   catch X then
      E = X
      Boolean := true
   end
   <s>2
   if Boolean then raise E end end
end

% I used a cell. I want IsBound to see if I'm bound.

