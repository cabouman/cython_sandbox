#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "allocate.h"
#include "matrices.h"

int matrix_multiplication(struct matrix_float *A, struct matrix_float *B , struct matrix_float *C)
{
    int i, j, k;

    /* Convert 2D arrays from 1D python format to 2D multialloc format */
    array_2_multialloc_2Dfloat(A);
    array_2_multialloc_2Dfloat(B);
    array_2_multialloc_2Dfloat(C);

    /* Compute matrix product */
    for (i = 0; i < A->NRows ; i ++ )
        #pragma omp parallel for
        for (j = 0; j < B->NCols ; j ++ ) {
            C->mat[i][j] = 0;
            for (k = 0; k < A->NCols ; k ++ )
                C->mat[i][j] += A->mat[i][k]*B->mat[k][j];
        }

    multialloc_2_array_2Dfloat(A);
    multialloc_2_array_2Dfloat(B);
    multialloc_2_array_2Dfloat(C);
    return(0);
}

void array_2_multialloc_2Dfloat(struct matrix_float *A)
{
    int i;

    /* Allocate and set array of pointers for multialloc array */
    A->mat = get_spc(sizeof(float *), A->NRows);
    for (i = 0; i < A->NRows ; i ++ ) {
        A->mat[i] = A->mat_pt + i*(A->NCols);
    }
}

void multialloc_2_array_2Dfloat(struct matrix_float *A)
{
    free((void **)A->mat);
}