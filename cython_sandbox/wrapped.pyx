import numpy as np
import ctypes           # Import python package required to use cython
cimport cython          # Import cython package
cimport numpy as np     # Import specialized cython support for numpy

# This imports functions and data types from the matrices.pxd file in the same directory
from matrices cimport Amatrix_float, matrix_multiplication


@cython.boundscheck(False)      # Deactivate bounds checking to increase speed
@cython.wraparound(False)       # Deactivate negative indexing to increase speed

def py_matrix_multiplication(float[:,:] py_a, float[:,:] py_b):
    """
    Multiply two single precision float matrices together

    Args:
        py_a(float): 2D numpy float array with C continuous order, the left matrix A.
        py_b(float): 2D numpy float array with C continuous order, the right matrix B.

    Return:
        py_c: 2D numpy float array that is the product of A and B.
    """

    # Get shapes of A and B
    nrows_a, ncols_a = np.shape(py_a)
    nrows_b, ncols_b = np.shape(py_b)

    # Set output matrix shape
    nrows_c = nrows_a
    ncols_c = ncols_b

    # Allocates memory, without initialization, for matrix to be passed back from C subroutine
    cdef np.ndarray[float, ndim=2, mode="c"] py_c = np.empty((nrows_a,ncols_b), dtype=ctypes.c_float)

    # Declare and initialize 3 A matrix
    cdef Amatrix_float A
    A.mat_pt = &py_a[0, 0]
    A.NRows = nrows_a
    A.NCols = ncols_a

    cdef Amatrix_float B
    B.mat_pt = &py_b[0, 0]
    B.NRows = nrows_b
    B.NCols = ncols_b

    cdef Amatrix_float C
    C.mat_pt = &py_c[0, 0]
    C.NRows = nrows_c
    C.NCols = ncols_c

    # Multiply matrices together using cython subroutine
    matrix_multiplication(&A, &B, &C)

    return py_c
