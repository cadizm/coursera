#!/usr/bin/env ruby

# Problem. Given two digits a and b, find a+b.
#
# Input format. The first line of the input contains two integers a and b
# (separated by a space).
#
# Constraints. 0 <= a,b <= 9.
#
# Output format. Output a+b.
#
# Sample 1
# Input:
# 3 2
# Output:
# 5
#
# Sample 2
# Input:
# 7 9
# Output:
# 16

a, b = ARGF.gets.split.map { |x| x.to_i }
puts a + b
