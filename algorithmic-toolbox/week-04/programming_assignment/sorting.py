#!/usr/bin/env python2

import sys
import random


def quicksort(a, lo, hi):
    """
    Arrays with large numbers of duplicate sort keys arise frequently
    in applications. In such applications, there is potential to reduce
    the time of the sort from linearithmic to linear.

    One straightforward idea is to partition the array into three
    parts, one each for items with keys smaller than, equal to, and larger
    than the partitioning item's key. Accomplishing this partitioning was
    a classical programming exercise popularized by E. W. Dijkstra as the
    Dutch National Flag problem, because it is like sorting an array with
    three possible key values, which might correspond to the three colors
    on the flag.

    Dijkstra's solution is based on a single left-to-right pass through
    the array that maintains a pointer lt such that a[lo..lt-1] is less
    than v, a pointer gt such that a[gt+1..hi] is greater than v, and a
    pointer i such that a[lt..i-1] are equal to v, and a[i..gt] are not
    yet examined.

    http://algs4.cs.princeton.edu/23quicksort/Quick3way.java.html
    """
    if hi <= lo:
        return

    lt = lo
    gt = hi

    v = a[lo]
    i = lo

    while i <= gt:
        if a[i] < v:
            a[lt], a[i], = a[i], a[lt]
            lt += 1
            i += 1

        elif a[i] > v:
            a[i], a[gt], = a[gt], a[i]
            gt -= 1

        else:
            i += 1

    quicksort(a, lo, lt - 1)
    quicksort(a, gt + 1, hi)


if __name__ == '__main__':
    n = int(sys.stdin.readline())
    a = [int(_) for _ in sys.stdin.readline().split()]

    quicksort(a, 0, n - 1)

    for x in a:
        print x,
