# Cython Sandbox

This repository contains a simple example of how to use cython to create a python wrapper for subroutines written in the C progamming language.
This simple example can be used as a template for building complex python interfaces to existing C libraries.
See [link](https://suzyahyah.github.io/cython/programming/2018/12/01/Gotchas-in-Cython.html) for more information on cython.


# Installation

These installation instructions assume that you have access to a command line interface to your computer 
using a bash or other standard terminal.
This interface is standard in Linux, Unix (i.e., Mac OSX), but will need to be installed for Windows environments.

You will also need a compiler, such as ``gcc``, ``clang`` available on Mac OSX, or the Intel ``icc`` compiler.
The ``gcc`` compiler is perhaps the most widely available, but ``clang`` is the default compiler available for download as part of the ``X-code`` development and comand line packages on Apple OSX.


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

This calculates the product of two matrices using the resulting python function, 
compares the result to the product computed using a standard ``numpy`` function, and prints out the results.
