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

# Single threaded gcc compile; tested for MacOS and Linux
if (os.environ.get('CC') == 'gcc') and (os.environ.get('OMPCOMP') !='1'):
    c_extension = Extension(SRC_DIR + ".wrapped",
                      [SRC_DIR + "/src/matrices.c",SRC_DIR + "/src/allocate.c", SRC_DIR + "/wrapped.pyx"],
                      libraries=[],
                      include_dirs=[np.get_include()])

# Single threaded clang compile; tested for MacOS and Linux
if (os.environ.get('CC') == 'clang') and (os.environ.get('OMPCOMP') !='1'):
    c_extension = Extension(SRC_DIR + ".wrapped",
                      [SRC_DIR + "/src/matrices.c",SRC_DIR + "/src/allocate.c", SRC_DIR + "/wrapped.pyx"],
                      libraries=[],
                      include_dirs=[np.get_include()])

# Single threaded icc compile; tested for MacOS and Linux
if (os.environ.get('CC') == 'icc') and (os.environ.get('OMPCOMP') !='1'):
    c_extension = Extension(SRC_DIR + ".wrapped",
                      [SRC_DIR + "/src/matrices.c",SRC_DIR + "/src/allocate.c", SRC_DIR + "/wrapped.pyx"],
                      libraries=[],
                      include_dirs=[np.get_include()],
                      extra_compile_args=["-DICC","-no-prec-div", "-restrict" ,"-ipo","-inline-calloc",
                                          "-qopt-calloc","-no-ansi-alias","-xCORE-AVX2"],
                      extra_link_args=["-DICC","-no-prec-div", "-restrict" ,"-ipo","-inline-calloc",
                                          "-qopt-calloc","-no-ansi-alias","-xCORE-AVX2"])

# OpenMP gcc compile: tested for MacOS and Linux
if (os.environ.get('CC') =='gcc') and (os.environ.get('OMPCOMP') =='1'):
    c_extension = Extension(SRC_DIR + ".wrapped",
                      [SRC_DIR + "/src/matrices.c",SRC_DIR + "/src/allocate.c", SRC_DIR + "/wrapped.pyx"],
                      libraries=[],
                      include_dirs=[np.get_include()],
                      # for gcc-10 "-std=c11" can be added as a flag
                      extra_compile_args=["-O3", "-fopenmp","-Wno-unknown-pragmas","-DOMP_COMP"],
                      extra_link_args=["-lm","-fopenmp"]) 


# OpenMP icc compile: tested for MacOS and Linux
if (os.environ.get('CC') =='icc') and (os.environ.get('OMPCOMP') =='1'):
    c_extension = Extension(SRC_DIR + ".wrapped",
                      [SRC_DIR + "/src/matrices.c",SRC_DIR + "/src/allocate.c", SRC_DIR + "/wrapped.pyx"],
                      libraries=[],
                      include_dirs=[np.get_include()],
                      # for gcc-10 "-std=c11" can be added as a flag
                      extra_compile_args=["-DICC","-qopenmp","-no-prec-div", "-restrict" ,"-ipo","-inline-calloc",
                                          "-qopt-calloc","-no-ansi-alias","-xCORE-AVX2"],
                      extra_link_args=["-lm","-DICC","-qopenmp","-no-prec-div", "-restrict" ,"-ipo","-inline-calloc",
                                          "-qopt-calloc","-no-ansi-alias","-xCORE-AVX2"])

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
