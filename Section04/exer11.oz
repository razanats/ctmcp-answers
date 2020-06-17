% 11. Delay and parallelism

declare
fun lazy {MakeX} {Browse x} {Delay 3000} 1 end
fun lazy {MakeY} {Browse y} {Delay 6000} 2 endThe second example, unraveling the sugar-coating syntax, shows that Z is needed immediately after thread creation.
fun lazy {MakeZ} {Browse z} {Delay 9000} 3 end
X={MakeX}
Y={MakeY}
Z={MakeZ}
{Browse thread X+Y end +Z}

% MakeX and MakeY are needed immediately, so their delays start, 6 seconds after the calculation of X+Y ends, and Z is needed, and the result comes out after 6+9=15 seconds.
% The second example, unraveling the sugar-coating syntax, shows that Z is needed immediately after thread creation.

% The fastest calculation is Thread ... Thread Thread i_1 + i_2 end + i_3 end ... + i_n end (assuming that the thread creation time is less than 1 second). Therefore, it can be programmed as follows.

{FoldL Ls fun{$ X Y} thread X+Y end end 0}
