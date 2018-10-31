#!/usr/bin/env python2

import sys


def knapsack_no_repetitions(v, w, n, W):
    """
    0/1 knapsack problem

    https://en.wikipedia.org/wiki/Knapsack_problem#0.2F1_knapsack_problem
    """
    table = [[0 for _ in range(W + 1)] for _ in range(n + 1)]

    for i in range(1, n + 1):
        for j in range(W + 1):
            if w[i - 1] > j:
                table[i][j] = table[i - 1][j]
            else:
                table[i][j] = max(table[i - 1][j],
                                  table[i - 1][j - w[i - 1]] + v[i - 1])

#    _pprint(table)
    return table[-1][-1]


def _pprint(table):
    for row in table:
        for e in row:
            print "%2s" % e,
        print


if __name__ == '__main__':
    W, n = [int(_) for _ in sys.stdin.readline().split()]
    w = [int(_) for _ in sys.stdin.readline().split()]
    v = [w[i] for i in range(len(w))]

    print knapsack_no_repetitions(v, w, n, W)
