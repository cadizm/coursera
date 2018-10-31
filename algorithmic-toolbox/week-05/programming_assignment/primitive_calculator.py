#!/usr/bin/env python2

"""
Problem Introduction

You are given a primitive calculator that can perform the following three
operations with the current number x: multiply x by 2, multiply x by 3, or
add 1 to x. Your goal is given a positive integer n, find the minimum number
of operations needed to obtain the number n starting from the number 1.
"""

import sys


def min_operations(n, ops):
    """
    Given an integer n and operations ops, compute the minimum number of
    operations needed to obtain the number n starting from the number 1.
    """
    table = {1: 0}  # map n to min number of operations
    links = {1: None}  # map n to prev value before applying min operation

    for i in range(2, n + 1):
        table[i] = sys.maxint

        for op in ops:
            res = op(i)

            if res is None:
                continue

            cur = table[res] + 1

            if cur < table[i]:
                table[i] = cur
                links[i] = res

    return table, links


if __name__ == '__main__':
    n = int(sys.stdin.readline())

    ops = [
        lambda x: x - 1,
        lambda x: x / 2 if x % 2 == 0 else None,
        lambda x: x / 3 if x % 3 == 0 else None,
    ]

    table, links = min_operations(n, ops)

    m = table[n]

    key, L = n, []
    for i in range(m + 1):
        L.insert(0, key)  # build reverse list
        key = links[key]

    print m
    for e in L:
        print e,
