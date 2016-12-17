# 2D Curevelt operators: joCurvelet2D

function apply_fdct2D(v,n1,n2,m,nbs,nbac,actl,rctl,zfin)
    if rctl==1
        C=zeros(Float64,m)
        eltype(v)<:Real || throw(joLinearFunctionException("joCurvelt2D: imput vector must be real for real transform"))
        X= eltype(v)==Float64 ? v : convert(Array{Float64,1},v)
        ccall((:jl_fdct_wrapping_real,:libdfdct_wrapping),Void,
            (Cint,Cint,Cint,Cint,Cint,Cint,Cint,Csize_t,Ptr{Array{Float64}},Ptr{Array{Float64}}),
            n1,n2,nbs,nbac,actl,rctl,zfin,m,X,C)
    else
        C=zeros(Complex{Float64},m)
        X= eltype(v)==Complex{Float64} ? v : convert(Array{Complex{Float64},1},v)
        ccall((:jl_fdct_wrapping_cpx,:libdfdct_wrapping),Void,
            (Cint,Cint,Cint,Cint,Cint,Cint,Cint,Csize_t,Ptr{Array{Complex{Float64}}},Ptr{Array{Complex{Float64}}}),
            n1,n2,nbs,nbac,actl,rctl,zfin,m,X,C)
    end
    return C
end

function apply_ifdct2D(v,n1,n2,m,nbs,nbac,actl,rctl,zfin)
    if rctl==1
        X=zeros(Float64,n1*n2)
        eltype(v)<:Real || throw(joLinearFunctionException("joCurvelt2D: imput vector must be real for real transform"))
        C= eltype(v)==Float64 ? v : convert(Array{Float64,1},v)
        ccall((:jl_ifdct_wrapping_real,:libdfdct_wrapping),Void,
            (Cint,Cint,Cint,Cint,Cint,Cint,Cint,Csize_t,Ptr{Array{Float64}},Ptr{Array{Float64}}),
            n1,n2,nbs,nbac,actl,rctl,zfin,m,C,X)
    else
        X=zeros(Complex{Float64},n1*n2)
        C= eltype(v)==Complex{Float64}? v : convert(Array{Complex{Float64},1},v)
        ccall((:jl_ifdct_wrapping_cpx,:libdfdct_wrapping),Void,
            (Cint,Cint,Cint,Cint,Cint,Cint,Cint,Csize_t,Ptr{Array{Complex{Float64}}},Ptr{Array{Complex{Float64}}}),
            n1,n2,nbs,nbac,actl,rctl,zfin,m,C,X)
    end
    return X
end

export joCurvelet2D
"""
    joCurvelet2D(n1,n2[;nbscales=#,nbangles_coarse=16,all_crvlts=false,real_crvlts=true,zero_finest=false])

2D Curvelet transform over fast dimensions

# Arguments
- n1,n2 - image sizes
- nbscales - # of scales (defaults to max(1,ceil(log2(min(n1,n2))-3)))
- nbangles_coarse - # of angles at coarse scale (defaults to 16)
- all_crvlts - curvelets at finnest scales (defaults to false)
- real_crvlts - real transform (defaults to true) and resquires real input
- zero_finest - zero out finnest scales (defaults to false)

# Examples

- joCurvelet2D(32,32) - real transform

- joCurvelet2D(32,32;real_crvlts=false) - complex transform

- joCurvelet2D(32,32;all_crvlts=true) - real transform with curevelts at the finnest scales

- joCurvelet2D(32,32;zero_finest=true) - real transform with zeros at the finnest scales

Note: isadjoint test at larger sizes (above 128) might require reseting tollerance to bigger number.

"""
function joCurvelet2D(n1::Integer,n2::Integer;
            nbscales::Integer=0,
            nbangles_coarse::Integer=16,
            all_crvlts::Bool=false,
            real_crvlts::Bool=true,
            zero_finest::Bool=false)

    nbs=convert(Cint,max(1,ceil(log2(min(n1,n2)) - 3)))
    nbs=convert(Cint,max(nbs,nbscales))
    nbs > 1 || throw(joLinearFunctionException("joCurvelt2D: not enough elements in one of dimensions"))
    if nbscales!=0 && nbs>nbscales
        warn("Adjusted number of scales to required $nbs")
    end
    nbac=convert(Cint,max(8,nbangles_coarse))
    if nbangles_coarse < 8
        warn("Adjusted number of coarse angles to required $nbac")
    end
    actl=convert(Cint,all_crvlts)
    rctl=convert(Cint,real_crvlts)
    zfin=convert(Cint,zero_finest)
    if real_crvlts
        eltp=Float64
    else
        eltp=Complex{Float64}
    end
    cfmap_size=ccall((:jl_fdct_sizes_map_size,:libdfdct_wrapping),Int32,
        (Cint,Cint,Cint),nbs,nbac,all_crvlts)
    cfmap=zeros(Int32,cfmap_size)
    m=Ref{Csize_t}(0)
    ccall((:jl_fdct_sizes,:libdfdct_wrapping),Void,
        (Cint,Cint,Cint,Cint,Cint,Ptr{Array{Cint}},Ref{Csize_t}),
        nbs,nbac,actl,n1,n2,cfmap,m)
    m=convert(Int128,m[])

    return joLinearFunctionCT(eltp,m,n1*n2,
        v1->apply_fdct2D(v1,n1,n2,m,nbs,nbac,actl,rctl,zfin),
        v2->apply_ifdct2D(v2,n1,n2,m,nbs,nbac,actl,rctl,zfin),
        v3->apply_ifdct2D(v3,n1,n2,m,nbs,nbac,actl,rctl,zfin),
        v4->apply_fdct2D(v4,n1,n2,m,nbs,nbac,actl,rctl,zfin),
        "joCurvelt2D"
        )
end
