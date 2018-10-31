#!/usr/bin/env python2

import sys


def distinct_summands(n):
    k = n
    l = 1
    L = []

    while k > 2 * l:
        L.append(l)
        k -= l
        l += 1

    L.append(k)

    return L


def _distinct_summands(k, l=1):
    if k <= 2 * l:
        print k
    else:
        print l
        return _distinct_summands(k - l, l + 1)


if __name__ == '__main__':
    n = int(sys.stdin.readline())

    L = distinct_summands(n)
    print len(L)
    for e in L:
        print e,
