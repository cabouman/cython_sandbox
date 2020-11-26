#ifndef _MATRICES_H_
#define _MATRICES_H_

#include <stdio.h>

struct Amatrix
{
    int NRows;
    int NCols;
    float **mat;           /* The array is indexed by mat[NRows][NCols] */
};

void matrix_multiplication(struct Amatrix *A, struct Amatrix *B , struct Amatrix *C);
void free_matrix(struct Amatrix *A);
void malloc_matrix(struct Amatrix *A);
#endif