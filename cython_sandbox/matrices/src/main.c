#include "matrices.h"
#include "allocate.h"
#include "math.h"

int main(int argc, char **argv)
{
    int i,j;

    struct Amatrix A, B, C;

    A.NRows = 130;
    A.NCols = 240;

    A.mat = (float **)multialloc(sizeof(float), 2, A.NRows,A.NCols);
    printf("A Matrix\n");

    for (i = 0; i < A.NRows ; i ++)
        for (j = 0; j < A.NCols ; j ++){
            A.mat[i][j]= (i * j) %7; 
            printf("%f ",A.mat[i][j] );
            if (j == A.NCols-1){
                printf("\n");
            }
        }

    printf("B Matrix\n");
    B.NRows = 240;
    B.NCols = 150;
    B.mat = (float **)multialloc(sizeof(float), 2, B.NRows,B.NCols);    

    for (i = 0; i < B.NRows ; i++)
        for (j = 0; j < B.NCols ; j++){
            B.mat[i][j]= (i * j) %5; 
            printf("%f ",B.mat[i][j] );
            if (j == B.NCols-1){
                printf("\n");
            }
        }

    matrix_multiplication(&A, &B, &C);
    printf("C = A * B\n");
    for (i = 0; i < C.NRows ; i++)
        for (j = 0; j < C.NCols ; j++){
            printf("%f ",C.mat[i][j] );
            if (j == C.NCols-1){
                printf("\n");
            }
        }


}