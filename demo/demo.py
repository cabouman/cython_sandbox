import numpy as np
from cython_sandbox import c_mat_mult, cython_mat_mult, cython_slow_mat_mult
import time

"""
This is a simple demo of multiplication of two matrices using 

    1. Loops in python
    2. Naively coded cython without variable types
    3. Cython with proper variable types
    4. A cython wrapper of a C subroutine
    5. Numpy

Note that all computations are done using 32-bit single precision floats.
    
The page http://nealhughes.net/cython1/ also has a nice description about how to get good performance with cython.
See also https://cython.readthedocs.io/en/latest/src/userguide/numpy_tutorial.html     
"""


def py_mat_mult(A, B):
    """
    Matrix multiplication using loops in python
    Args:
        A: Left matrix
        B: Right matrix

    Returns:
        C = A * B
    """
    # Get dimensions and check for compatibility
    n_rows = A.shape[0]
    n_cols = B.shape[1]
    n_mults = A.shape[1]
    if n_mults != B.shape[0]:
        raise AttributeError("Input matrices do not have compatible shapes.")

    # Allocate space and then loop to do the multiplication
    C = np.empty((n_rows, n_cols), dtype=np.float32)
    for i in range(n_rows):
        for j in range(n_cols):
            C[i,j] = 0
            for k in range(n_mults):
                C[i,j] += A[i,k] * B[k,j]

    return C


if __name__ == '__main__':
    # Generate random matrices A and B of compatible sizes
    n_rows = 1000
    n_mid = 500
    n_cols = 10
    A = np.random.randint(10, size=(n_rows, n_mid)).astype(np.float32)
    B = np.random.randint(10, size=(n_mid, n_cols)).astype(np.float32)

    # List of methods to compare
    methods = [py_mat_mult, cython_slow_mat_mult, cython_mat_mult, c_mat_mult, np.dot]
    method_names = ["Py loops", "Bad Cython", "Cython", "C code", "numpy"]
    # Note that cython_matrix_multiplication requires 2D np.ndarrays of floats with C contiguous format

    times = np.zeros((len(methods),))
    error = np.zeros((len(methods),))

    # Get the reference solution
    C_ref = np.dot(A,B)

    width = 10
    print("\nComparison of matrix multiplication with various methods")
    print(f"Method\t\t Time (ms)\t\tL2 diff with numpy")
    print("----------------------------------------------")

    # Loop through the methods, time each one, and find the error
    for ind, method in enumerate(methods):
        times[ind] = time.time()
        # Compute matrix multiplication
        C = method(A, B)
        times[ind] = 1000 * (time.time() - times[ind])
        error[ind] = np.sqrt(np.sum((C_ref - C) ** 2))
        print(f"{method_names[ind]:{width}}\t{times[ind]:{width}.2f}\t{error[ind]:{width}.2f}")
