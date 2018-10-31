#!/usr/bin/env python2

import sys


def cover_segments_by_points(L):
    # sort by right endpoint ascending
    L.sort(key=lambda x:x[1])

    p = L[0][1]  # initialize to first endpoint
    P = [p]

    for a, b in L:
        if a <= p <= b:
            continue
        else:
            p = b
            P.append(p)

    return P


if __name__ == '__main__':
    n = int(sys.stdin.readline())
    L = [(int(a), int(b)) for a, b in [line.split() for line in sys.stdin]]

    P = cover_segments_by_points(L)
    print len(P)
    for p in P:
        print p,
