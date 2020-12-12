#ifndef _MATRICES_H_
#define _MATRICES_H_

#include <stdio.h>

struct matrix_float
{
    int NRows;
    int NCols;
    float **mat;    /* Pointer used for 2D array used by multialloc that is indexed by mat[NRows][NCols] */
};

int matrix_multiplication(struct matrix_float *A, struct matrix_float *B , struct matrix_float *C);


#endif