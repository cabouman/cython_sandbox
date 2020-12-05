import numpy as np
import time

import ctypes           # Import python package required to use cython
cimport cython          # Import cython package
cimport numpy as np     # Import specialized cython support for numpy

# This imports functions and data types from the matrices.pxd file in the same directory
from matrices cimport Amatrix, matrix_multiplication, free_matrix, malloc_matrix, matrix_multiplication_nomalloc

@cython.boundscheck(False)      # Deactivate bounds checking to increase speed
@cython.wraparound(False)       # Deactivate negative indexing to increase speed
def py_matrix_multiplication(np.ndarray[np.float32_t,ndim=2,mode='c'] py_a, np.ndarray[np.float32_t, ndim=2, mode='c'] py_b):
    """
    Multiply two matrices together

    Args:
        py_a(float): 2D numpy array, the left matrix A.
        py_b(float): 2D numpy array, the right matrix B.

    Returns(float):
        2D numpy array, the product of two matrices.
    """

    # cdef specifies the use of a cython variable typed as int, as opposed to a python variable
    cdef int i
    nrows_a,ncols_a = np.shape(py_a)
    nrows_b,ncols_b = np.shape(py_b)

    # Copies the python variable py_a to the cython variable temp_a
    # The np.ascontiguousarray insures that data conforms to a row major (i.e., C) standard
    # see: https://stackoverflow.com/questions/26998223/what-is-the-difference-between-contiguous-and-non-contiguous-arrays
    cdef np.ndarray[float, ndim=2, mode="c"] temp_a = np.ascontiguousarray(py_a, dtype = ctypes.c_float)
    cdef np.ndarray[float, ndim=2, mode="c"] temp_b = np.ascontiguousarray(py_b, dtype = ctypes.c_float)

    # Create a cython variable, A, with type Amatrix
    # The set the values of the nrows_a and ncols_a
    # Then use the imported C subroutine, malloc_matrix, to allocate the memory for the matrix A
    cdef Amatrix A
    A.NRows = nrows_a
    A.NCols = ncols_a
    malloc_matrix(&A)

    # This is similar to A
    cdef Amatrix B
    B.NRows = nrows_b
    B.NCols = ncols_b
    malloc_matrix(&B)

    # Declare the product of 2 matrices.
    cdef Amatrix C

    if not (A.mat and B.mat):
        raise MemoryError

    # For each row, pointer points to the address of the first element.
    for i in range(nrows_a):
        A.mat[i] = &temp_a[i, 0]
    for i in range(nrows_b):
        B.mat[i] = &temp_b[i, 0]

    # Apply imported C library function.
    t = time.time()
    matrix_multiplication(&A, &B, &C)
    print("Execute C function: %f s"%(time.time() - t))

    # Create a 2D numpy array to store result product of 2 matrices.
    t = time.time()
    mat2 = np.zeros((C.NRows,C.NCols))
    for i in range(C.NRows):
        for j in range(C.NCols):
            mat2[i][j]=C.mat[i][j]
    print("Convert C matrix to 2D numpy array by loops: %f s"%(time.time() - t))
    return mat2



def py_matrix_multiplication2(float[:,:] py_a, float[:,:] py_b, float[:,:] py_c):
    '''

    Args:
        py_a(float): 2D numpy array, the left matrix A.
        py_b(float): 2D numpy array, the right matrix B.
        py_c(float): 2D numpy array, the result matrix C.


    '''
    cdef int i
    nrows_a,ncols_a = np.shape(py_a)
    nrows_b,ncols_b = np.shape(py_b)
    nrows_c,ncols_c = np.shape(py_c)

    # Make sure the input array are contiguous arrays.
    cdef np.ndarray[float, ndim=2, mode="c"] temp_a = np.ascontiguousarray(py_a, dtype = ctypes.c_float)
    cdef np.ndarray[float, ndim=2, mode="c"] temp_b = np.ascontiguousarray(py_b, dtype = ctypes.c_float)
    # Declare and Initialize 3 matrices.
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

    # Apply imported C library function.
    t = time.time()
    matrix_multiplication_nomalloc(&A, &B, &C)
    print("Execute C function: %f s"%(time.time() - t))
    # # return result matrix.
    # return py_c
