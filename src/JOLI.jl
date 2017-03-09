############################################################
# JOLI module ##############################################
############################################################

module JOLI

# what's being used

# what's imported
import Base.eltype
import Base.show, Base.showall, Base.display
import Base.size, Base.length
import Base.full
import Base.norm, Base.vecnorm
import Base.real, Base.imag, Base.conj
import Base.transpose, Base.ctranspose
import Base.isreal, Base.issymmetric, Base.ishermitian
import Base.*, Base.\, Base.+, Base.-
import Base.(.*), Base.(.\), Base.(.+), Base.(.-)
import Base.hcat, Base.vcat

# extra exported methods
export deltype, reltype
export double, iscomplex, isinvertible, islinear, isadjoint

# constants
export joTol
joTol = 10e-12

# package for each operator code goes here
include("Utils.jl")
include("joAbstractOperator.jl")
include("joMatrix.jl")
include("joLinearFunction.jl")
include("joLinearOperator.jl")
include("joMatrixConstructors.jl")
include("joLinearFunctionConstructors.jl")
include("joLinearOperatorConstructors.jl")

end # module
