import numpy as np
from cython_sandbox import py_matrix_multiplication
import time
A=np.random.randint(10,size=(130,40)).astype(np.float)
B=np.random.randint(10,size=(40,150)).astype(np.float)
t = time.time()
py_matrix_multiplication(A,B)
#print(C)
print("cython finished : %f s"%(time.time() - t))

t = time.time()
C=np.dot(A,B)
#print()
print("numpy  finished : %f s"%(time.time() - t))