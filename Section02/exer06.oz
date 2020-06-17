% 6. Case sentence revisited

declare
proc {Test X}
   case X of f(a Y c) then {Browse 'case'(1)}
   else {Browse'case'(2)} end
end

declare X Y {Test f(X b Y)} % f(x1 b y1) f(a Y2 c) ?  x1 == a && y1 ==c ?  => block
declare X Y {Test f(a Y d)} % f(a Y1 d)  f(a Y2 c) ?  a  == a && d == c ?  => 'case'(2)
declare X Y {Test f(X Y d)} % f(x1 y1 d) f(a Y2 c) ?  x1 == a && c == d ?  => 'case'(2)ではなくblock

/* About the third: In the case of inclusive check and rebuttal check, if there is an unbound variable, skip it for the time being and check the next (below). Seems to block) */
/* declare X Y The idea is that the decomposition target given by the'case' statement is supposed to be in a deterministic state, and it is a feeling to check if it is compatible with it. */
{Browse f(X Y a) == f(c d b)} % => false

/* The idea is that the decomposition target given by the'case' statement is supposed to be in a deterministic state, and it is a feeling to check if it is compatible with it. */

declare X Y
if f(X Y d) == f(a Y c) then {Browse 'case'(1)}
else {Browse 'case'(2)} end % => 'case'(2)
