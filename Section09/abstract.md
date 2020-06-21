#Relationship programming
Part I: The final chapter of the general computational model. In this chapter, we generalize the view of declarative model functions (Chapter 1 to Chapter 4 etc.) that we have dealt with so far and consider a computational model based on relationships.

## Programing in relation
Think from a programmer's perspective. Add the following sentence to the nuclear language.

	choise <s1> [] ... [] <sn> end % Choise
	fail % failure

The choise statement selects and executes one of the statements `<s1>`...`<sn>`. If there is a failure such as `1=2` in the execution, select another statement `<si>` again. With such a statement, for example, the following function can be written.

	fun {PrimaryColors} 
	  choice red [] blue [] green end 
	end

This can be interpreted as "the value of the call `{PrimaryColors}` is `red` or `blue` or `green`". See PrimaryColors as "relationships" rather than "functions". In addition, such a property is called "non-deterministic" in contrast to the function in the declarative model that returned a fixed value. With such nondeterministic choices, the program can be written like a logical assertion. For example,

    fun {TwoPrimaryColors} X Y in
  	  X = {PrimaryColors}
	  Y = {PrimaryColors}
	  (X\=Y) = true
	  X#Y
	end

Can mean "X is a primary color, Y is also a primary color, and X and Y are different", and returns a solution like `red#blue`. Assuming the implementation is a depth-first search, the execution would be:

1. Red is bound to X (selection)
2. red is bound to Y (selection)
3. It becomes false at X\=Y and false=true is executed (failure)
4. Since it failed, Y is selected again and blue is bound to Y (selection)
5. X\=Y will be true, so it will not fail and red#blue will be returned as X#Y

As can be seen, executing a program on a relation is actually performing a search. Obviously, the calculation amount becomes exponential. It is generally unavoidable. This makes it practical when the search space is small or used as a research tool to investigate the structure of the problem, and requires more elaborate techniques to apply otherwise. Chapter 2: Constraint programming). For the moment, this chapter considers only practical cases.

## Relationship with logic programming
Declarative programming and relational programming are closely related to logical programming. A logical program is a "statement of logic given an operational meaning (that is, executable)". Logical programs have both operational and logical meanings. The basis of this logical meaning is first-order predicate logic (propositional logic plus variables, terms, and qualifiers). Deduction becomes possible by giving a set of axioms to the first-order predicate logic.

### Logical programming
The logic type program consists of a set of axioms of first-order predicate logic, a query, and a "theorem prover" which is a system for performing deduction. In executing a logic program, it is necessary to consider the following.

-Theoretical limit that the proof may not exist in the logical model even if it is true (incompleteness theorem)
-Meet the practical demands that programmers can define algorithms and predict computational complexity
-Need to be constructive (when true, can give concrete examples)

There are two ways of thinking about these things.

-Enable efficient theorem prover by limiting the form
  -Prolog limits axioms to Horn clauses (`∀x1,...,xn. <a1>∧...∧<an> → <a>`), and derives resolution as an inference rule. use
-Allow programmers to use practical knowledge to help theorem provers
  -For example, it is possible to write a logical program that sorts, but it is inefficient. Enable merge sort for such parts. The logical meaning does not change.

### Logical and operational meaning
Any statement `<s>` in the related program can be easily translated into a logical expression `T(<s>)`. For example, `if X then <s1> else <s2> end` is `x=true ∧ T(<s1>) ∨ x=false ∧ T<s2>`.

Write a list concatenation (Append) and think about program execution in terms of both operational and logical meanings.

#### Deterministic consolidation
Below is the Append function written in the declarative model.

	fun {Append A B}
	  case A
	  of nil then B
	  [] X|As then X|{Append As B}
	end

The procedure is written as follows.

	proc {Append A B C}
	  case A
	  of nil then C=B
	  [] X|As then C=X|{Append As B}
	end

This logical meaning is translated as `∀a,b,c. append(a,b,c) ⇔ (a=nil ∧ c=b) ∨ (∃x,a',b'. a=x|a '∧ c=x|c' ∧ append(a',b,c'))`. This is done logically by deducing `append([1,2,3],[4,5],x)` to `append([1,2,3],[4,5],[ 1,2,3,4,5])`.

Let's think a little more. In a logical sense, `append(a,b,c)` says that (a,b,c) is a concatenation, so `append(x,[4,5], It is expected that [1,2,3,4,5])` will be deduced into `append([1,2],[4,5],[1,2,3,4,5])`. However, the above function does not. This is because the argument A is supposed to be bound and blocks (in `case A` part). The declarative model Append is directional (from input to output) and cannot be deduced without it. Even so, it keeps its logical meaning when the execution ends properly without infinite recursion, block, or exception.

#### Non-deterministic consolidation
To satisfy the logical meaning of the Append function above, this time we write the Append function using the choise statement and it becomes as follows.

	proc {Append ?A ?B ?C}
	  choise 
	    A=nil B=C
	  [] As Cs X in
	    A=X|As C=X|Cs {Append As B Cs}
	  end
	end

This is because, for example, in a call `{Append XY [1 2 3]}` in which two arguments are not determined, `X#Y` is `nil#[1 2 3]` or `[1]#[2 3 ]` is returned. It even returns a solution to a call that has no fixed arguments (although such solutions are infinite, so you can't list them all).

#### Deterministic and non-deterministic concatenation, or functional and relational procedures
The following is a summary of what can be understood from the above examples. Unlike non-deterministic concatenation, deterministic concatenation has directionality, so even if you try to output what was supposed as input, it is not deduced. Non-determinism is not. That is, non-deterministic procedures can make calculations based on partial information. And, unlike deterministic connection (functional procedure), non-deterministic connection (relational procedure) determines whether a certain argument is input or output at each call. However, behind this flexibility is the possibility of falling into an exponential search or an infinite loop.

Non-deterministic procedures should be used only when absolutely necessary (this is Oz's position to syntactically distinguish between deterministic and non-deterministic operations, pure Prolog does not distinguish between them).

#### Logical programming in other models
The serial declarative model of Chapters 1 to 3 and the model of Chapter 4 in which the parallel declarative model is used as it is can perform logical programming as already described. Although the message transfer concurrency model using ports in Chapter 5 is non-deterministic, it can be expressed by extending the declarative model by adding the `WaitTwo` operation (for example, the message A or B comes non-deterministically). Is `Z = {WaitTwo AB}` and its logical meaning is `z=a ∨ z=b`). Apart from the stateful model in Chapters 6-8, there is no easy way to give it a logical meaning. The constraint-based computational model in Chapter 12 is the most powerful model in this book as a model for logical programming.

## Useful examples of relational programming
Relational programming (or constraint programming) is suitable for parsing ambiguous grammars such as natural language. Tools such as lec/yacc can also analyze grammars that are difficult to parse. In this chapter, we will see an example of a simple grammar and S-expression acceptance and conversion into a tree structure, and a grammar interpreter that abstracts it.
