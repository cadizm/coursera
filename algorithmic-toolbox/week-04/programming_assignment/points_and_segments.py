#!/usr/bin/env python2

from collections import defaultdict
import sys


def num_segments(S, P):
    """
    Return the number of segments in S that contain the points in P
    """
    D = defaultdict(list)
    for i, p in enumerate(P):
        D[p].append(i)

    L = [(p, 'p') for p in P]
    res = [0 for _ in range(len(P))]

    for a, b in S:
        L.append((a, 'l'))
        L.append((b, 'r'))

    L.sort(cmp=stab_sort)

    stack = []
    for point, label in L:
        if label == 'l':
            stack.append(point)

        elif label == 'r':
            stack.pop()

        else:
            indices = D[point]
            for i in indices:
                res[i] = len(stack)

    return res


def stab_sort(x, y):
    a, b = x[0], y[0]

    if a == b:
        a, b = x[1], y[1]

    return cmp(a, b)


if __name__ == '__main__':
    s, p = [int(_) for _ in sys.stdin.readline().split()]
    S = [(int(a), int(b)) for a, b in [sys.stdin.readline().split() for _ in range(s)]]
    P = [int(_) for _ in sys.stdin.readline().split()]

    for i in num_segments(S, P):
        print i,
