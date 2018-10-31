#!/usr/bin/env python2

import sys


def change(m):
    D = [1, 5, 10]
    d = D.pop()
    i = 0

    while m:
        if d > m:
            d = D.pop()
        else:
            m -= d
            i += 1

    return i


if __name__ == '__main__':
    m = int(sys.stdin.readline())

    print change(m)
