#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include <omp.h>

#include "allocate.h"
#include "matrices.h"

int matrix_multiplication(struct matrix_float *A, struct matrix_float *B , struct matrix_float *C)
{
    int i, j, k;

    /* Compute matrix product */
    for (i = 0; i < A->NRows ; i ++ )
        #pragma omp parallel for
        for (j = 0; j < B->NCols ; j ++ ) {
            C->mat[i][j] = 0;
            for (k = 0; k < A->NCols ; k ++ )
                C->mat[i][j] += A->mat[i][k]*B->mat[k][j];
        }

    return(0);
}
