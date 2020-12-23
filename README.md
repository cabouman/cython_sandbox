# Cython Sandbox

This repository contains a simple example of how to use cython to create a python wrapper for subroutines written in the C progamming language.
This simple example can be used as a template for building complex python interfaces to existing C libraries.
See [link](https://suzyahyah.github.io/cython/programming/2018/12/01/Gotchas-in-Cython.html) for more information on cython.


# Installation

These installation instructions assume that you have access to a command line interface to your computer 
using a bash or other standard terminal.
This interface is standard in Linux, Unix (i.e., Mac OSX), but will need to be installed for Windows environments.

You will also need a compiler, such as ``gcc``, ``clang`` available on Mac OSX, or the Intel ``icc`` compiler.
We recommend either ``gcc`` or ``icc`` because they both support the OpenMP libraries required for fully utilizing multicore systems.
However, ``clang`` also works with single threaded compilation. 

**1. Download Cython Code**

Download the repository by typing the following command into the terminal.

``git clone https://github.com/cabouman/cython_sandbox.git``

This will download a directory system containing the software.
You should then move into the root directory of the repository using the following command.

``cd cython_sandbox``

**2. Create Conda Environment:**

If you don't have Anaconda, you will first need to install it. 
You can get Anaconda from [here](https://www.anaconda.com/products/individual), and here are installation instructions for the
[Mac OSX](https://problemsolvingwithpython.com/01-Orientation/01.04-Installing-Anaconda-on-MacOS/), 
[Linux](https://problemsolvingwithpython.com/01-Orientation/01.05-Installing-Anaconda-on-Linux/), and 
[Windows](https://problemsolvingwithpython.com/01-Orientation/01.03-Installing-Anaconda-on-Windows/).

Once you have installed Anaconda, then execute the following terminal command from the ``cython_sandbox`` directory:

``conda env create -f environment.yml``

``conda activate cython_sandbox``

This will create and activate a conda environment named ``cython_sandbox`` with the required dependencies.
Before running the code, this ``cython_sandbox`` conda environment should always be activated.


**3. Compile Cython Code**

In order to compile and install the package, run the following terminal command for the ``gcc`` compiler:

``CC=gcc pip install .``

And the following command for the ``icc`` compiler:

`LDSHARED="icc -shared" CC=icc pip install .`

The following command for the ``clang`` compiler:

``CC=clang pip install .``

These install commands temporarily set the ``CC``(compile) and ``LDSHARED``(link) environment variables for the duration of the installation 
and then use the ``setup.py`` script to compile and install the package.

You can verify the installation by running ``pip list``, which should display a brief summary of the packages installed in the ``cython_sandbox`` environment.
Now you will be able to use the ``cython_sandbox`` python commands from any directory by running the python command:

``import cython_sandbox``

**4. Run Demo**

After successfully installing the packages, you can run a demo that exercises the package using the command

``python demo/demo.py``

This calculates the product of two matrices in several different ways in order to demonstrate the difference
in run time.   These ways include 

    1. using loops in python (Py loops), 
    2. using loops in cython without variable declaration (Bad Cython),
    3. using loops in cython with variable declaration (Cython), 
    4. using cython to call C code (C code), and 
    5. using a standard ``numpy`` function.  

The execution times are displayed along with a verification that the results of all these methods
agree.  The slow methods can be skipped by setting include_slow to False near the beginning of the demo script.
Note that when compiled with ``gcc`` or ``icc``, the C code version will use multiple processors.  

# Additional Issues

## One-line Installation

One-line installation can be done by running

``CC=gcc pip install git+https://github.com/cabouman/cython_sandbox``

This internally clones the repository and installes the python package. No separate cloning is required.

## Installing C Compilers

The ``gcc`` compiler is perhaps the most widely available and is the default compiler available on Linux.
The ``gcc`` compiler can also be install on OSX with the homebrew package manager located [here](https://brew.sh). 

To obtain the ``clang`` compiler, you will need to install both ``Xcode`` and ``Command Line Tools for Xcode`` that are available from [here](https://developer.apple.com/download/more/).

If you install ``gcc`` on OSX make sure the command ``gcc`` points to ``/usr/local/bin/gcc-10`` rather pointing to the ``clang`` compiler located at ``/usr/bin/gcc``.

See the following [link](https://software.intel.com/content/www/us/en/develop/articles/thread-parallelism-in-cython.html)
for more details on using ``icc`` with cython.
