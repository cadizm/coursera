#!/usr/bin/env python2

import sys


def gcd(a, b):
    return euclidean_algorithm(a, b)


def euclidean_algorithm(a, b):
    if b == 0:
        return a
    else:
        return euclidean_algorithm(b, a % b)


if __name__ == '__main__':
    a, b = [int(_) for _ in sys.stdin.readline().split()]
    print gcd(a, b)
