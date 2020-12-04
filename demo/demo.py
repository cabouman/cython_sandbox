# -*- coding: utf-8 -*-
# Copyright (C) by Wenrui Li <buzzard@purdue.edu>
# All rights reserved.

import numpy as np
from cython_sandbox import py_matrix_multiplication,py_matrix_multiplication2
import time

"""
This is a simple demo designed to compare matrix multiplication using cython and using numpy.
"""

if __name__ == '__main__':
    # Get random matrices A and B of compatible sizes
    A = np.random.randint(10, size=(1300, 400)).astype(np.float32)
    B = np.random.randint(10, size=(400, 1500)).astype(np.float32)

    # Start a timer and compute using cython
    print("Cython method 1")
    C1 = np.zeros((A.shape[0], B.shape[1]))
    t1_start = time.time()
    C1 = py_matrix_multiplication(A, B)
    t1_end = time.time()
    print("Output from cython method 1:")
    print(C1)
    print("cython finished time: %f s\n" % (t1_end - t1_start))

    # Start a timer and compute using cython
    print("Cython method 2")
    C2 = np.zeros((A.shape[0], B.shape[1])).astype(np.float32)
    t2_start = time.time()
    py_matrix_multiplication2(A, B, C2)
    t2_end = time.time()
    print("Output from cython method 2:")
    print(C2)
    print("cython finished time: %f s\n" % (t2_end - t2_start))


    # Start a timer and compute using numpy
    t3_start = time.time()
    C3 = np.dot(A, B)
    t3_end = time.time()
    print("Output from numpy:")
    print(C3)
    print("numpy  finished: %f s\n" % (t3_end - t3_start))

    # Display the difference
    err1 = np.sum((C3 - C1) ** 2)
    err2 = np.sum((C3 - C2) ** 2)
    print("\n********************** Result Conclusion **********************")
    print("L2 difference between cython method 1 and numpy.dot: %f" % err1)
    print("Cython method 1 time:\t %f s" % (t1_end - t1_start))
    print("\nL2 difference between cython method 2 and numpy.dot: %f" % err2)
    print("Cython method 2 time:\t %f s" % (t2_end - t2_start))
    print("\nNumpy time:\t\t %f s" % (t3_end - t3_start))
