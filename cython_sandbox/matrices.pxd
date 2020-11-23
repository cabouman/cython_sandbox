cimport cython
import numpy as np
import ctypes
from numpy import int32, float, double
from numpy cimport int32_t, float_t, double_t


cdef extern from "matrices/src/matrices.h":
    # Structure
    struct Amatrix:
        int NRows;
        int NCols;
        float **mat;
    
    # Functions
    void matrix_multiplication(
            Amatrix *A,
            Amatrix *B ,
            Amatrix *C);
