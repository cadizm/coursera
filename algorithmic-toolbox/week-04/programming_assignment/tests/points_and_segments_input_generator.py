
import random


s = 50000
p = 50000
leftmost = -10**8
rightmost = 10**8


def random1():
    for _ in range(s):
        a = random.randint(leftmost, rightmost)
        b = random.randint(a, rightmost)

        print a, b

    for _ in range(p):
        print random.randint(leftmost, rightmost),


def degenerate1():
    n = s
    m = p
    MAX = 10**8

    a = []
    for i in range(n):
        a.append((-MAX, MAX))

    b = [-MAX, MAX]
    for i in range(m - 2):
        b.append(random.randrange(2 * MAX + 1) - MAX)

    for foo in a:
        print foo[0], foo[1]
    for bar in b:
        print bar,


print s, p
#random1()
degenerate1()
