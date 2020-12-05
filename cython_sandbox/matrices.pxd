cimport cython
import numpy as np
import ctypes
from numpy import int32, float, double
from numpy cimport int32_t, float_t, double_t


cdef extern from "matrices/src/matrices.h":
    # Define cython data structure
    struct Amatrix:
        int NRows;
        int NCols;
        float **mat;
    
    # Define cython functions
    void matrix_multiplication(
            Amatrix *A,
            Amatrix *B ,
            Amatrix *C);

    void matrix_multiplication_nomalloc(
            Amatrix *A,
            Amatrix *B ,
            Amatrix *C);

    void malloc_matrix(Amatrix *A);
    void free_matrix(Amatrix *A);