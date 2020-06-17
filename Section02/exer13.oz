% 13. Unification
declare X Y Z W
X = [a Z]
Y = [W b]
X = Y
{Browse X#Y#Z#W}

/* x = ['a' z], y = [w 'b'], x = y
Obviously, if you think of as a simultaneous equation containing a vector, you can get the same solution no matter how you solve it.*/

/* Note: The fact that the results are the same regardless of the order of unification probably means that the same result can be obtained by solving a system of equations in any order (procedure). , It is premised on the reference transparency that "equals are replaced by equals". From this, it can be seen that a single substitution variable (not a variable variable) is necessary for order independence.*/
