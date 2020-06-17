% 10. Checking if something is a list

fun {Leaf X} X\=(_|_) end
% This can be rewritten as:
fun {Leaf X} if X==(_|_) then false else true end end

% Bad to block. The case statements need only have the same structure, but in the inclusion check, comparison with an undefined value causes a block.
