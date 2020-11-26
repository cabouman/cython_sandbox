cimport cython
import numpy as np
cimport numpy as np
import ctypes
from libc.stdlib cimport malloc
cimport matrices
from matrices cimport Amatrix, matrix_multiplication, free_matrix, malloc_matrix


@cython.boundscheck(False)
@cython.wraparound(False)
def py_matrix_multiplication(np.ndarray[np.float_t,ndim=2,mode='c'] py_a, np.ndarray[np.float_t, ndim=2, mode='c'] py_b):
    '''

    Args:
        py_a(float): 2D numpy array, the left matrix A.
        py_b(float): 2D numpy array, the right matrix B.

    Returns(float):
        2D numpy array, the product of two matrices.

    '''
    cdef int i
    nrows_a,ncols_a = np.shape(py_a)
    nrows_b,ncols_b = np.shape(py_b)

    # From numpy data type to c data type.
    cdef np.ndarray[float, ndim=2, mode="c"] temp_a = np.ascontiguousarray(py_a, dtype = ctypes.c_float)
    cdef np.ndarray[float, ndim=2, mode="c"] temp_b = np.ascontiguousarray(py_b, dtype = ctypes.c_float)

    # Declare and Initialize 2 matrices.
    cdef Amatrix A
    A.NRows = nrows_a
    A.NCols = ncols_a
    malloc_matrix(&A)

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
    matrix_multiplication(&A, &B, &C)

    # Create a 2D numpy array to store result product of 2 matrices.
    mat2 = np.zeros((C.NRows,C.NCols))
    for i in range(C.NRows):
        for j in range(C.NCols):
            mat2[i][j]=C.mat[i][j]
    return mat2

    # Free matrices.
    free_matrix(&A)
    free_matrix(&B)
    free_matrix(&C)


