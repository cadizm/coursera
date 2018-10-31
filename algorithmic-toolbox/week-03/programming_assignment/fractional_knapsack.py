#!/usr/bin/env python2

from __future__ import division
import sys


def fractional_knapsack(W, L):
    # sort by decreasing v/w
    L.sort(key=lambda x: x[0] / x[1], reverse=True)

    V = 0
    A = []

    for v, w in L:
        if not W:
            break

        a = min(w, W)
        V += a * (v / w)
        A.append(a)

        w -= a
        W -= a

    return (V, A)


if __name__ == '__main__':
    n, W = [int(_) for _ in sys.stdin.readline().split()]
    L = [(int(v), int(w)) for v, w in [line.split() for line in sys.stdin]]

    print "%.4f" % fractional_knapsack(W, L)[0]
