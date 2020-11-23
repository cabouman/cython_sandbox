cimport cython
import numpy as np
cimport numpy as np
import ctypes
from numpy import int32, float
from numpy cimport int32_t, float_t
from libc.stdlib cimport malloc, free

cimport matrices
from matrices cimport Amatrix, matrix_multiplication



@cython.boundscheck(False)
@cython.wraparound(False)
def py_matrix_multiplication( np.ndarray[np.float_t,ndim=2,mode='c'] mat,np.ndarray[np.float_t,ndim=2,mode='c'] mat1):
    cdef int i
    row_size,column_size = np.shape(mat)
    row_size1,column_size1 = np.shape(mat1)
    cdef np.ndarray[float, ndim=2, mode="c"] temp_mat = np.ascontiguousarray(mat, dtype = ctypes.c_float)
    cdef np.ndarray[float, ndim=2, mode="c"] temp_mat1 = np.ascontiguousarray(mat1, dtype = ctypes.c_float)
    # cdef np.npy_intp shape[2]
    cdef Amatrix A
    A.NRows = row_size
    A.NCols = column_size
    A.mat = <float **>malloc(column_size * sizeof(float*))

    cdef Amatrix B
    B.NRows = row_size1
    B.NCols = column_size1
    B.mat = <float **>malloc(column_size * sizeof(float*))

    cdef Amatrix C
    if not A.mat:
        raise MemoryError
    try:
        for i in range(row_size):
            A.mat[i] = &temp_mat[i, 0]
        for i in range(row_size1):
            B.mat[i] = &temp_mat1[i, 0]

        matrix_multiplication(&A, &B, &C)
        mat2 = np.zeros((C.NRows,C.NCols))

        # shape[0] = <np.npy_intp> C.NRows
        # shape[1] = <np.npy_intp> C.NCols

        # ndarray = np.PyArray_SimpleNewFromData(2, shape,
        #             np.NPY_FLOAT, <void *> C.mat)
        # np.PyArray_UpdateFlags(ndarray, ndarray.flags.num | np.NPY_OWNDATA)
        # for i in range(C.NRows):
        #     for j in range(C.NCols):
        #         mat2[i][j]=C.mat[i][j]
        # return mat2
        # return np.array(np.ascontiguousarray(C.mat))
    finally:
        print("a")
        # free(A)
        # free(B)
        # free(C)


