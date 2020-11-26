# Cython sandbox
This is a sandbox for people to use for cython implementation. 

# Installation
## 1. Downloading
``git clone https://github.com/cabouman/Cython-Sandbox.git``

## 2. Installing Python Package
### 1. (Optional) Create Conda Environment:
It is recommended that you create a conda environment.
To do this, first install ``Anaconda``, and then create and activate an ``svmbir`` environment using the following two commands.

``conda env create -f environment.yml``

``conda activate cython-sandbox``

This will create a conda environment with the required dependencies.
Before running the code, this ``cython-sandbox`` conda environment should always be activated.

If you don't want to create a conda environment, just make sure that you have all required packages(environment.yml) installed in your environment.

### 2. Installing cython-sandbox
In order to install the ``cython-sandbox`` package into your ``cython-sandbox`` environment, first make sure the ``cython-sandbox`` environment is active, and then run the following command

For gcc compiler,

``CC = gcc python setup.py install``

For clang compiler,

``CC = clang python setup.py install``

You can verify the installation by running ``pip list``, which should display a brief summary of the packages installed in the ``cython-sandbox`` environment.
Now you will be able to use the ``cython-sandbox`` python commands from any directory by running the python command ``import cython-sandbox``.

### 3. Testing
After successfully installing the packages, you can test the package using

``python demo/demo.py``

This calculate two matrixs multiplication using c library function.
