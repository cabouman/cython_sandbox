import numpy as np
import ctypes           # Import python package required to use cython
cimport cython          # Import cython package
cimport numpy as cnp    # Import specialized cython support for numpy

""" 
This file contains 3 cython functions for matrix multiplication.
1. A wrapper to manage error handling and call c code to do the multiplication.
2. A naive cython function without variable types.
3. A proper cython function with variable types.  
"""
# This imports functions and data types from the matrices.pxd file in the same directory
from matrices cimport matrix_float, matrix_multiplication


@cython.boundscheck(False)      # Deactivate bounds checking to increase speed
@cython.wraparound(False)       # Deactivate negative indexing to increase speed

def c_mat_mult(cnp.ndarray py_a, cnp.ndarray py_b):
    """
    Cython wrapper that calls c code to multiply two single precision float matrices

    Args:
        py_a(float): 2D numpy float array with C continuous order, the left matrix A.
        py_b(float): 2D numpy float array with C continuous order, the right matrix B.

    Return:
        py_c: 2D numpy float array that is the product of A and B.
    """

    # Get shapes of A and B
    cdef int nrows_a = np.shape(py_a)[0]
    cdef int ncols_a = np.shape(py_a)[1]

    cdef int nrows_b = np.shape(py_b)[0]
    cdef int ncols_b = np.shape(py_b)[1]

    if (not py_a.flags["C_CONTIGUOUS"]) or (not py_b.flags["C_CONTIGUOUS"]):
        raise AttributeError("2D np.ndarrays must be C-contiguous")

    if (ncols_a != nrows_b):
        raise AttributeError("Matrix shapes are not compatible")

    # Set output matrix shape
    cdef int nrows_c = nrows_a
    cdef int ncols_c = ncols_b

    cdef cnp.ndarray[float, ndim=2, mode="c"] cy_a = py_a
    cdef cnp.ndarray[float, ndim=2, mode="c"] cy_b = py_b

    # Allocates memory, without initialization, for matrix to be passed back from C subroutine
    cdef cnp.ndarray[float, ndim=2, mode="c"] py_c = np.empty((nrows_a,ncols_b), dtype=ctypes.c_float)

    # Declare and initialize 3 matrices
    cdef matrix_float A     # Allocate C data structure matrix
    A.mat_pt = &cy_a[0, 0]  # Assign pointer in C data structure
    A.NRows = nrows_a       # Set value of NRows in C data structure
    A.NCols = ncols_a       # Set value of NCols in C data structure

    cdef matrix_float B
    B.mat_pt = &cy_b[0, 0]
    B.NRows = nrows_b
    B.NCols = ncols_b

    cdef matrix_float C
    C.mat_pt = &py_c[0, 0]
    C.NRows = nrows_c
    C.NCols = ncols_c

    # Multiply matrices together by calling C subroutine
    matrix_multiplication(&A, &B, &C)

    # Return cython ndarray
    return py_c


def cython_mat_mult(cnp.ndarray py_a, cnp.ndarray py_b):
    """
    Cython function to multiply two numpy matrices using fairly optimized cython.

    Args:
        py_a(float): 2D numpy array, the left matrix A.
        py_b(float): 2D numpy array, the right matrix B.

    Return:
        py_c: 2D numpy array that is the product of A and B.
    """
    # Get dimensions and check for compatibility - note that the variable types are declared here.
    cdef int nrows_a = np.shape(py_a)[0]
    cdef int ncols_a = np.shape(py_a)[1]

    cdef int nrows_b = np.shape(py_b)[0]
    cdef int ncols_b = np.shape(py_b)[1]

    if ncols_a != nrows_b:
        raise AttributeError("Matrix shapes are not compatible")

    # Set output matrix shape
    cdef int nrows_c = nrows_a
    cdef int ncols_c = ncols_b
    cdef int n_mults = ncols_a
    cdef int i, j, k

    # Allocate space and then loop to do the multiplication
    cdef cnp.ndarray[float, ndim=2, mode="c"] cy_a = py_a
    cdef cnp.ndarray[float, ndim=2, mode="c"] cy_b = py_b
    cdef cnp.ndarray[float, ndim=2, mode="c"] cy_c = np.empty((nrows_a, ncols_b), dtype=ctypes.c_float)
    for i in range(nrows_c):
        for j in range(ncols_c):
            cy_c[i,j] = 0
            for k in range(n_mults):
                cy_c[i,j] += cy_a[i, k] * cy_b[k, j]

    # Return cython ndarray
    return cy_c


def cython_slow_mat_mult(cnp.ndarray py_a, cnp.ndarray py_b):
    """
    Cython function to multiply two numpy matrices - note that variable types are not declared.  This
    prevents efficient compilation and execution.

    Args:
        py_a(float): 2D numpy array, the left matrix A.
        py_b(float): 2D numpy array, the right matrix B.

    Return:
        py_c: 2D numpy array that is the product of A and B.
    """
    # Get dimensions and check for compatibility
    nrows_a = np.shape(py_a)[0]
    ncols_a = np.shape(py_a)[1]

    nrows_b = np.shape(py_b)[0]
    ncols_b = np.shape(py_b)[1]

    if ncols_a != nrows_b:
        raise AttributeError("Matrix shapes are not compatible")

    # Set output matrix shape
    nrows_c = nrows_a
    ncols_c = ncols_b
    n_mults = ncols_a

    # Allocate space and then loop to do the multiplication
    py_c = np.empty((nrows_a, ncols_b))
    for i in range(nrows_c):
        for j in range(ncols_c):
            py_c[i,j] = 0
            for k in range(n_mults):
                py_c[i,j] += py_a[i, k] * py_b[k, j]

    # Return cython ndarray
    return py_c
