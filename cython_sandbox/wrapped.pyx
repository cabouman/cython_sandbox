import numpy as np

import ctypes           # Import python package required to use cython
cimport cython          # Import cython package
cimport numpy as np     # Import specialized cython support for numpy

# This imports functions and data types from the matrices.pxd file in the same directory
from matrices cimport Amatrix, matrix_multiplication, free_matrix, malloc_matrix, matrix_multiplication_nomalloc

@cython.boundscheck(False)      # Deactivate bounds checking to increase speed
@cython.wraparound(False)       # Deactivate negative indexing to increase speed

def py_matrix_multiplication(float[:,:] py_a, float[:,:] py_b, float[:,:] py_c):
    """
    Multiply two single precision float matrices together

    Args:
        py_a(float): 2D numpy array, the left matrix A.
        py_b(float): 2D numpy array, the right matrix B.
        py_c(float): 2D numpy array, the result matrix C.

    """

    # define cython int variable i
    cdef int i

    nrows_a, ncols_a = np.shape(py_a)
    nrows_b, ncols_b = np.shape(py_b)
    nrows_c, ncols_c = np.shape(py_c)

    # Copies the python variable py_a to the cython variable temp_a
    # The np.ascontiguousarray insures that data conforms to a row major (i.e., C) standard
    # see: https://stackoverflow.com/questions/26998223/what-is-the-difference-between-contiguous-and-non-contiguous-arrays
    cdef np.ndarray[float, ndim=2, mode="c"] temp_a = np.ascontiguousarray(py_a, dtype = ctypes.c_float)
    cdef np.ndarray[float, ndim=2, mode="c"] temp_b = np.ascontiguousarray(py_b, dtype = ctypes.c_float)

    # Declare and Initialize 3 cython matrices.
    cdef Amatrix A
    A.NRows = nrows_a
    A.NCols = ncols_a
    malloc_matrix(&A)

    cdef Amatrix B
    B.NRows = nrows_b
    B.NCols = ncols_b
    malloc_matrix(&B)

    cdef Amatrix C
    C.NRows = nrows_c
    C.NCols = ncols_c
    malloc_matrix(&C)

    if not (A.mat and B.mat and C.mat):
        raise MemoryError

    # Link Matrix pointers to the address of the first element of each row.
    for i in range(nrows_a):
        A.mat[i] = &temp_a[i, 0]
    for i in range(nrows_b):
        B.mat[i] = &temp_b[i, 0]
    for i in range(nrows_a):
        C.mat[i] = &py_c[i, 0]

    # Multiply matrices together using cython subroutine
    matrix_multiplication_nomalloc(&A, &B, &C)

