from setuptools import setup, Extension
from Cython.Distutils import build_ext
import numpy as np

NAME = "cython_sandbox"
VERSION = "0.1"
DESCR = "A small template project that shows how to wrap C/C++ code into python using Cython"
REQUIRES = ['numpy', 'cython']

AUTHOR = "Wenrui Li"
EMAIL = "liwr5damon@gmail.com"

LICENSE = " BSD-3-Clause"

SRC_DIR = "cython_sandbox"
PACKAGES = [SRC_DIR]

# Linux
# ext_1 = Extension(SRC_DIR + ".wrapped",
#                   [SRC_DIR + "/lib/cfunc.c", SRC_DIR + "/wrapped.pyx"],
#                   libraries=[],
#                   include_dirs=[np.get_include()],
#                   extra_compile_args=["-fopenmp"],
#                   extra_link_args=["-fopenmp"])

# MacOS
ext_1 = Extension(SRC_DIR + ".wrapped",
                  [SRC_DIR + "/matrices/src/matrices.c",SRC_DIR + "/matrices/src/allocate.c", SRC_DIR + "/wrapped.pyx"],
                  libraries=[],
                  include_dirs=[np.get_include()],
                  extra_compile_args=["-fopenmp"])#,
                  #extra_link_args=["-fopenmp","-liomp5","-lpthread","-L/opt/intel/lib"])



EXTENSIONS = [ext_1]

if __name__ == "__main__":
    setup(install_requires=REQUIRES,
          packages=PACKAGES,
          zip_safe=False,
          name=NAME,
          version=VERSION,
          description=DESCR,
          author=AUTHOR,
          author_email=EMAIL,
          license=LICENSE,
          cmdclass={"build_ext": build_ext},
          ext_modules=EXTENSIONS
          )