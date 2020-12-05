#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "allocate.h"
#include "matrices.h"

void malloc_matrix(struct Amatrix *A)
{
    A->mat=(float **)multialloc(sizeof(float), 2, A->NRows,A->NCols);
}

void free_matrix(struct Amatrix *A)
{
    free_img((void **)A->mat);
}

void matrix_multiplication(struct Amatrix *A, struct Amatrix *B , struct Amatrix *C)
{
    if (A->NCols != B->NRows)
    {
        printf("Number of columns in matrix A(%d) should equal to number of rows in matrix B(%d).\n", A->NCols, B->NRows);
    }

    int i, j, k;

    C->NRows = A->NRows;
    C->NCols = B->NCols;
    C->mat = (float **)multialloc(sizeof(float), 2, C->NRows,C->NCols);

    for (i = 0; i < A->NRows ; i ++ )
        for (j = 0; j < B->NCols ; j ++ )
        {
            C->mat[i][j] = 0;
            for (k = 0; k < A->NCols ; k ++ )
                C->mat[i][j]+=A->mat[i][k]*B->mat[k][j];
        }

}

void matrix_multiplication_nomalloc(struct Amatrix *A, struct Amatrix *B , struct Amatrix *C)
{
    if (A->NCols != B->NRows)
    {
        printf("Number of columns in matrix A(%d) should equal to number of rows in matrix B(%d).\n", A->NCols, B->NRows);
    }

    int i, j, k;

    for (i = 0; i < A->NRows ; i ++ )
        for (j = 0; j < B->NCols ; j ++ )
        {
            C->mat[i][j] = 0;
            for (k = 0; k < A->NCols ; k ++ )
                C->mat[i][j]+=A->mat[i][k]*B->mat[k][j];
        }

}