# JOLI - Julia Operators LIbrary

**Julia framework for constructing matrix-free linear operators
with explicit domain/range type control
and applying them in basic algebraic matrix-vector operations.**

Julia Operator LIbrary (JOLI) is a package for creating
algebraic operators (currently linear only) and use them
in a way that tries to mimic the mathematical formulas of
basics algebra.

The package was created in SLIM group at the University of
British Columbia for their work in seismic imaging and modelling.

JOLI has a collection of methods that allow creating and
use of element-free operators, operators created from explicit
Matrices, and composing all of those into complex formulas that
are not explicitly executed until they act on the Vector or Matrix.
'*', '+', '-', and etc... operations are supported in any mathematically
valid combination of operators and vectors as long as vector is on the
right side of the operator. Composite operators can be
defined before they are used to act on vectors.

JOLI operators support operations like adjoint, transpose,
and conjugate for element-free operators provided that enough
functionality is provided when constructing JOLI operator.

JOLI operators support and enforce consistency of domain and range
data types for operators with both vectors acted upon and created
by operators. JOLI also has the functionality that allows easily to
switch precision of computations using global type definitions.

Contrary to other linear-operators Julia packages, JOLI operators act on
matrices as if those were column-wise collections of vectors. I.e.
JOLI operator does not treat explicit matrix on left side of '*' as
another operator, and will act on it immediately. Such behaviour
is convenient for implementation of Kronecker product.

[![Build Status](https://travis-ci.org/slimgroup/JOLI.jl.svg?branch=master)](https://travis-ci.org/slimgroup/JOLI.jl)

## INSTALLATION

### Using SLIM Registry (preferred method) ###

First switch to package manager prompt (using ']') and add SLIM registry:

```
	registry add https://github.com/slimgroup/SLIMregistryJL.git
```

Then still from package manager prompt add JOLI:

```
	add JOLI
```

### Adding without SLIM registry ###

After switching to package manager prompt (using ']') type:

```
	add https://github.com/slimgroup/JOLI.jl.git
```

## Documentation (more to come)

For now it is just [REFERENCE guide](https://slimgroup.github.io/JOLI.jl).

## Examples (more to come)

Check [templates](templates) for an examples of how to build your own operators or types,
or look up DCT implementation in [src/joLinearFunctionConstructors/joDCT.jl](src/joLinearFunctionConstructors/joDCT.jl).

Try [src/template.joLinearFunctionFwd](src/template.joLinearFunctionFwd) as a starting point for building your own operators.
