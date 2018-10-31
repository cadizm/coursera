#!/usr/bin/env python

import random
import sys


max_num_elements = 10**5
max_element_size = 10**9

print max_num_elements
for i in range(max_num_elements):
    print random.randint(max_element_size - 10, max_element_size),
