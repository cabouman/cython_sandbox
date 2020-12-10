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
        py_a(float): 2D numpy array, the left matrix A.
        py_b(float): 2D numpy array, the right matrix B.

    """

    # Get shapes of A and B
    nrows_a, ncols_a = np.shape(py_a)
    nrows_b, ncols_b = np.shape(py_b)

    # Allocate memory for output matrix
    nrows_c, ncols_c = nrows_a, ncols_b

    # Copy pointers to python variables to the cython variables
    # The np.ascontiguousarray insures that data conforms to a row major (i.e., C) standard
    # see: https://stackoverflow.com/questions/26998223/what-is-the-difference-between-contiguous-and-non-contiguous-arrays
    cdef np.ndarray[float, ndim=2, mode="c"] temp_a = np.ascontiguousarray(py_a, dtype = ctypes.c_float)
    cdef np.ndarray[float, ndim=2, mode="c"] temp_b = np.ascontiguousarray(py_b, dtype = ctypes.c_float)
    cdef np.ndarray[float, ndim=2, mode="c"] temp_c = np.zeros((nrows_a,ncols_b),dtype = ctypes.c_float)

    # Declare and initialize 3 A matrix
    cdef Amatrix_float A
    A.mat_pt = &temp_a[0, 0]
    A.NRows = nrows_a
    A.NCols = ncols_a

    cdef Amatrix_float B
    B.mat_pt = &temp_b[0, 0]
    B.NRows = nrows_b
    B.NCols = ncols_b

    cdef Amatrix_float C
    C.mat_pt = &temp_c[0, 0]
    C.NRows = nrows_c
    C.NCols = ncols_c

    # Multiply matrices together using cython subroutine
    matrix_multiplication(&A, &B, &C)

    return temp_c
