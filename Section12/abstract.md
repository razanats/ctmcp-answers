# Constraint programming

In relational programming in Chapter 9, we decided to use constraint programming for more practical searches. Here we see the basic idea of ​​the method.

Constraint programming itself is a set of techniques for finding a solution that satisfies some logical constraint. Constraint programming tries to solve problems wisely by avoiding brute force searches (reducing the amount of searches) as much as possible when seeking solutions. It may be implemented in the language or provided as a library. In that sense, it is a little qualitatively different from the programming paradigms that have been dealt with so far, such as declarative programming, concurrent programming, and object thinking.

## basic way of thinking

In constraint programming, the search is performed by the following strategy.

-Accumulate partial information
-Perform local deductions (making the most of them)
-If you get stuck in local deduction, do a little search (this splits the problem and gives you partial information), then do local deduction again for each

Let's see what this means with a concrete example. Note that the search is rare.

### What kind of rectangle is a rectangle composed of 24 unit squares and has a circumference of 20?

This would be the expression `x*y = 24` and `2*(x+y) = 20`. To simplify the example, we also add the expression `x≤y`. These are the constraints. As we will see next, because such constraints propagate various information, they are called "propagators".

Next, although not always necessary, information about the possible values ​​of variables (basic constraints) is given. This is largely possible and makes it easy to solve the problem. In this case, it can be easily understood as `x ∈ {0,...,9}` and `y ∈ {0,...,9}`.

These three propagators and two basic constraints are expressed as follows (in Oz, a propagator is expressed as `X*Y=:24`, and it is expressed as `X::1#9`. Can represent constraints).

S_1 :X*Y=:24 X+Y=:10 X=<:Y || X::1#9 Y::1#9

As can be seen immediately, in constraint programming, each search is performed by encapsulating it in the computational space. Above there are propagators and basic constraints on X and Y in the computational space S_1.

For example, if you check whether all the pairs of X and Y satisfy the constraint, the answer is sure (generate-and-test method), but constraint programming does not. Calculate as follows.

Propagator `X*Y=:24` and basic constraints `Y::1#9` to X are at least greater than 3 and less than 8. The same applies to Y. Therefore,

	S_1 :X*Y=:24 X+Y=:10 X=<:Y || X::3#8 Y::3#8

It's a sequel.
And (local deduction). Then from the propagator `X+Y=:10`,

	S_1 :X*Y=:24 X+Y=:10 X=<:Y || X::3#7 Y::3#7
	
It's a sequel.
Becomes Go back and start from `X*Y=:24`

	S_1 :X*Y=:24 X+Y=:10 X=<:Y || X::4#6 Y::4#6
	
It's a sequel.
Becomes No more propagators can add any more information. The search is performed here for the first time. Branch to `X=4` and `X::5#6`. A separate calculation space is prepared for each search.

	S_2 :X*Y=:24 X+Y=:10 X=<:Y || X=4 Y::4#6
	S_3 :X*Y=:24 X+Y=:10 X=<:Y || X::5#6 Y::4#6

S_2 is Y=6 due to the deduction of the propagator `X*Y=:24`. S_3 deduces `X=6 Y=4` by the propagator `X*Y=:24`, but fails because it is against another propagator `X=<:Y`. Therefore, only `X=4 Y=6` is the solution.

Looking back, it can be seen that there were only two searches done to find the solution. The execution takes place in a “computation space”, where 1) local deduction by the propagator until it stabilizes, 2) distributive and alternate phases of the search. 2) first makes two copies of the computational space and decomposes the candidate into two parts (X=4 and X::5#6 above). To write in a formal way, divide the problem `P` into `P∧C` and `P∧¬C`.

There are two parts that are abstracted here. The first is the method of dividing `P` into `P∧C` and `P∧¬C`, which is called "distribution strategy". A tree structure is created when the division method is decided, but it becomes obvious how to search it (“search strategy”). In constraint programming, distribution strategy and search strategy can be specified separately.

## Constraint-based calculation model

### Basic constraint is one of partial values

Handle basic constraints such as `X::4#6` to be consistent with previous models. To that end, we recall the concept of "partial values." A partial value is a value that is not yet bound (intuitively there is only partial information). For example, a variable that has just been declared is a partial value, and the value of X in `X=person(Y)` is a partial value that is known to have the structure person(?). Based on this, it is possible to regard `X::4#6` as a value (that is, a partial value) that has partial information that "is one of the values ​​4, 5 and 6" and to execute it correctly. It seems that a certain value is determined.

### Computational space and propagator

Searching means trying different possibilities for a variable X, such as whether it is 1 or 2. You can't do that in the declarative model, because X=1 and X=2 are executed in different places, which naturally fails. In other words, it is necessary to work under a mechanism that allows you to try the possibilities in a limited space (and not see it from the outside). That is the calculation space.

As we first saw, the computational space consists of several variables to be solved and their propagators. In the computational space, each propagator concurrently adds information to variables as threads. If it can't be deduced any more (when it reaches a stable state). , Externally returns a message such as "There are N distribution destinations" (in response to such external inquiry).

### Search strategy

The computational space does not search by itself. Perform local deduction and wait for instructions when stable state is reached. Considering the whole search as a tree, one calculation space performs calculation in one node, and returns the result such as "N child nodes have been generated" (or "results have been satisfied and the result has been obtained"). Only. This way, the search engine is freely programmable. For example, whether to perform depth-first search, breadth-first search, all solutions, or whether to finish with the first one. The search engine must also copy the calculation space when branching the search.

### Distribution strategy

Regarding the distribution strategy, for example, `{FD.distribute naive sol(XY)}` can be used to select a naive strategy for X and Y (specific programming is not explained in the book. Not in).

### Implementation of relational programming

In relational programming, I didn't talk about how the execution of the choise statement is in the computational model, but in reality the choise statement is a language abstraction using this constraint-based computational model.
