cimport cython
import numpy as np
import ctypes
from numpy import int32, float, double
from numpy cimport int32_t, float_t, double_t


cdef extern from "src/matrices.h":
    # Define cython data structure
    struct matrix_float:
        int NRows;
        int NCols;
        float *mat_pt;  # Pointer to 1D contiguous array used by python
        float **mat;    # Pointer used for 2D array used by multialloc that is indexed by mat[NRows][NCols]

    # Define cython functions
    int matrix_multiplication( matrix_float *A, matrix_float *B, matrix_float *C );