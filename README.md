# Cython Sandbox

This repository contains a simple example of how to use cython to create a python wrapper for subroutines written in the C progamming language.
This simple example can be used as a template for building complex python interfaces to existing C libraries.
See [link](https://suzyahyah.github.io/cython/programming/2018/12/01/Gotchas-in-Cython.html) for more information on cython.

For the standard single threaded C code go [here](https://github.com/cabouman/cython_sandbox).
But if you would like to use the multi-threaded C-code with the OpenMP libraries, then go [here](https://github.com/cabouman/cython_sandbox/tree/openmp).

# Single Threaded Installation

Obtain the single-threaded version of the cython_sandbox from [here](https://github.com/cabouman/cython_sandbox).

These installation instructions assume that you have access to a command line interface to your computer 
using a bash or other standard terminal.
This interface is standard in Linux, Unix (i.e., Mac OSX), but will need to be installed for Windows environments.

You will also need a compiler, such as ``gcc``, ``clang`` available on Mac OSX, or the Intel ``icc`` compiler.
The ``gcc`` compiler is perhaps the most widely available, but ``clang`` is the default Mac OSX compiler.
The both ``Xcode`` and ``Command Line Tools for Xcode`` are available from [here](https://developer.apple.com/download/more/)

**1. Create Conda Environment:**

You will first need to install Anaconda and create a conda environment.
You can get Anaconda from [here](https://www.anaconda.com/products/individual), and here are installation instructions for the
[Mac OSX](https://problemsolvingwithpython.com/01-Orientation/01.04-Installing-Anaconda-on-MacOS/), 
[Linux](https://problemsolvingwithpython.com/01-Orientation/01.05-Installing-Anaconda-on-Linux/), and 
[Windows](https://problemsolvingwithpython.com/01-Orientation/01.03-Installing-Anaconda-on-Windows/).

Once you have installed Anaconda, then execute the following command from the ``cython_sandbox`` directory:

``conda env create -f environment.yml``

``conda activate cython_sandbox``

This will create and activate a conda environment named ``cython_sandbox`` with the required dependencies.
Before running the code, this ``cython_sandbox`` conda environment should always be activated.

**2. Download and Compile Cython Code**

You will next need to download and compile the repository.
To do this, download the repository by typing the following command into the terminal.

``git clone https://github.com/cabouman/cython_sandbox.git``

This will download a directory system containing the software.
You should then move into the root directory of the repository using the following command.

``cd cython_sandbox``

In order to compile and install the package, run the following command for the ``gcc`` compiler:

``CC=gcc pip install .``

And the following command for the ``clang`` compiler:

``CC=clang pip install .``

These install commands temporarily set the ``CC`` environment variable for the duration of the installation 
and then use the ``setup.py`` script to compile and install the package.

You can verify the installation by running ``pip list``, which should display a brief summary of the packages installed in the ``cython_sandbox`` environment.
Now you will be able to use the ``cython_sandbox`` python commands from any directory by running the python command:

``import cython_sandbox``

**3. Run Demo**

After successfully installing the packages, you can run a demo that exercises the package using the command

``python demo/demo.py``

This calculates the product of two matrices in several different ways in order to demonstrate the difference
in run time.   These ways include 

    1. using loops in python, 
    2. using loops in cython without variable declaration,
    3. using loops in cython with variable declaration, 
    4. using cython to call c code, and 
    5. using a standard ``numpy`` function.  

The execution times are displayed along with a verification that the results of all these methods
agree.  The slow methods can be skipped by setting include_slow to False near the beginning of the demo script.  


# Multi-Threaded OpenMP Installation

Obtain the multi-threaded version of the cython_sandbox from [here](https://github.com/cabouman/cython_sandbox/tree/openmp).
This supports the use of the OpenMP libraries and can use multiple cores in your computer in parallel.

For ``gcc`` most things are similar as in the single-threaded version.
However, some special steps are necessary for ``clang``.

**1. Create Conda Environment:**

If you are using ``clang``, then you will need to use the following modified command to install the conda environment:

``conda env create -f environment-clangomp.yml``

``conda activate cython_sandbox_clangomp``

This creates a special conda environment that does not install the MKL support, which is redundant for the ``clang`` environment and interferes with the OMP libraries.
See item 24 [here](https://stackoverflow.com/questions/53014306/error-15-initializing-libiomp5-dylib-but-found-libiomp5-dylib-already-initial) for details.


**2. Compile Cython Code**

For Mac OSX you will need to install OpenMP libraries.
You can obtain this libraries from [here](https://mac.r-project.org/openmp/).
Once the OMP libraries are installed, you should be able to compile with the same command:

``CC=clang pip install .``
