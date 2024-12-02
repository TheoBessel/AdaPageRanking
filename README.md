# AdaPageRanking

This project aims to implement Google's page ranking algorithm in Ada using both full and sparse matrix approaches.

It was realized by Théo Bessel and Timothé Lebobe, during their first-year at N7 in the Digital Sciences department.

## Compilation

To compile the project, please run the script `./build.sh`.

By adding the `-run` argument to this script, it will directly execute the compiled code.

By adding the `-test` argument to this script, it will execute the test modules for the various packages.

## Project Architecture

For each package, there is a corresponding test module in the form `test_<package_name>.adb`.

### 1. Package `Graph`

This package provides an implementation of directed graphs used for page ranking. The adjacency matrix/list is a generic type that allows implementing different algorithms with dense/sparse matrices.

### 2. Package `Matrix`

This package provides an implementation of matrices used for page ranking. It is based on Ada's primitive `Array` type, using a two-dimensional `Array`. The package is divided into `Full` and `Sparse` sub-packages for dense and sparse matrices, respectively.

### 3. Package `IOStream`

This package offers various functions for managing the program's input parameters and displaying the different outputs.

### 4. Package `Algorithm`

This package provides an implementation of the page ranking algorithm based on the different packages detailed above.
