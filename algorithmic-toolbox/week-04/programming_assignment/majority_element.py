#!/usr/bin/env python2

from collections import defaultdict
import sys


def majority_element(L):
    return 1 if _majority_element(L) else 0


def _majority_element(L):
    def _frequency(L, x):
        count = 0
        for e in L:
            if e == x:
                count += 1
        return count

    n = len(L)

    if n == 1:
        return L[0]

    k = n / 2

    left = L[:k]
    right = L[k:]

    a = _majority_element(left)
    b = _majority_element(right)

    p = _frequency(L, a)
    q = _frequency(L, b)

    if p > k:
        return a

    elif q > k:
        return b

    return None


def dict_majority_element(L):
    D = defaultdict(int)

    for e in L:
        D[e] += 1

    return 1 if max(D.values()) > len(L) / 2 else 0


if __name__ == '__main__':
    n = int(sys.stdin.readline())
    L = [int(_) for _ in sys.stdin.readline().split()]

    print majority_element(L)
