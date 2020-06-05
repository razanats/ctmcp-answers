% 3. Correctness of the program

% Proof: Suppose the functions AddList, ShiftLeft, ShiftRight satisfy each operation. From the meaning of the language, the definition is satisfied when N is 1 and at other times. .. So Pascal is right.

% Proof (ShiftLeft): ShiftRight is clearly correct (in terms of language).

% Proof (ShiftRight): ShiftLeft is an operation that adds 0 to the end of the list.
% (i) Suppose the definition is satisfied for any list with N elements
% Consider the case of passing a list of N+1 elements as an argument. ShiftLeft decomposes this list into a head H and a tail T, and passes T to ShiftLeft and combines it with H. By the assumption, 0 is added to the end of T, so the definition is satisfied when the number of elements is N+1.
% (ii) List with one element
% The list is decomposed into its elements and nil. When nil is passed to ShiftLeft as an argument, it becomes 0, so when the number of elements is 1, 0 is added to the end of the list.
% From (i) and (ii), from the induction, ShiftLeft satisfies the definition.

% Proof (AddList): AddList is an operation to add the n(n=1,...,N)-th element of the list with N elements.
% (i) When the list with the number of elements N (N>=1) is correctly added, the list with the number of elements N+1 is correctly added.
% (ii) Lists [H1] and [H2] each having one element are decomposed into H1 and nil, and H2 and nil, respectively. Since AddList returns nil for two nil, the list obtained by adding n1 to the sum of H1 and H2 is returned. Therefore, when the number of elements is 1, the definition is satisfied.
% From (i)(ii) (ry
