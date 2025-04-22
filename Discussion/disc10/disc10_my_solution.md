# Discussion 10

### Question 1: Representing Expressions

Write the Scheme expression in Scheme syntax represented by each `Pair` below. Try drawing the linked list diagram too. The first one is done for you.

`>>> Pair('+', Pair(Pair('*', Pair(3, Pair(4, nil))), Pair(5, nil)))`

Answer: `(+ (* 3 4) 5)`

`>>> Pair('+', Pair(1, Pair(Pair('*', Pair(2, Pair(3, nil))), nil)))`

Answer: `(+ 1 (* 2 3))`

`>>> Pair('and', Pair(Pair('<', Pair(1, Pair(0, nil))), Pair(Pair('/', Pair(1, Pair(0, nil))), nil)))`

Answer: `(and (< 1 0) (/ 1 0))`

### Question 2: Evaluation

Which of the following are evaluated when `scheme_eval` is called on `(if (< x 0) (- x) (if (= x -2) 100 y))` in an environment in which `x` is bound to -2? (Assume `<`, `-`, and `=` have their default values.)

`if` `<` `x` `0` `-` `x`

### Question 3: Print Evaluated Expressions

Define `print_evals`, which takes a Scheme expression `expr` that contains only numbers, `+`, `*`, and parentheses. It prints all of the expressions that are evaluated during the evaluation of `expr`. They are printed in the order that they are passed to `scheme_eval`.

```python
def print_evals(expr):
        """Print the expressions that are evaluated while evaluating expr.

        expr: a Scheme expression containing only (, ), +, *, and numbers.

        >>> nested_expr = Pair('+', Pair(Pair('*', Pair(3, Pair(4, nil))), Pair(5, nil)))
        >>> print_evals(nested_expr)
        (+ (* 3 4) 5)
        +
        (* 3 4)
        *
        3
        4
        5
        >>> print_evals(Pair('*', Pair(6, Pair(7, Pair(nested_expr, Pair(8, nil))))))
        (* 6 7 (+ (* 3 4) 5) 8)
        *
        6
        7
        (+ (* 3 4) 5)
        +
        (* 3 4)
        *
        3
        4
        5
        8
        """
        if not isinstance(expr, Pair):
            "*** YOUR CODE HERE ***"
      		print(expr) 
        else:
            "*** YOUR CODE HERE ***"
            print(expr)
            while expr is not nil:
                print_evals(expr.first)
            	expr = expr.rest
```



