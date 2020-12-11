import numpy as np
from cython_sandbox import cython_matrix_multiplication

"""
This is a simple demo of how to multiply two matrices using a cython wrapper of a C subrountine
"""

if __name__ == '__main__':
    # Generate random matrices A and B of compatible sizes
    A = np.random.randint(10, size=(1000, 500)).astype(np.float32)
    B = np.random.randint(10, size=(500, 10)).astype(np.float32)

    # Insure that both A and B have C contiguous format; This will cause arrays to be copied if they do not.
    A = np.ascontiguousarray(A)             # Ensures C contiguous format
    B = np.ascontiguousarray(B)             # Ensures C contiguous format

    # Compute matrix multiplication using cython wrapper
    C1 = cython_matrix_multiplication(A, B)     # Requires that 2D np.ndarrays that are floats with C contiguous format
    print("Output from cython matrix multiplication:")
    print(C1)

    # Compute matrix multiplication using numpy
    C2 = np.dot(A, B)
    print("Output from numpy matrix multiplication:")
    print(C2)

    # Print error
    err = np.sum((C1 - C2) ** 2)
    print("L2 difference between cython and numpy.dot matrix product: %f" % err)
