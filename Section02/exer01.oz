% 1. Free and linked variables

/*
Maybe the question sentence is "Is the variable pointed to by the second P bound?"

Consider "declare P" as a complement.
When written in a form similar to the nuclear language, it is as follows.

P = proc{$ X}
       if X>0 then {P X-1} end
    end

Let p be the variable in the storage area indicated by P, and p is a variable bound to a procedure value.

*/

/* c.f.Execution state transition
([(local P in <s> end,Φ)],Φ)
([(P=...,{P=>p})],{p})
([()],{p=(proc...,P=>p)})
*/
