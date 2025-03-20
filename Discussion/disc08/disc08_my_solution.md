# Discussion 8

#### Question 1: Strange Loop

Implement `strange_loop`, which takes no arguments and returns a `Link` object `s` for which `s.rest.first.rest` is `s`.

```python
def strange_loop():
    """Return a Link s for which s.rest.first.rest is s.
	>>> s = strange_loop()
	>>> s.rest.first.rest is s
	True		
	"""
	"*** YOUR CODE HERE ***"
    s = Link(1, Link(Link(2)))
    s.rest.first.rest = s
    return s
```

#### Question 2: Sum Two Ways

Implement both `sum_rec` and `sum_iter`. Each one takes a linked list of numbers `s` and returns the sum of its elements. Use recursion to implement `sum_rec`. Don't use recursion to implement `sum_iter`; use a `while` loop instead.

```python
def sum_rec(s, k):
    """Return the sum of the first k elements in s.

    >>> a = Link(1, Link(6, Link(8)))
    >>> sum_rec(a, 2)
    7
    >>> sum_rec(a, 5)
    15
    >>> sum_rec(Link.empty, 1)
    0
    """
    # Use a recursive call to sum_rec; don't call sum_iter
    "*** YOUR CODE HERE ***"
	if k == 0:
        return 0
    if s == Link.empty:
        return 0
    else:
        return s.first + sum_rec(s.rest, k-1)
    
def sum_iter(s, k):
    """Return the sum of the first k elements in s.

    >>> a = Link(1, Link(6, Link(8)))
    >>> sum_iter(a, 2)
    7
    >>> sum_iter(a, 5)
    15
    >>> sum_iter(Link.empty, 1)
    0
    """
    # Don't call sum_rec or sum_iter
    "*** YOUR CODE HERE ***"
    sum_i = 0
    for i in range(k):
        sum_i += s.first
        s = s.rest
    return sum_i
```

#### Question 3: Overlap

Implement `overlap`, which takes two linked lists of numbers called `s` and `t` that are sorted in increasing order and have no repeated elements within each list. It returns the count of how many numbers appear in both lists.

```python
def overlap(s, t):
    """For increasing s and t, count the numbers that appear in both.

    >>> a = Link(3, Link(4, Link(6, Link(7, Link(9, Link(10))))))
    >>> b = Link(1, Link(3, Link(5, Link(7, Link(8)))))
    >>> overlap(a, b)  # 3 and 7
    2
    >>> overlap(a.rest, b)  # just 7
    1
    >>> overlap(Link(0, a), Link(0, b))
    3
    """
    "*** YOUR CODE HERE ***"
    if s == Link.empty or t == Link.empty:
        return 0
    if s.first < t.first:
        return overlap(s.rest, t)
    else if s.first == t.first:
        return 1 + overlap(s.rest, t.rest)
    else:
		return overlap(s, t.rest)
```

#### Question 4: Overlap Growth

The alternative implementation of `overlap` below does not assume that `s` and `t` are sorted in increasing order. What is the order of growth of its run time in terms of the length of `s` and `t`, assuming they have the same length? Choose among: *constant*, *logarithmic*, *linear*, *quadratic*, or *exponential*.

`quodratic`

```python
def length(s):
    if s is Link.empty:
        return 0
    else:
        return 1 + length(s.rest)

def filter_link(f, s):
    if s is Link.empty:
        return s
    else:
        frest = filter_link(f, s.rest)
        if f(s.first):
            return Link(s.first, frest)
        else:
            return frest

def contained_in(s):
    def f(s, x):
        if s is Link.empty:
            return False
        else:
            return s.first == x or f(s.rest, x)
    return lambda x: f(s, x)

def overlap(s, t):
    """For s and t with no repeats, count the numbers that appear in both.

    >>> a = Link(3, Link(4, Link(6, Link(7, Link(9, Link(10))))))
    >>> b = Link(1, Link(3, Link(5, Link(7, Link(8, Link(12))))))
    >>> overlap(a, b)  # 3 and 7
    2
    >>> overlap(a.rest, b.rest)  # just 7
    1
    >>> overlap(Link(0, a), Link(0, b))
    3
    """
    return length(filter_link(contained_in(t), s))
```

#### Question 5: Decimal Expansion

**Definition.** The *decimal expansion* of a fraction `n/d` with `n < d` is an infinite sequence of digits starting with the 0 before the decimal point and followed by digits that represent the tenths, hundredths, and thousands place (and so on) of the number `n/d`. `E.g. the decimal expansion of 2/3 is a zero followed by an infinite sequence of 6's: 0.6666666....`

Implement `divide`, which takes positive integers `n` and `d` with `n < d`. It returns a linked list with a cycle containing the digits of the infinite decimal expansion of `n/d`. The provided `display` function prints the first `k` digits after the decimal point.

```python
def divide(n, d):
    """Return a linked list with a cycle containing the digits of n/d.

    >>> display(divide(5, 6))
    0.8333333333...
    >>> display(divide(2, 7))
    0.2857142857...
    >>> display(divide(1, 2500))
    0.0004000000...
    >>> display(divide(3, 11))
    0.2727272727...
    >>> display(divide(3, 99))
    0.0303030303...
    >>> display(divide(2, 31), 50)
    0.06451612903225806451612903225806451612903225806451...
    """
    assert n > 0 and n < d
    result = Link(0)  # The zero before the decimal point
    "*** YOUR CODE HERE ***"
    cache = {}
    tail = result
    while n not in cache:
        q, r = 10 * n // d, 10 * n % d
        tail.rest = Link(q)
        tail = tail.rest
        cache[n] = tail
        n = r
    tail.rest = cache[n]
    return result

    def display(s, k=10):
    """Print the first k digits of infinite linked list s as a decimal.

    >>> s = Link(0, Link(8, Link(3)))
    >>> s.rest.rest.rest = s.rest.rest
    >>> display(s)
    0.8333333333...
    """
    assert s.first == 0, f'{s.first} is not 0'
    digits = f'{s.first}.'
    s = s.rest
    for _ in range(k):
        assert s.first >= 0 and s.first < 10, f'{s.first} is not a digit'
        digits += str(s.first)
        s = s.rest
    print(digits + '...')

```



