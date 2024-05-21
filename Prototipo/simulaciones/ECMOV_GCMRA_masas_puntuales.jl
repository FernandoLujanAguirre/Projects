using DifferentialEquations
using LinearAlgebra
using Plots
using LaTeXStrings
using SciMLBase
function rotor(du,u,p,t)

    M3 = 1
    M4 = 1
    
    m11=-(1/2)*((-4*M3)+M4*((-8)+cos(2*u[1])+cos(2*u[1])*cos(2*u[2])+((-3*cos(2*u[1]))+cos(2*u[1])*cos(2*u[2]))*cos(2*u[3])+4*sin(2*u[1])*sin(u[2])*sin(2*u[3])+((-cos(2*u[1]))-cos(2*u[1])*cos(2*u[2])+(3*cos(2*u[1])-cos(2*u[1])*cos(2*u[2]))*cos(2*u[3])-4*sin(2*u[1])*sin(u[2])*sin(2*u[3]))*cos(u[4])+8*cos(u[2])*cos(u[3])*sin(u[4])))
    m12=-(1/2)*M4*((-sin(2*u[1])*sin(2*u[2]))-sin(2*u[1])*sin(2*u[2])*cos(2*u[3])-2*cos(2*u[1])*cos(u[2])*sin(2*u[3])+(sin(2*u[1])*sin(2*u[2])+sin(2*u[1])*sin(2*u[2])*cos(2*u[3])+2*cos(2*u[1])*cos(u[2])*sin(2*u[3]))*cos(u[4])+4*sin(u[3])*sin(u[4]))
    m13=-(1/2)*((-4*M3*sin(u[2]))+M4*((-8*sin(u[2]))-4*cos(2*u[1])*sin(u[2])*cos(2*u[3])+(3*sin(2*u[1])-sin(2*u[1])*cos(2*u[2]))*sin(2*u[3])+(4*cos(2*u[1])*sin(u[2])*cos(2*u[3])+((-3*sin(2*u[1]))+sin(2*u[1])*cos(2*u[2]))*sin(2*u[3]))*cos(u[4])+2*sin(2*u[2])*cos(u[3])*sin(u[4])))
    m14=(1/4)*M4*(8*cos(u[2])*cos(u[3])+((-5)-sin(2*u[1])+((-1)-sin(2*u[1]))*cos(2*u[2])+((-1)+3*sin(2*u[1])+((-1)-sin(2*u[1]))*cos(2*u[2]))*cos(2*u[3])+4*cos(2*u[1])*sin(u[2])*sin(2*u[3]))*sin(u[4]))
    m21=-(1/2)*M4*((-sin(2*u[1])*sin(2*u[2]))-sin(2*u[1])*sin(2*u[2])*cos(2*u[3])-2*cos(2*u[1])*cos(u[2])*sin(2*u[3])+(sin(2*u[1])*sin(2*u[2])+sin(2*u[1])*sin(2*u[2])*cos(2*u[3])+2*cos(2*u[1])*cos(u[2])*sin(2*u[3]))*cos(u[4])+4*sin(u[3])*sin(u[4]))
    m22=(1/2)*(M3*(2-2*sin(2*u[1]))+M4*(4-cos(2*u[1])-cos(2*u[1])*cos(2*u[2])+((-cos(2*u[1]))-cos(2*u[1])*cos(2*u[2]))*cos(2*u[3])+((-3*cos(2*u[1]))+cos(2*u[1])*cos(2*u[2])+(cos(2*u[1])+cos(2*u[1])*cos(2*u[2]))*cos(2*u[3]))*cos(u[4])))
    m23=-(1/2)*(2*M3*cos(2*u[1])*cos(u[2])+M4*((-2*sin(2*u[1])*cos(u[2]))-2*sin(2*u[1])*cos(u[2])*cos(2*u[3])-cos(2*u[1])*sin(2*u[2])*sin(2*u[3])+((-2*sin(2*u[1])*cos(u[2]))+2*sin(2*u[1])*cos(u[2])*cos(2*u[3])+cos(2*u[1])*sin(2*u[2])*sin(2*u[3]))*cos(u[4])+4*sin(u[2])*sin(u[3])*sin(u[4])))
    m24=(1/4)*M4*((-4*cos(2*u[1])*sin(u[2])*cos(u[3]))+(4+4*sin(2*u[1]))*sin(u[3])+((4-4*sin(2*u[1]))*sin(u[2])*cos(u[3])-4*cos(2*u[1])*sin(u[3]))*cos(u[4])+((-cos(2*u[1])*sin(2*u[2]))-cos(2*u[1])*sin(2*u[2])*cos(2*u[3])+((-2)+2*sin(2*u[1]))*cos(u[2])*sin(2*u[3]))*sin(u[4]))
    m31=-(1/2)*((-4*M3*sin(u[2]))+M4*((-8*sin(u[2]))-4*cos(2*u[1])*sin(u[2])*cos(2*u[3])+(3*sin(2*u[1])-sin(2*u[1])*cos(2*u[2]))*sin(2*u[3])+(4*cos(2*u[1])*sin(u[2])*cos(2*u[3])+((-3*sin(2*u[1]))+sin(2*u[1])*cos(2*u[2]))*sin(2*u[3]))*cos(u[4])+2*sin(2*u[2])*cos(u[3])*sin(u[4])))
    m32=-(1/2)*(2*M3*cos(2*u[1])*cos(u[2])+M4*((-2*sin(2*u[1])*cos(u[2]))-2*sin(2*u[1])*cos(u[2])*cos(2*u[3])-cos(2*u[1])*sin(2*u[2])*sin(2*u[3])+((-2*sin(2*u[1])*cos(u[2]))+2*sin(2*u[1])*cos(u[2])*cos(2*u[3])+cos(2*u[1])*sin(2*u[2])*sin(2*u[3]))*cos(u[4])+4*sin(u[2])*sin(u[3])*sin(u[4])))
    m33=(1/2)*(M3*(3+sin(2*u[1])+((-1)+sin(2*u[1]))*cos(2*u[2]))+M4*(6+cos(2*u[1])+((-2)+cos(2*u[1]))*cos(2*u[2])+(3*cos(2*u[1])-cos(2*u[1])*cos(2*u[2]))*cos(2*u[3])-4*sin(2*u[1])*sin(u[2])*sin(2*u[3])+(cos(2*u[1])+cos(2*u[1])*cos(2*u[2])+((-3*cos(2*u[1]))+cos(2*u[1])*cos(2*u[2]))*cos(2*u[3])+4*sin(2*u[1])*sin(u[2])*sin(2*u[3]))*cos(u[4])))
    m34=-(1/4)*M4*(((-2)-2*sin(2*u[1]))*sin(2*u[2])*cos(u[3])-4*cos(2*u[1])*cos(u[2])*sin(u[3])+(2*cos(2*u[1])*sin(2*u[2])*cos(u[3])+((-4)-4*sin(2*u[1]))*cos(u[2])*sin(u[3]))*cos(u[4])+(4*sin(u[2])-4*sin(2*u[1])*sin(u[2])*cos(2*u[3])+((-3*cos(2*u[1]))+cos(2*u[1])*cos(2*u[2]))*sin(2*u[3]))*sin(u[4]))
    m41=(1/4)*M4*(8*cos(u[2])*cos(u[3])+((-5)-sin(2*u[1])+((-1)-sin(2*u[1]))*cos(2*u[2])+((-1)+3*sin(2*u[1])+((-1)-sin(2*u[1]))*cos(2*u[2]))*cos(2*u[3])+4*cos(2*u[1])*sin(u[2])*sin(2*u[3]))*sin(u[4]))
    m42=(1/4)*M4*((-4*cos(2*u[1])*sin(u[2])*cos(u[3]))+(4+4*sin(2*u[1]))*sin(u[3])+((4-4*sin(2*u[1]))*sin(u[2])*cos(u[3])-4*cos(2*u[1])*sin(u[3]))*cos(u[4])+((-cos(2*u[1])*sin(2*u[2]))-cos(2*u[1])*sin(2*u[2])*cos(2*u[3])+((-2)+2*sin(2*u[1]))*cos(u[2])*sin(2*u[3]))*sin(u[4]))
    m43=-(1/4)*M4*(((-2)-2*sin(2*u[1]))*sin(2*u[2])*cos(u[3])-4*cos(2*u[1])*cos(u[2])*sin(u[3])+(2*cos(2*u[1])*sin(2*u[2])*cos(u[3])+((-4)-4*sin(2*u[1]))*cos(u[2])*sin(u[3]))*cos(u[4])+(4*sin(u[2])-4*sin(2*u[1])*sin(u[2])*cos(2*u[3])+((-3*cos(2*u[1]))+cos(2*u[1])*cos(2*u[2]))*sin(2*u[3]))*sin(u[4]))
    m44=-(1/4)*M4*((-5)-sin(2*u[1])+((-1)-sin(2*u[1]))*cos(2*u[2])+((-1)+3*sin(2*u[1])+((-1)-sin(2*u[1]))*cos(2*u[2]))*cos(2*u[3])+4*cos(2*u[1])*sin(u[2])*sin(2*u[3]))
    
    c11=(1/2)*(M4*du[1]*(cos(2*u[1])*sin(u[2])*((-4*sin(2*u[3]))+4*sin(2*u[3])*cos(u[4]))+sin(2*u[1])*(1+cos(2*u[2])*(1+cos(2*u[3])*(1-cos(u[4]))-cos(u[4]))-cos(u[4])+cos(2*u[3])*((-3)+3*cos(u[4]))))+M4*du[2]*(cos(2*u[1])*sin(2*u[2])*(2+cos(2*u[3])*(2-2*cos(u[4]))-2*cos(u[4]))+sin(2*u[1])*cos(u[2])*((-4*sin(2*u[3]))+4*sin(2*u[3])*cos(u[4]))+8*sin(u[2])*cos(u[3])*sin(u[4])))
    c12=(1/2)*(du[2]*(2*M3*cos(2*u[1])+M4*(sin(2*u[1])*((-1)+cos(2*u[2])*(1+cos(2*u[3])*(1-cos(u[4]))-cos(u[4]))+cos(2*u[3])*((-1)+cos(u[4]))-3*cos(u[4]))+cos(2*u[1])*sin(u[2])*((-2*sin(2*u[3]))+2*sin(2*u[3])*cos(u[4]))))+du[3]*(M3*(4-4*sin(2*u[1]))*cos(u[2])+M4*(cos(u[2])*(8+cos(2*u[1])*((-4)+cos(2*u[3])*(4-4*cos(u[4]))-4*cos(u[4])))+sin(2*u[1])*sin(2*u[2])*((-2*sin(2*u[3]))+2*sin(2*u[3])*cos(u[4]))+cos(u[3])*((-4*sin(u[4]))-4*cos(2*u[2])*sin(u[4]))))+M4*du[4]*((-4*cos(2*u[1])*sin(u[3]))-4*sin(u[3])*cos(u[4])-4*sin(2*u[1])*sin(u[3])*cos(u[4])+sin(u[2])*cos(u[3])*((-4)-4*sin(2*u[1])+4*cos(2*u[1])*cos(u[4]))+2*cos(2*u[1])*cos(u[2])*sin(2*u[3])*sin(u[4])+sin(2*u[2])*(sin(u[4])+cos(2*u[3])*sin(u[4])+sin(2*u[1])*(sin(u[4])+cos(2*u[3])*sin(u[4])))))
    c13=-(1/2)*(M4*du[1]*(sin(2*u[1])*sin(u[2])*cos(2*u[3])*(8-8*cos(u[4]))+cos(2*u[1])*(6*sin(2*u[3])-6*sin(2*u[3])*cos(u[4])+cos(2*u[2])*((-2*sin(2*u[3]))+2*sin(2*u[3])*cos(u[4])))-8*cos(u[2])*sin(u[3])*sin(u[4]))+du[3]*(M3*cos(2*u[1])*(1+cos(2*u[2]))+M4*(sin(2*u[1])*((-1)+cos(2*u[3])*(3-3*cos(u[4]))+cos(2*u[2])*((-1)+cos(2*u[3])*((-1)+cos(u[4]))-cos(u[4]))-cos(u[4]))+cos(2*u[1])*sin(u[2])*(4*sin(2*u[3])-4*sin(2*u[3])*cos(u[4]))-2*sin(2*u[2])*sin(u[3])*sin(u[4])))+M4*du[4]*(cos(u[2])*(4*sin(u[3])-4*sin(2*u[1])*sin(u[3])+4*cos(2*u[1])*sin(u[3])*cos(u[4]))+cos(u[3])*(2*cos(2*u[1])*sin(2*u[2])+sin(2*u[2])*(2*cos(u[4])+2*sin(2*u[1])*cos(u[4])))-4*cos(2*u[1])*sin(u[2])*cos(2*u[3])*sin(u[4])-sin(2*u[3])*sin(u[4])-cos(2*u[2])*sin(2*u[3])*sin(u[4])+sin(2*u[1])*(3*sin(2*u[3])*sin(u[4])-cos(2*u[2])*sin(2*u[3])*sin(u[4]))))
    c14=(1/4)*(M4*du[4]*(cos(2*u[1])*((-1)+cos(2*u[2])*((-1)-cos(2*u[3]))+3*cos(2*u[3]))-5*cos(u[4])-cos(2*u[3])*cos(u[4])+cos(2*u[2])*((-cos(u[4]))-cos(2*u[3])*cos(u[4]))+sin(u[2])*((-4*sin(2*u[1])*sin(2*u[3]))+4*cos(2*u[1])*sin(2*u[3])*cos(u[4]))+sin(2*u[1])*((-cos(u[4]))+3*cos(2*u[3])*cos(u[4])+cos(2*u[2])*((-cos(u[4]))-cos(2*u[3])*cos(u[4]))))+M4*du[1]*((-16*cos(u[2])*cos(u[3])*cos(u[4]))-8*sin(2*u[1])*sin(u[2])*sin(2*u[3])*sin(u[4])+cos(2*u[1])*((-2*sin(u[4]))+6*cos(2*u[3])*sin(u[4])+cos(2*u[2])*((-2*sin(u[4]))-2*cos(2*u[3])*sin(u[4])))))
    c21=-(1/2)*(du[2]*(4*M3*cos(2*u[1])+M4*sin(2*u[1])*((-2)-6*cos(u[4])+cos(2*u[3])*((-2)+2*cos(u[4]))+cos(2*u[2])*((-2)+2*cos(u[4])+cos(2*u[3])*((-2)+2*cos(u[4])))))+M4*du[1]*(cos(2*u[1])*sin(2*u[2])*((-1)+cos(2*u[3])*((-1)+cos(u[4]))+cos(u[4]))+sin(2*u[1])*cos(u[2])*(2*sin(2*u[3])-2*sin(2*u[3])*cos(u[4]))+4*sin(u[2])*cos(u[3])*sin(u[4])))
    c22=-(1/2)*(M4*du[2]*cos(2*u[1])*sin(2*u[2])*((-1)+cos(2*u[3])*((-1)+cos(u[4]))+cos(u[4]))+M4*du[3]*cos(2*u[1])*((-2*sin(2*u[3]))+2*sin(2*u[3])*cos(u[4])+cos(2*u[2])*((-2*sin(2*u[3]))+2*sin(2*u[3])*cos(u[4])))+M4*du[4]*cos(2*u[1])*((-3*sin(u[4]))+cos(2*u[3])*sin(u[4])+cos(2*u[2])*(sin(u[4])+cos(2*u[3])*sin(u[4]))))
    c23=(1/2)*(du[3]*(M3*((-1)+sin(2*u[1]))*sin(2*u[2])+M4*((-2*sin(2*u[2]))+cos(2*u[1])*sin(2*u[2])*(1+cos(2*u[3])*(1-cos(u[4]))+cos(u[4]))+sin(2*u[1])*cos(u[2])*((-2*sin(2*u[3]))+2*sin(2*u[3])*cos(u[4]))-4*sin(u[2])*cos(u[3])*sin(u[4])))+du[1]*(M3*((-4)+4*sin(2*u[1]))*cos(u[2])+M4*(sin(2*u[1])*sin(2*u[2])*((-2*sin(2*u[3]))+2*sin(2*u[3])*cos(u[4]))+cos(u[2])*((-8)+cos(2*u[1])*(4+cos(2*u[3])*(4-4*cos(u[4]))+4*cos(u[4])))+cos(u[3])*((-4*sin(u[4]))+4*cos(2*u[2])*sin(u[4]))))+M4*du[4]*(sin(u[2])*(4*cos(2*u[1])*sin(u[3])-4*sin(u[3])*cos(u[4])+4*sin(2*u[1])*sin(u[3])*cos(u[4]))+cos(u[3])*(2+sin(2*u[1])*(2-2*cos(2*u[2]))-2*cos(2*u[2])+cos(2*u[1])*((-2*cos(u[4]))+2*cos(2*u[2])*cos(u[4])))+cos(2*u[1])*sin(2*u[2])*sin(2*u[3])*sin(u[4])+cos(u[2])*(2*sin(u[4])-2*cos(2*u[3])*sin(u[4])+sin(2*u[1])*((-2*sin(u[4]))+2*cos(2*u[3])*sin(u[4])))))
    c24=(1/4)*(M4*du[4]*(sin(2*u[2])*(1+cos(2*u[3])+sin(2*u[1])*(1+cos(2*u[3])))+cos(u[2])*(2*cos(2*u[1])*sin(2*u[3])-2*sin(2*u[3])*cos(u[4])+2*sin(2*u[1])*sin(2*u[3])*cos(u[4]))+sin(u[2])*cos(u[3])*((-4*sin(u[4]))+4*sin(2*u[1])*sin(u[4]))+cos(2*u[1])*(sin(2*u[2])*((-cos(u[4]))-cos(2*u[3])*cos(u[4]))+4*sin(u[3])*sin(u[4])))+M4*du[1]*(8*cos(2*u[1])*sin(u[3])-8*sin(u[3])*cos(u[4])+8*sin(2*u[1])*sin(u[3])*cos(u[4])+sin(u[2])*cos(u[3])*(8+8*sin(2*u[1])-8*cos(2*u[1])*cos(u[4]))+4*cos(2*u[1])*cos(u[2])*sin(2*u[3])*sin(u[4])+sin(2*u[2])*((-2*sin(u[4]))-2*cos(2*u[3])*sin(u[4])+sin(2*u[1])*(2*sin(u[4])+2*cos(2*u[3])*sin(u[4])))))
    c31=-(1/2)*(M4*du[1]*(sin(2*u[1])*sin(u[2])*cos(2*u[3])*(4-4*cos(u[4]))+cos(2*u[1])*(3*sin(2*u[3])-3*sin(2*u[3])*cos(u[4])+cos(2*u[2])*((-sin(2*u[3]))+sin(2*u[3])*cos(u[4])))+4*cos(u[2])*sin(u[3])*sin(u[4]))+du[2]*(M3*((-4)-4*sin(2*u[1]))*cos(u[2])+M4*(sin(2*u[1])*sin(2*u[2])*(2*sin(2*u[3])-2*sin(2*u[3])*cos(u[4]))+cos(u[2])*((-8)+cos(2*u[1])*((-4)-4*cos(u[4])+cos(2*u[3])*((-4)+4*cos(u[4]))))+cos(u[3])*((-4*sin(u[4]))+4*cos(2*u[2])*sin(u[4])))))
    c32=(1/2)*(du[3]*(M3*(2-2*sin(2*u[1]))*sin(2*u[2])+M4*(4*sin(2*u[2])+cos(2*u[1])*sin(2*u[2])*((-2)+cos(2*u[3])*(2-2*cos(u[4]))-2*cos(u[4]))+sin(2*u[1])*cos(u[2])*((-4*sin(2*u[3]))+4*sin(2*u[3])*cos(u[4]))))+du[2]*(2*M3*cos(2*u[1])*sin(u[2])+M4*(sin(2*u[1])*sin(u[2])*((-2)-2*cos(u[4])+cos(2*u[3])*((-2)+2*cos(u[4])))+cos(2*u[1])*((-sin(2*u[3]))+sin(2*u[3])*cos(u[4])+cos(2*u[2])*(sin(2*u[3])-sin(2*u[3])*cos(u[4])))-4*cos(u[2])*sin(u[3])*sin(u[4])))+M4*du[4]*(sin(u[2])*((-4*cos(2*u[1])*sin(u[3]))-4*sin(u[3])*cos(u[4])-4*sin(2*u[1])*sin(u[3])*cos(u[4]))+cos(u[3])*((-2)+2*cos(2*u[2])+sin(2*u[1])*((-2)+2*cos(2*u[2]))+cos(2*u[1])*(2*cos(u[4])-2*cos(2*u[2])*cos(u[4])))+cos(2*u[1])*sin(2*u[2])*sin(2*u[3])*sin(u[4])+cos(u[2])*((-2*sin(u[4]))+2*cos(2*u[3])*sin(u[4])+sin(2*u[1])*((-2*sin(u[4]))+2*cos(2*u[3])*sin(u[4])))))
    c33=-(1/2)*(M4*du[3]*(sin(2*u[1])*sin(u[2])*cos(2*u[3])*(4-4*cos(u[4]))+cos(2*u[1])*(3*sin(2*u[3])-3*sin(2*u[3])*cos(u[4])+cos(2*u[2])*((-sin(2*u[3]))+sin(2*u[3])*cos(u[4]))))+du[1]*(M3*cos(2*u[1])*((-2)-2*cos(2*u[2]))+M4*(cos(2*u[1])*sin(u[2])*(8*sin(2*u[3])-8*sin(2*u[3])*cos(u[4]))+sin(2*u[1])*(2+cos(2*u[3])*(6-6*cos(u[4]))+2*cos(u[4])+cos(2*u[2])*(2+2*cos(u[4])+cos(2*u[3])*((-2)+2*cos(u[4]))))))+M4*du[4]*(4*sin(2*u[1])*sin(u[2])*sin(2*u[3])*sin(u[4])+cos(2*u[1])*(sin(u[4])-3*cos(2*u[3])*sin(u[4])+cos(2*u[2])*(sin(u[4])+cos(2*u[3])*sin(u[4])))))
    c34=-(1/4)*(M4*du[4]*((-sin(2*u[3]))-cos(2*u[2])*sin(2*u[3])+sin(2*u[1])*(3*sin(2*u[3])-cos(2*u[2])*sin(2*u[3]))+sin(u[2])*((-4*cos(2*u[1])*cos(2*u[3]))+4*cos(u[4])-4*sin(2*u[1])*cos(2*u[3])*cos(u[4]))+cos(2*u[1])*((-3*sin(2*u[3])*cos(u[4]))+cos(2*u[2])*sin(2*u[3])*cos(u[4]))-2*cos(2*u[1])*sin(2*u[2])*cos(u[3])*sin(u[4])+cos(u[2])*(4*sin(u[3])*sin(u[4])+4*sin(2*u[1])*sin(u[3])*sin(u[4])))+M4*du[1]*(cos(u[2])*((-8*sin(u[3]))+8*sin(2*u[1])*sin(u[3])-8*cos(2*u[1])*sin(u[3])*cos(u[4]))+cos(u[3])*((-4*cos(2*u[1])*sin(2*u[2]))+sin(2*u[2])*(4*cos(u[4])-4*sin(2*u[1])*cos(u[4])))-8*cos(2*u[1])*sin(u[2])*cos(2*u[3])*sin(u[4])+2*sin(2*u[3])*sin(u[4])+2*cos(2*u[2])*sin(2*u[3])*sin(u[4])+sin(2*u[1])*(6*sin(2*u[3])*sin(u[4])-2*cos(2*u[2])*sin(2*u[3])*sin(u[4]))))
    c41=(1/4)*(M4*du[1]*(8*cos(u[2])*cos(u[3])*cos(u[4])-4*sin(2*u[1])*sin(u[2])*sin(2*u[3])*sin(u[4])+cos(2*u[1])*((-sin(u[4]))+3*cos(2*u[3])*sin(u[4])+cos(2*u[2])*((-sin(u[4]))-cos(2*u[3])*sin(u[4]))))+M4*du[2]*(8*cos(2*u[1])*sin(u[3])+8*sin(u[3])*cos(u[4])+8*sin(2*u[1])*sin(u[3])*cos(u[4])+sin(u[2])*cos(u[3])*((-8)+8*sin(2*u[1])-8*cos(2*u[1])*cos(u[4]))+4*cos(2*u[1])*cos(u[2])*sin(2*u[3])*sin(u[4])+sin(2*u[2])*(2*sin(u[4])+2*cos(2*u[3])*sin(u[4])+sin(2*u[1])*(2*sin(u[4])+2*cos(2*u[3])*sin(u[4])))))
    c42=-(1/4)*(M4*du[4]*(sin(2*u[2])*(2+2*cos(2*u[3])+sin(2*u[1])*(2+2*cos(2*u[3])))+4*cos(2*u[1])*cos(u[2])*sin(2*u[3]))+M4*du[3]*(cos(u[3])*((-4)+sin(2*u[1])*((-4)-4*cos(2*u[2]))-4*cos(2*u[2])+cos(2*u[1])*(4*cos(u[4])+4*cos(2*u[2])*cos(u[4])))-2*cos(2*u[1])*sin(2*u[2])*sin(2*u[3])*sin(u[4])+cos(u[2])*(4*sin(u[4])+4*cos(2*u[3])*sin(u[4])+sin(2*u[1])*((-4*sin(u[4]))-4*cos(2*u[3])*sin(u[4]))))+M4*du[2]*(cos(u[2])*cos(u[3])*(4*cos(2*u[1])-4*cos(u[4])+4*sin(2*u[1])*cos(u[4]))+sin(u[2])*((-2*sin(2*u[3])*sin(u[4]))+2*sin(2*u[1])*sin(2*u[3])*sin(u[4]))+cos(2*u[1])*(3*sin(u[4])-cos(2*u[3])*sin(u[4])+cos(2*u[2])*(sin(u[4])+cos(2*u[3])*sin(u[4])))))
    c43=-(1/4)*(M4*du[4]*(8*cos(2*u[1])*sin(u[2])*cos(2*u[3])+2*sin(2*u[3])+2*cos(2*u[2])*sin(2*u[3])+sin(2*u[1])*((-6*sin(2*u[3]))+2*cos(2*u[2])*sin(2*u[3])))+M4*du[1]*(cos(u[2])*(8*sin(u[3])+8*sin(2*u[1])*sin(u[3])-8*cos(2*u[1])*sin(u[3])*cos(u[4]))+cos(u[3])*((-4*cos(2*u[1])*sin(2*u[2]))+sin(2*u[2])*((-4*cos(u[4]))-4*sin(2*u[1])*cos(u[4])))-8*cos(2*u[1])*sin(u[2])*cos(2*u[3])*sin(u[4])-2*sin(2*u[3])*sin(u[4])-2*cos(2*u[2])*sin(2*u[3])*sin(u[4])+sin(2*u[1])*(6*sin(2*u[3])*sin(u[4])-2*cos(2*u[2])*sin(2*u[3])*sin(u[4])))+M4*du[3]*(sin(2*u[2])*(2*sin(u[3])+2*sin(2*u[1])*sin(u[3]))+cos(u[2])*cos(u[3])*((-4*cos(2*u[1]))-4*cos(u[4])-4*sin(2*u[1])*cos(u[4]))+4*sin(2*u[1])*sin(u[2])*sin(2*u[3])*sin(u[4])+cos(2*u[1])*((-2*sin(2*u[2])*sin(u[3])*cos(u[4]))-sin(u[4])-3*cos(2*u[3])*sin(u[4])+cos(2*u[2])*((-sin(u[4]))+cos(2*u[3])*sin(u[4])))))
    c44=(1/2)*M4*du[1]*(cos(2*u[1])*(1-3*cos(2*u[3])+cos(2*u[2])*(1+cos(2*u[3])))+4*sin(2*u[1])*sin(u[2])*sin(2*u[3]))

    M=[m11 m12 m13 m14;m21 m22 m23 m24;m31 m32 m33 m34;m41 m42 m43 m44]
    C=[c11 c12 c13 c14;c21 c22 c23 c24;c31 c32 c33 c34;c41 c42 c43 c44]

    Kp = 1
    Kv = 1

    qd = 0.0
    qt = qd-u[4]

    u=Kp*qt-Kv*du[4]


    tau = [0;0;0;0]

    ddu = inv(M)*(-C*du+tau)

    
    end
    u1_0  = 0.0
    du1_0 = 0.0
    
    u2_0  = 0.0
    du2_0 = 0.1
    
    u3_0  = 0.0
    du3_0 = 0.0

    u4_0  = 0.0
    du4_0 = 0.0

    u0=[u1_0,u2_0,u3_0,u4_0]    
    du0=[du1_0,du2_0,du3_0,du4_0]

    

    tspan = (0.0,200)

    prob=SecondOrderODEProblem(rotor,du0,u0,tspan,dt=0.001,saveat=0.001)
    global sol = solve(prob)

    df=DataFrame(sol)
    json_str = JSON.json(df)

open("./Template/simulaciones/datos_GCMRA_MasasPuntuales.json", "w") do io
    write(io, json_str)
end
    
    pos=plot(sol,idxs=[5,6,7,8],label=[L"$x_1$" L"$x_2$" L"$x_3$" L"$x_4$"],linewidth=2) 

    vel=plot(sol,idxs=[1,2,3,4],label=[L"$x_5$" L"$x_6$" L"$x_7$" L"$x_8$"],linewidth=2)

    display(pos)
    display(vel)