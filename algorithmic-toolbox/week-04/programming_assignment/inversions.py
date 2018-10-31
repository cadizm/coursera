#!/usr/bin/env python2

import sys


def sort_and_count(L):
    """
    http://www.cs.colostate.edu/~cs320/Slides/05_inv.pdf
    """
    if len(L) == 1:
        return 0, L

    low = 0
    high = len(L)
    mid = low + ((high - low) / 2)

    a, A = sort_and_count(L[:mid])
    b, B = sort_and_count(L[mid:])

    c, C = merge_and_count(A, B)

    return a + b + c, C


def merge_and_count(A, B):
    count = 0
    res = []

    while A and B:
        if A[0] <= B[0]:  # break ties
            res.append(A.pop(0))

        elif B[0] < A[0]:
            res.append(B.pop(0))
            count += len(A)  # B[0] > remaining A

        if A and not B:
            res.extend(A)
            A = None

        elif B and not A:
            res.extend(B)
            B = None

    return count, res


if __name__ == '__main__':
    n = int(sys.stdin.readline())
    L = [int(_) for _ in sys.stdin.readline().split()]

    m, M = sort_and_count(L)

    print m
