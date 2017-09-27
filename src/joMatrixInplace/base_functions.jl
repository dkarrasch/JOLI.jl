############################################################
## joMatrixInplace - overloaded Base functions

# eltype(jo)

# deltype(jo)

# reltype(jo)

# show(jo)

# showall(jo)

# display(jo)

# size(jo)

# size(jo,1/2)

# length(jo)

# full(jo)

# norm(jo)

# vecnorm(jo)

# real(jo)

# imag(jo)

# conj(jo)

# transpose(jo)

# ctranspose(jo)

# isreal(jo)

# issymmetric(jo)

# ishermitian(jo)

############################################################
## overloaded Base *(...jo...)

# *(jo,jo)

# *(jo,mvec)

# *(mvec,jo)

# *(jo,vec)

# *(vec,jo)

# *(num,jo)

# *(jo,num)

############################################################
## overloaded Base \(...jo...)

# \(jo,jo)

# \(jo,mvec)

# \(mvec,jo)

# \(jo,vec)

# \(vec,jo)

# \(num,jo)

# \(jo,num)

############################################################
## overloaded Base +(...jo...)

# +(jo)

# +(jo,jo)

# +(jo,mvec)

# +(mvec,jo)

# +(jo,vec)

# +(vec,jo)

# +(jo,num)

# +(num,jo)

############################################################
## overloaded Base -(...jo...)

# -(jo)

# -(jo,jo)

# -(jo,mvec)

# -(mvec,jo)

# -(jo,vec)

# -(vec,jo)

# -(jo,num)

# -(num,jo)

############################################################
## overloaded Base .*(...jo...)

############################################################
## overloaded Base .\(...jo...)

############################################################
## overloaded Base .+(...jo...)

############################################################
## overloaded Base .-(...jo...)

############################################################
## overloaded Base block methods

# hcat(...jo...)

# vcat(...jo...)

# hvcat(...jo...)

############################################################
## overloaded Base.LinAlg functions

# A_mul_B!(...,jo,...)
A_mul_B!{DDT,RDT}(y::AbstractVector{RDT},A::joMatrixInplace{DDT,RDT},x::AbstractVector{DDT}) = A.fop(y,x)
A_mul_B!{DDT,RDT}(y::AbstractMatrix{RDT},A::joMatrixInplace{DDT,RDT},x::AbstractMatrix{DDT}) = A.fop(y,x)

# At_mul_B!(...,jo,...)
At_mul_B!{DDT,RDT}(y::AbstractVector{DDT},A::joMatrixInplace{DDT,RDT},x::AbstractVector{RDT}) = A.fop_T(y,x)
At_mul_B!{DDT,RDT}(y::AbstractMatrix{DDT},A::joMatrixInplace{DDT,RDT},x::AbstractMatrix{RDT}) = A.fop_T(y,x)

# Ac_mul_B!(...,jo,...)
Ac_mul_B!{DDT,RDT}(y::AbstractVector{DDT},A::joMatrixInplace{DDT,RDT},x::AbstractVector{RDT}) = A.fop_CT(y,x)
Ac_mul_B!{DDT,RDT}(y::AbstractMatrix{DDT},A::joMatrixInplace{DDT,RDT},x::AbstractMatrix{RDT}) = A.fop_CT(y,x)

# A_ldiv_B!(...,jo,...)
A_ldiv_B!{DDT,RDT}(y::AbstractVector{DDT},A::joMatrixInplace{DDT,RDT},x::AbstractVector{DDT}) = get(A.iop)(y,x)
A_ldiv_B!{DDT,RDT}(y::AbstractMatrix{DDT},A::joMatrixInplace{DDT,RDT},x::AbstractMatrix{DDT}) = get(A.iop)(y,x)

# At_ldiv_B!(...,jo,...)
At_ldiv_B!{DDT,RDT}(y::AbstractVector{RDT},A::joMatrixInplace{DDT,RDT},x::AbstractVector{DDT}) = get(A.iop_T)(y,x)
At_ldiv_B!{DDT,RDT}(y::AbstractMatrix{RDT},A::joMatrixInplace{DDT,RDT},x::AbstractMatrix{DDT}) = get(A.iop_T)(y,x)

# Ac_ldiv_B!(...,jo,...)
Ac_ldiv_B!{DDT,RDT}(y::AbstractVector{RDT},A::joMatrixInplace{DDT,RDT},x::AbstractVector{DDT}) = get(A.iop_CT)(y,x)
Ac_ldiv_B!{DDT,RDT}(y::AbstractMatrix{RDT},A::joMatrixInplace{DDT,RDT},x::AbstractMatrix{DDT}) = get(A.iop_CT)(y,x)

