#ifndef _MATRICES_H_
#define _MATRICES_H_

#include <stdio.h>

struct Amatrix_float
{
    int NRows;
    int NCols;
    float *mat_pt;  /* Pointer to 1D contiguous array used by python */
    float **mat;    /* Pointer used for 2D array used by multialloc that is indexed by mat[NRows][NCols] */
};

int matrix_multiplication(struct Amatrix_float *A, struct Amatrix_float *B , struct Amatrix_float *C);


void py_2_multialloc_2D(struct Amatrix_float *A);
void multialloc_2_py_2D(struct Amatrix_float *A);

#endif