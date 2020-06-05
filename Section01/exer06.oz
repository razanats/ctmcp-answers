% 6. Higher-order programming
% (a)
declare Add Subtract Multiply Mull
fun {Add X Y}
   X+Y
end
fun {Subtract X Y}
   X-Y
end
fun {Multiply X Y}
   X*Y
end
fun {Mull X Y}
   (X+1)*(Y+1)
end

declare GenericPascalList
fun {GenericPascalList Op N}
   if N==1 then [1]
   else {GenericPascal Op N}|{GenericPascalList Op N-1} end
end

{Browse {GenericPascalList Add 7}}
{Browse {GenericPascalList Subtract 7}} % Alternating minus
{Browse {GenericPascalList Multiply 7}} % All after the second line is 0
{Browse {GenericPascalList Mull 7}} % The more the center, the greater the increase

{Browse {GenericPascal Mull 10}}

% (b) Introduction of loop command
for I in
   1..10 do {Browse {GenericPascal Add I}}
end
% Lesson learned: loops are recursive and can be substituted
