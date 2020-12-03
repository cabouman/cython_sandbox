# -*- coding: utf-8 -*-
# Copyright (C) by Wenrui Li <buzzard@purdue.edu>
# All rights reserved.

import numpy as np
from cython_sandbox import py_matrix_multiplication
import time

"""
This is a simple demo designed to compare matrix multiplication using cython and using numpy.
"""

if __name__ == '__main__':
    # Get random matrices A and B of compatible sizes
    A = np.random.randint(10, size=(300, 400)).astype(np.float)
    B = np.random.randint(10, size=(400, 500)).astype(np.float)

    # Start a timer and compute using cython
    C1 = np.zeros((A.shape[0], B.shape[1]))
    t0 = time.time()
    C1 = py_matrix_multiplication(A, B)
    t1 = time.time()
    print("Output from cython:\n")
    print(C1)
    print("cython finished : %f s" % (t1 - t0))

    # Start a timer and compute using numpy
    t2 = time.time()
    C2 = np.dot(A, B)
    t3 = time.time()
    print("Output from numpy:\n")
    print(C2)
    print("numpy  finished : %f s" % (t3 - t2))

    # Display the difference
    err = np.sum((C2 - C1) ** 2)
    print("\nL2 difference : %f" % err)
    print("\nCython time:\t %f s" % (t1 - t0))
    print("Numpy time:\t\t %f s" % (t3 - t2))
