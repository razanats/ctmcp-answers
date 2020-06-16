% 3. Functions and procedures
/* Due to the syntax, the end of the function must end with an expression. In this case,'if-then-else' is the expression. The parser does not throw an error if you do not write an'else' clause in the expression'if-then-else'. 'else' is (probably) interpreted as not domain (and therefore not executed). That is, since the else clause is not expected, it is correct to raise an exception if that happens. */

declare
fun {Test X}
   if X then 1 end
end

try
   {Browse {Test false}}
catch X then
   {Browse X}
end


% In the same way, the compiler will pass the code and an exception will occur during execution.
declare Y
Y = if false then 1 end
% これは通る。
Y = if true then 1 end


% The procedure is as follows. Obviously, no exception occurs.
declare
proc {Test X ?Y}
   if X then Y = X end
end
