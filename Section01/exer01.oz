% 1.Computer
%  (a)
declare V1 V2 V4 V8 V16 V32 V64
V1 = 2
V2 = V1*V1
V4 = V2*V2
V8 = V4*V4
V16 = V8*V8
V32 = V16*V16
V64 = V32*V32
V100 = V64*V32*V4 % (b) But as I said, it helps programmers exchange state between instructions.

% (b)
% There may be shortcuts, but it depends on humans partially solving (transforming) the problem.

% * Consideration: What does it mean to not define a function?
% Think according to the declarative model in Chapters 2 and 3. 
% The only statements that can be used are compound statements, variable declarations, variable bindings, and conditional branches. 
% Built-in functions are limited to numerical operations (there is no function data type).
% The fact that functions cannot be defined means that, for example, recursion cannot be used, and loops cannot be used.
% In general, without recursion, the state cannot be threaded and calculated.
% That is, each calculation is a one-time operation, and mutual exchange of states cannot be performed automatically.
% Also, the fact that a function cannot be defined means that iteration cannot be abstracted.
% That means that all calculations are written by the programmer directly 
% (in other words, unless the programmer can abstract the problem well, the effort required is unchanged.
% This problem is very easy to abstract. Because, the function easily exerts its force.)
