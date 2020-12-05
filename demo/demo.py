import numpy as np
from cython_sandbox import py_matrix_multiplication
import time

"""
This is a simple demo of multiplying two matrices using a cython wrapper to a C subrountine
"""

if __name__ == '__main__':
    # Get random matrices A and B of compatible sizes
    A = np.random.randint(10, size=(1300, 400)).astype(np.float32)
    B = np.random.randint(10, size=(400, 1500)).astype(np.float32)

    # Compute matrix multiplication using cython wrapper
    C1 = np.zeros((A.shape[0], B.shape[1])).astype(np.float32)
    time_start = time.time()
    py_matrix_multiplication(A, B, C1)
    time_end = time.time()
    print("Output from cython matrix multiplication:")
    print(C1)
    print("Cython computation time: %f sec\n" % (time_end - time_start))


    # Start a timer and compute using numpy
    time_start = time.time()
    C2 = np.dot(A, B)
    time_end = time.time()
    print("Output from numpy matrix multiplication:")
    print(C2)
    print("numpy  finished: %f sec\n" % (time_end - time_start))

    # Display the difference
    err = np.sum((C1 - C2) ** 2)
    print("\n********************** Result Conclusion **********************")
    print("L2 difference between cython and numpy.dot matrix product: %f" % err)

