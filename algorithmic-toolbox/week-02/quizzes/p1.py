
import math
import pprint
import sys
import types


def f1(n):
    return n**3.0

def f2(n):
    return n**(0.3)

def f3(n):
    return float(n)

def f4(n):
    return math.sqrt(n)

def f5(n):
    return n**2.0 / math.sqrt(n)

def f6(n):
    return n**2.0


if __name__ == '__main__':
    L = [10**i for i in range(6)]
    F = filter(lambda x: type(x) == types.FunctionType, locals().values())

    d = {}
    for f in F:
        prev = 0
        for i, e in enumerate(L):
            try:
                cur = f(e)
            except OverflowError:
                cur = sys.maxsize

            if cur < prev:
                break  # decreasing growth rate
            if i == len(L) - 1:
                d[f.func_name] = cur

    # pretty print key/val tuples sorted by value
    S = sorted(d.items(), key=lambda x:x[1])
    pprint.pprint(S)

    # just the function names
    print [e[0] for e in S]
