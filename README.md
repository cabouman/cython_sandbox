# Cython sandbox
This is a sandbox for people to use for cython implementation experiment. 

# Installation
## 1. Downloading
``git clone https://github.com/cabouman/cython_sandbox.git``

``cd cython_sandbox``

## 2. Installing Python Package
### 1. (Optional) Create Conda Environment:
It is recommended that you create a conda environment.
To do this, first install ``Anaconda``, and then create and activate an ``svmbir`` environment using the following two commands.

``conda env create -f environment.yml``

``conda activate cython_sandbox``

This will create a conda environment with the required dependencies.
Before running the code, this ``cython_sandbox`` conda environment should always be activated.

If you don't want to create a conda environment, just make sure that you have all required packages(environment.yml) installed in your environment.

### 2. Installing cython_sandbox
In order to install the ``cython_sandbox`` package into your ``cython_sandbox`` environment, first make sure the ``cython_sandbox`` environment is active, and then run the following command

For gcc compiler,

``CC=gcc python setup.py install``

For clang compiler,

``CC=clang python setup.py install``

The install command sets the ``CC`` environment variable only for the duration of the installation without modifying existing environment variables.

You can verify the installation by running ``pip list``, which should display a brief summary of the packages installed in the ``cython_sandbox`` environment.
Now you will be able to use the ``cython_sandbox`` python commands from any directory by running the python command ``import cython_sandbox``.

### 3. Testing
After successfully installing the packages, you can test the package using

``python demo/demo.py``

This calculates two matrices multiplication using c library function.


## More information

For more information on cython, see [link](https://suzyahyah.github.io/cython/programming/2018/12/01/Gotchas-in-Cython.html)
