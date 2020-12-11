from setuptools import setup, Extension
from Cython.Distutils import build_ext
import numpy as np
import os

NAME = "cython_sandbox"
VERSION = "0.1"
DESCR = "A small template project that shows how to wrap C/C++ code into python using Cython"
REQUIRES = ['numpy', 'cython']
LICENSE = "BSD-3-Clause"

AUTHOR = "Wenrui Li"
EMAIL = "liwr5damon@gmail.com"


# Specifies directory containing cython functions to be compiled
SRC_DIR = "cython_sandbox"
PACKAGES = [SRC_DIR]

# Linux
# ext_1 = Extension(SRC_DIR + ".wrapped",
#                   [SRC_DIR + "/lib/cfunc.c", SRC_DIR + "/wrapped.pyx"],
#                   libraries=[],
#                   include_dirs=[np.get_include()],
#                   extra_compile_args=["-fopenmp"],
#                   extra_link_args=["-fopenmp"])

# These settings work for MacOS, but still need to be tested for Linux and Windows
if os.environ.get('CC') =='gcc':
    c_extension = Extension(SRC_DIR + ".wrapped",
                      [SRC_DIR + "/src/matrices.c",SRC_DIR + "/src/allocate.c", SRC_DIR + "/wrapped.pyx"],
                      libraries=[],
                      include_dirs=[np.get_include()],
                      extra_compile_args=["-fopenmp","-Wno-unknown-pragmas"],
                      # You should replace /usr/local/opt/gcc/lib/gcc/10/ with your own installed gcc library if not working.
                      extra_link_args=["-lm","-fopenmp",'-L/usr/local/opt/gcc/lib/gcc/10/']) 

if os.environ.get('CC') =='clang':
    c_extension = Extension(SRC_DIR + ".wrapped",
                      [SRC_DIR + "/src/matrices.c",SRC_DIR + "/src/allocate.c", SRC_DIR + "/wrapped.pyx"],
                      libraries=[],
                      include_dirs=[np.get_include()],
                      extra_compile_args=["-Xclang", "-fopenmp", "-Wno-unknown-pragmas"],
                      extra_link_args=["-lm","-Xclang", "-fopenmp", "-lomp"])


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
      ext_modules=[c_extension]
      )
