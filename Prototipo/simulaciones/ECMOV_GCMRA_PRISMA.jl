using DifferentialEquations
using LinearAlgebra
using Plots
using LaTeXStrings
using SciMLBase
using SimulationLogs
using JSON
using DataFrames
function rotor(du,u,p,t)


    Ix = 1
    Iy = 2
    Iz = 3

    Is = 1

    
    
    m11=-(1/16)*((-16*Is)-6*Ix-5*Iy-5*Iz+(2*Ix-Iy-Iz)*cos(2*u[2])+((-2*Ix)+Iy+Iz+((-2*Ix)+Iy+Iz)*cos(2*u[2]))*cos(2*u[3])+(2*Ix-Iy-Iz+((-6*Ix)+3*Iy+3*Iz)*cos(2*u[2])+((-2*Ix)+Iy+Iz+((-2*Ix)+Iy+Iz)*cos(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+(8*Ix-4*Iy-4*Iz)*sin(2*u[2])*cos(u[3])*sin(2*u[4])+(Iy-Iz+((-3*Iy)+3*Iz)*cos(2*u[2])+(3*Iy-3*Iz+(3*Iy-3*Iz)*cos(2*u[2]))*cos(2*u[3])+(Iy-Iz+((-3*Iy)+3*Iz)*cos(2*u[2])+((-Iy)+Iz+((-Iy)+Iz)*cos(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+(4*Iy-4*Iz)*sin(2*u[2])*cos(u[3])*sin(2*u[4]))*cos(2*u[5])+(((-8*Iy)+8*Iz)*sin(2*u[2])*sin(u[3])*cos(u[4])+((-4*Iy)+4*Iz+((-4*Iy)+4*Iz)*cos(2*u[2]))*sin(2*u[3])*sin(u[4]))*sin(2*u[5]))
    m12=-(1/8)*((2*Ix-Iy-Iz)*cos(u[2])*sin(2*u[3])+(2*Ix-Iy-Iz)*cos(u[2])*sin(2*u[3])*cos(2*u[4])+((-4*Ix)+2*Iy+2*Iz)*sin(u[2])*sin(u[3])*sin(2*u[4])+(((-3*Iy)+3*Iz)*cos(u[2])*sin(2*u[3])+(Iy-Iz)*cos(u[2])*sin(2*u[3])*cos(2*u[4])+((-2*Iy)+2*Iz)*sin(u[2])*sin(u[3])*sin(2*u[4]))*cos(2*u[5])+(((-4*Iy)+4*Iz)*sin(u[2])*cos(u[3])*cos(u[4])+((-4*Iy)+4*Iz)*cos(u[2])*cos(2*u[3])*sin(u[4]))*sin(2*u[5]))
    m13=(1/4)*(((-4*Is)-2*Ix-Iy-Iz)*sin(u[2])+(2*Ix-Iy-Iz)*sin(u[2])*cos(2*u[4])+(2*Ix-Iy-Iz)*cos(u[2])*cos(u[3])*sin(2*u[4])+((Iy-Iz)*sin(u[2])+(Iy-Iz)*sin(u[2])*cos(2*u[4])+(Iy-Iz)*cos(u[2])*cos(u[3])*sin(2*u[4]))*cos(2*u[5])+((-2*Iy)+2*Iz)*cos(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5]))
    m14=-(1/2)*(((-Iy)-Iz)*cos(u[2])*sin(u[3])+((-Iy)+Iz)*cos(u[2])*sin(u[3])*cos(2*u[5])+(((-Iy)+Iz)*sin(u[2])*cos(u[4])+((-Iy)+Iz)*cos(u[2])*cos(u[3])*sin(u[4]))*sin(2*u[5]))
    m15=Ix*cos(u[2])*cos(u[3])*cos(u[4])-Ix*sin(u[2])*sin(u[4])
    m21=-(1/8)*((2*Ix-Iy-Iz)*cos(u[2])*sin(2*u[3])+(2*Ix-Iy-Iz)*cos(u[2])*sin(2*u[3])*cos(2*u[4])+((-4*Ix)+2*Iy+2*Iz)*sin(u[2])*sin(u[3])*sin(2*u[4])+(((-3*Iy)+3*Iz)*cos(u[2])*sin(2*u[3])+(Iy-Iz)*cos(u[2])*sin(2*u[3])*cos(2*u[4])+((-2*Iy)+2*Iz)*sin(u[2])*sin(u[3])*sin(2*u[4]))*cos(2*u[5])+(((-4*Iy)+4*Iz)*sin(u[2])*cos(u[3])*cos(u[4])+((-4*Iy)+4*Iz)*cos(u[2])*cos(2*u[3])*sin(u[4]))*sin(2*u[5]))
    m22=(1/8)*(8*Is+2*Ix+3*Iy+3*Iz+((-2*Ix)+Iy+Iz)*cos(2*u[3])+(2*Ix-Iy-Iz+((-2*Ix)+Iy+Iz)*cos(2*u[3]))*cos(2*u[4])+(Iy-Iz+(3*Iy-3*Iz)*cos(2*u[3])+(Iy-Iz+((-Iy)+Iz)*cos(2*u[3]))*cos(2*u[4]))*cos(2*u[5])+((-4*Iy)+4*Iz)*sin(2*u[3])*sin(u[4])*sin(2*u[5]))
    m23=(1/4)*(((-2*Ix)+Iy+Iz)*sin(u[3])*sin(2*u[4])+((-Iy)+Iz)*sin(u[3])*sin(2*u[4])*cos(2*u[5])+((-2*Iy)+2*Iz)*cos(u[3])*cos(u[4])*sin(2*u[5]))
    m24=(1/2)*((Iy+Iz)*cos(u[3])+(Iy-Iz)*cos(u[3])*cos(2*u[5])+((-Iy)+Iz)*sin(u[3])*sin(u[4])*sin(2*u[5]))
    m25=-Ix*sin(u[3])*cos(u[4])
    
    m31=(1/4)*(((-4*Is)-2*Ix-Iy-Iz)*sin(u[2])+(2*Ix-Iy-Iz)*sin(u[2])*cos(2*u[4])+(2*Ix-Iy-Iz)*cos(u[2])*cos(u[3])*sin(2*u[4])+((Iy-Iz)*sin(u[2])+(Iy-Iz)*sin(u[2])*cos(2*u[4])+(Iy-Iz)*cos(u[2])*cos(u[3])*sin(2*u[4]))*cos(2*u[5])+((-2*Iy)+2*Iz)*cos(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5]))
    m32=(1/4)*(((-2*Ix)+Iy+Iz)*sin(u[3])*sin(2*u[4])+((-Iy)+Iz)*sin(u[3])*sin(2*u[4])*cos(2*u[5])+((-2*Iy)+2*Iz)*cos(u[3])*cos(u[4])*sin(2*u[5]))
    m33=(1/4)*(4*Is+2*Ix+Iy+Iz+((-2*Ix)+Iy+Iz)*cos(2*u[4])+((-Iy)+Iz+((-Iy)+Iz)*cos(2*u[4]))*cos(2*u[5]))
    m34=(1/2)*((-Iy)+Iz)*cos(u[4])*sin(2*u[5])
    m35=Ix*sin(u[4])
    
    m41=-(1/2)*(((-Iy)-Iz)*cos(u[2])*sin(u[3])+((-Iy)+Iz)*cos(u[2])*sin(u[3])*cos(2*u[5])+(((-Iy)+Iz)*sin(u[2])*cos(u[4])+((-Iy)+Iz)*cos(u[2])*cos(u[3])*sin(u[4]))*sin(2*u[5]))
    m42=(1/2)*((Iy+Iz)*cos(u[3])+(Iy-Iz)*cos(u[3])*cos(2*u[5])+((-Iy)+Iz)*sin(u[3])*sin(u[4])*sin(2*u[5]))
    m43=(1/2)*((-Iy)+Iz)*cos(u[4])*sin(2*u[5])
    m44=-(1/2)*((-Iy)-Iz+((-Iy)+Iz)*cos(2*u[5]))
    m45=0
    
    m51=Ix*cos(u[2])*cos(u[3])*cos(u[4])-Ix*sin(u[2])*sin(u[4])
    m52=-Ix*sin(u[3])*cos(u[4])
    
    m53=Ix*sin(u[4])
    
    m54=0
    
    m55=Ix
    
    
    c11=-(1/8)*(((-2*Ix)+Iy+Iz)*du[2]*sin(2*u[2])+(2*Ix-Iy-Iz)*du[2]*sin(2*u[2])*cos(2*u[3])+((2*Ix-Iy-Iz)*du[3]+(2*Ix-Iy-Iz)*du[3]*cos(2*u[2]))*sin(2*u[3])+((6*Ix-3*Iy-3*Iz)*du[2]*sin(2*u[2])+(8*Ix-4*Iy-4*Iz)*du[4]*sin(2*u[2])*cos(u[3])+(2*Ix-Iy-Iz)*du[2]*sin(2*u[2])*cos(2*u[3])+((2*Ix-Iy-Iz)*du[3]+(2*Ix-Iy-Iz)*du[3]*cos(2*u[2]))*sin(2*u[3]))*cos(2*u[4])+(((-2*Ix)+Iy+Iz)*du[4]+(6*Ix-3*Iy-3*Iz)*du[4]*cos(2*u[2])+(8*Ix-4*Iy-4*Iz)*du[2]*cos(2*u[2])*cos(u[3])+((-4*Ix)+2*Iy+2*Iz)*du[3]*sin(2*u[2])*sin(u[3])+((2*Ix-Iy-Iz)*du[4]+(2*Ix-Iy-Iz)*du[4]*cos(2*u[2]))*cos(2*u[3]))*sin(2*u[4])+((3*Iy-3*Iz)*du[2]*sin(2*u[2])+((-3*Iy)+3*Iz)*du[2]*sin(2*u[2])*cos(2*u[3])+(((-3*Iy)+3*Iz)*du[3]+((-3*Iy)+3*Iz)*du[3]*cos(2*u[2]))*sin(2*u[3])+((-8*Iy)+8*Iz)*du[5]*sin(2*u[2])*sin(u[3])*cos(u[4])+(((-4*Iy)+4*Iz)*du[5]+((-4*Iy)+4*Iz)*du[5]*cos(2*u[2]))*sin(2*u[3])*sin(u[4])+((3*Iy-3*Iz)*du[2]*sin(2*u[2])+(4*Iy-4*Iz)*du[4]*sin(2*u[2])*cos(u[3])+(Iy-Iz)*du[2]*sin(2*u[2])*cos(2*u[3])+((Iy-Iz)*du[3]+(Iy-Iz)*du[3]*cos(2*u[2]))*sin(2*u[3]))*cos(2*u[4])+(((-Iy)+Iz)*du[4]+(3*Iy-3*Iz)*du[4]*cos(2*u[2])+(4*Iy-4*Iz)*du[2]*cos(2*u[2])*cos(u[3])+((-2*Iy)+2*Iz)*du[3]*sin(2*u[2])*sin(u[3])+((Iy-Iz)*du[4]+(Iy-Iz)*du[4]*cos(2*u[2]))*cos(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+(((-Iy)+Iz)*du[5]+(3*Iy-3*Iz)*du[5]*cos(2*u[2])+(((-3*Iy)+3*Iz)*du[5]+((-3*Iy)+3*Iz)*du[5]*cos(2*u[2]))*cos(2*u[3])+(((-4*Iy)+4*Iz)*du[3]*sin(2*u[2])*cos(u[3])+((-8*Iy)+8*Iz)*du[2]*cos(2*u[2])*sin(u[3])+(((-2*Iy)+2*Iz)*du[4]+((-2*Iy)+2*Iz)*du[4]*cos(2*u[2]))*sin(2*u[3]))*cos(u[4])+((4*Iy-4*Iz)*du[4]*sin(2*u[2])*sin(u[3])+(((-4*Iy)+4*Iz)*du[3]+((-4*Iy)+4*Iz)*du[3]*cos(2*u[2]))*cos(2*u[3])+(4*Iy-4*Iz)*du[2]*sin(2*u[2])*sin(2*u[3]))*sin(u[4])+(((-Iy)+Iz)*du[5]+(3*Iy-3*Iz)*du[5]*cos(2*u[2])+((Iy-Iz)*du[5]+(Iy-Iz)*du[5]*cos(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+((-4*Iy)+4*Iz)*du[5]*sin(2*u[2])*cos(u[3])*sin(2*u[4]))*sin(2*u[5]))
    c12=(1/8)*(((-8*Is)-4*Ix-2*Iy-2*Iz)*du[3]*cos(u[2])+((-4*Iy)-4*Iz)*du[4]*sin(u[2])*sin(u[3])+((-4*Ix)+2*Iy+2*Iz)*du[3]*cos(u[2])*cos(2*u[3])+(2*Ix-Iy-Iz)*du[2]*sin(u[2])*sin(2*u[3])-8*Ix*du[5]*sin(u[2])*cos(u[3])*cos(u[4])-8*Ix*du[5]*cos(u[2])*sin(u[4])+((4*Ix-2*Iy-2*Iz)*du[3]*cos(u[2])+(8*Ix-4*Iy-4*Iz)*du[4]*sin(u[2])*sin(u[3])+((-4*Ix)+2*Iy+2*Iz)*du[3]*cos(u[2])*cos(2*u[3])+(2*Ix-Iy-Iz)*du[2]*sin(u[2])*sin(2*u[3]))*cos(2*u[4])+((4*Ix-2*Iy-2*Iz)*du[2]*cos(u[2])*sin(u[3])+(4*Ix-2*Iy-2*Iz)*du[4]*cos(u[2])*sin(2*u[3]))*sin(2*u[4])+((2*Iy-2*Iz)*du[3]*cos(u[2])+((-4*Iy)+4*Iz)*du[4]*sin(u[2])*sin(u[3])+(6*Iy-6*Iz)*du[3]*cos(u[2])*cos(2*u[3])+((-3*Iy)+3*Iz)*du[2]*sin(u[2])*sin(2*u[3])+(8*Iy-8*Iz)*du[5]*sin(u[2])*cos(u[3])*cos(u[4])+(8*Iy-8*Iz)*du[5]*cos(u[2])*cos(2*u[3])*sin(u[4])+((2*Iy-2*Iz)*du[3]*cos(u[2])+(4*Iy-4*Iz)*du[4]*sin(u[2])*sin(u[3])+((-2*Iy)+2*Iz)*du[3]*cos(u[2])*cos(2*u[3])+(Iy-Iz)*du[2]*sin(u[2])*sin(2*u[3]))*cos(2*u[4])+((2*Iy-2*Iz)*du[2]*cos(u[2])*sin(u[3])+(2*Iy-2*Iz)*du[4]*cos(u[2])*sin(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+(((-6*Iy)+6*Iz)*du[5]*cos(u[2])*sin(2*u[3])+((4*Iy-4*Iz)*du[4]*cos(u[2])+(4*Iy-4*Iz)*du[2]*cos(u[2])*cos(u[3])+(4*Iy-4*Iz)*du[4]*cos(u[2])*cos(2*u[3]))*cos(u[4])+(((-8*Iy)+8*Iz)*du[4]*sin(u[2])*cos(u[3])+((-4*Iy)+4*Iz)*du[2]*sin(u[2])*cos(2*u[3])+((-8*Iy)+8*Iz)*du[3]*cos(u[2])*sin(2*u[3]))*sin(u[4])+(2*Iy-2*Iz)*du[5]*cos(u[2])*sin(2*u[3])*cos(2*u[4])+((-4*Iy)+4*Iz)*du[5]*sin(u[2])*sin(u[3])*sin(2*u[4]))*sin(2*u[5]))
    c13=(1/4)*((2*Iy+2*Iz)*du[4]*cos(u[2])*cos(u[3])-4*Ix*du[5]*cos(u[2])*sin(u[3])*cos(u[4])+(4*Ix-2*Iy-2*Iz)*du[4]*cos(u[2])*cos(u[3])*cos(2*u[4])+(((-4*Ix)+2*Iy+2*Iz)*du[4]*sin(u[2])+((-2*Ix)+Iy+Iz)*du[3]*cos(u[2])*sin(u[3]))*sin(2*u[4])+((2*Iy-2*Iz)*du[4]*cos(u[2])*cos(u[3])+((-4*Iy)+4*Iz)*du[5]*cos(u[2])*sin(u[3])*cos(u[4])+(2*Iy-2*Iz)*du[4]*cos(u[2])*cos(u[3])*cos(2*u[4])+(((-2*Iy)+2*Iz)*du[4]*sin(u[2])+((-Iy)+Iz)*du[3]*cos(u[2])*sin(u[3]))*sin(2*u[4]))*cos(2*u[5])+(((-2*Iy)+2*Iz)*du[5]*sin(u[2])+((-2*Iy)+2*Iz)*du[3]*cos(u[2])*cos(u[3])*cos(u[4])+((-2*Iy)+2*Iz)*du[5]*sin(u[2])*cos(2*u[4])+((-2*Iy)+2*Iz)*du[5]*cos(u[2])*cos(u[3])*sin(2*u[4]))*sin(2*u[5]))
    c14=(1/2)*((-2*Ix*du[5]*sin(u[2])*cos(u[4]))-2*Ix*du[5]*cos(u[2])*cos(u[3])*sin(u[4])+((2*Iy-2*Iz)*du[5]*sin(u[2])*cos(u[4])+(2*Iy-2*Iz)*du[5]*cos(u[2])*cos(u[3])*sin(u[4]))*cos(2*u[5])+(((-2*Iy)+2*Iz)*du[5]*cos(u[2])*sin(u[3])+(Iy-Iz)*du[4]*cos(u[2])*cos(u[3])*cos(u[4])+((-Iy)+Iz)*du[4]*sin(u[2])*sin(u[4]))*sin(2*u[5]))
    c15=0
    
    c21=(1/16)*((16*Is+8*Ix+4*Iy+4*Iz)*du[3]*cos(u[2])+((-2*Ix)+Iy+Iz)*du[1]*sin(2*u[2])+(8*Iy+8*Iz)*du[4]*sin(u[2])*sin(u[3])+(((-8*Ix)+4*Iy+4*Iz)*du[3]*cos(u[2])+(2*Ix-Iy-Iz)*du[1]*sin(2*u[2]))*cos(2*u[3])+16*Ix*du[5]*sin(u[2])*cos(u[3])*cos(u[4])+16*Ix*du[5]*cos(u[2])*sin(u[4])+(((-8*Ix)+4*Iy+4*Iz)*du[3]*cos(u[2])+(6*Ix-3*Iy-3*Iz)*du[1]*sin(2*u[2])+(16*Ix-8*Iy-8*Iz)*du[4]*sin(u[2])*sin(u[3])+(((-8*Ix)+4*Iy+4*Iz)*du[3]*cos(u[2])+(2*Ix-Iy-Iz)*du[1]*sin(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+(((16*Ix-8*Iy-8*Iz)*du[3]*sin(u[2])+(8*Ix-4*Iy-4*Iz)*du[1]*cos(2*u[2]))*cos(u[3])+(8*Ix-4*Iy-4*Iz)*du[4]*cos(u[2])*sin(2*u[3]))*sin(2*u[4])+(((-4*Iy)+4*Iz)*du[3]*cos(u[2])+(3*Iy-3*Iz)*du[1]*sin(2*u[2])+(8*Iy-8*Iz)*du[4]*sin(u[2])*sin(u[3])+((12*Iy-12*Iz)*du[3]*cos(u[2])+((-3*Iy)+3*Iz)*du[1]*sin(2*u[2]))*cos(2*u[3])+(16*Iy-16*Iz)*du[5]*sin(u[2])*cos(u[3])*cos(u[4])+(16*Iy-16*Iz)*du[5]*cos(u[2])*cos(2*u[3])*sin(u[4])+(((-4*Iy)+4*Iz)*du[3]*cos(u[2])+(3*Iy-3*Iz)*du[1]*sin(2*u[2])+(8*Iy-8*Iz)*du[4]*sin(u[2])*sin(u[3])+(((-4*Iy)+4*Iz)*du[3]*cos(u[2])+(Iy-Iz)*du[1]*sin(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+(((8*Iy-8*Iz)*du[3]*sin(u[2])+(4*Iy-4*Iz)*du[1]*cos(2*u[2]))*cos(u[3])+(4*Iy-4*Iz)*du[4]*cos(u[2])*sin(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+(((-12*Iy)+12*Iz)*du[5]*cos(u[2])*sin(2*u[3])+(((-8*Iy)+8*Iz)*du[4]*cos(u[2])+(((-16*Iy)+16*Iz)*du[3]*sin(u[2])+((-8*Iy)+8*Iz)*du[1]*cos(2*u[2]))*sin(u[3])+(8*Iy-8*Iz)*du[4]*cos(u[2])*cos(2*u[3]))*cos(u[4])+(((-16*Iy)+16*Iz)*du[3]*cos(u[2])+(4*Iy-4*Iz)*du[1]*sin(2*u[2]))*sin(2*u[3])*sin(u[4])+(4*Iy-4*Iz)*du[5]*cos(u[2])*sin(2*u[3])*cos(2*u[4])+((-8*Iy)+8*Iz)*du[5]*sin(u[2])*sin(u[3])*sin(2*u[4]))*sin(2*u[5]))
    c22=-(1/4)*(((-2*Ix)+Iy+Iz)*du[3]*sin(2*u[3])+((-2*Ix)+Iy+Iz)*du[3]*sin(2*u[3])*cos(2*u[4])+((2*Ix-Iy-Iz)*du[4]+((-2*Ix)+Iy+Iz)*du[4]*cos(2*u[3]))*sin(2*u[4])+((3*Iy-3*Iz)*du[3]*sin(2*u[3])+(4*Iy-4*Iz)*du[5]*sin(2*u[3])*sin(u[4])+((-Iy)+Iz)*du[3]*sin(2*u[3])*cos(2*u[4])+((Iy-Iz)*du[4]+((-Iy)+Iz)*du[4]*cos(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+((Iy-Iz)*du[5]+(3*Iy-3*Iz)*du[5]*cos(2*u[3])+(2*Iy-2*Iz)*du[4]*sin(2*u[3])*cos(u[4])+(4*Iy-4*Iz)*du[3]*cos(2*u[3])*sin(u[4])+((Iy-Iz)*du[5]+((-Iy)+Iz)*du[5]*cos(2*u[3]))*cos(2*u[4]))*sin(2*u[5]))
    c23=-(1/4)*((2*Iy+2*Iz)*du[4]*sin(u[3])+4*Ix*du[5]*cos(u[3])*cos(u[4])+(4*Ix-2*Iy-2*Iz)*du[4]*sin(u[3])*cos(2*u[4])+(2*Ix-Iy-Iz)*du[3]*cos(u[3])*sin(2*u[4])+((2*Iy-2*Iz)*du[4]*sin(u[3])+(4*Iy-4*Iz)*du[5]*cos(u[3])*cos(u[4])+(2*Iy-2*Iz)*du[4]*sin(u[3])*cos(2*u[4])+(Iy-Iz)*du[3]*cos(u[3])*sin(2*u[4]))*cos(2*u[5])+(((-2*Iy)+2*Iz)*du[3]*sin(u[3])*cos(u[4])+((-2*Iy)+2*Iz)*du[5]*sin(u[3])*sin(2*u[4]))*sin(2*u[5]))
    c24=(1/2)*(2*Ix*du[5]*sin(u[3])*sin(u[4])+((-2*Iy)+2*Iz)*du[5]*sin(u[3])*sin(u[4])*cos(2*u[5])+(((-2*Iy)+2*Iz)*du[5]*cos(u[3])+((-Iy)+Iz)*du[4]*sin(u[3])*cos(u[4]))*sin(2*u[5]))
    c25=0
    
    c31=(1/16)*(((-16*Is)-8*Ix-4*Iy-4*Iz)*du[2]*cos(u[2])+((-8*Iy)-8*Iz)*du[4]*cos(u[2])*cos(u[3])+(8*Ix-4*Iy-4*Iz)*du[2]*cos(u[2])*cos(2*u[3])+((2*Ix-Iy-Iz)*du[1]+(2*Ix-Iy-Iz)*du[1]*cos(2*u[2]))*sin(2*u[3])+16*Ix*du[5]*cos(u[2])*sin(u[3])*cos(u[4])+((8*Ix-4*Iy-4*Iz)*du[2]*cos(u[2])+(16*Ix-8*Iy-8*Iz)*du[4]*cos(u[2])*cos(u[3])+(8*Ix-4*Iy-4*Iz)*du[2]*cos(u[2])*cos(2*u[3])+((2*Ix-Iy-Iz)*du[1]+(2*Ix-Iy-Iz)*du[1]*cos(2*u[2]))*sin(2*u[3]))*cos(2*u[4])+(((-16*Ix)+8*Iy+8*Iz)*du[4]*sin(u[2])+((-16*Ix)+8*Iy+8*Iz)*du[2]*sin(u[2])*cos(u[3])+((-4*Ix)+2*Iy+2*Iz)*du[1]*sin(2*u[2])*sin(u[3]))*sin(2*u[4])+((4*Iy-4*Iz)*du[2]*cos(u[2])+((-8*Iy)+8*Iz)*du[4]*cos(u[2])*cos(u[3])+((-12*Iy)+12*Iz)*du[2]*cos(u[2])*cos(2*u[3])+(((-3*Iy)+3*Iz)*du[1]+((-3*Iy)+3*Iz)*du[1]*cos(2*u[2]))*sin(2*u[3])+((-16*Iy)+16*Iz)*du[5]*cos(u[2])*sin(u[3])*cos(u[4])+((4*Iy-4*Iz)*du[2]*cos(u[2])+(8*Iy-8*Iz)*du[4]*cos(u[2])*cos(u[3])+(4*Iy-4*Iz)*du[2]*cos(u[2])*cos(2*u[3])+((Iy-Iz)*du[1]+(Iy-Iz)*du[1]*cos(2*u[2]))*sin(2*u[3]))*cos(2*u[4])+(((-8*Iy)+8*Iz)*du[4]*sin(u[2])+((-8*Iy)+8*Iz)*du[2]*sin(u[2])*cos(u[3])+((-2*Iy)+2*Iz)*du[1]*sin(2*u[2])*sin(u[3]))*sin(2*u[4]))*cos(2*u[5])+(((-8*Iy)+8*Iz)*du[5]*sin(u[2])+(((-4*Iy)+4*Iz)*du[1]*sin(2*u[2])*cos(u[3])+(16*Iy-16*Iz)*du[2]*sin(u[2])*sin(u[3]))*cos(u[4])+((16*Iy-16*Iz)*du[4]*cos(u[2])*sin(u[3])+(((-4*Iy)+4*Iz)*du[1]+((-4*Iy)+4*Iz)*du[1]*cos(2*u[2]))*cos(2*u[3])+(16*Iy-16*Iz)*du[2]*cos(u[2])*sin(2*u[3]))*sin(u[4])+((-8*Iy)+8*Iz)*du[5]*sin(u[2])*cos(2*u[4])+((-8*Iy)+8*Iz)*du[5]*cos(u[2])*cos(u[3])*sin(2*u[4]))*sin(2*u[5]))
    c32=-(1/8)*(((-4*Iy)-4*Iz)*du[4]*sin(u[3])+(2*Ix-Iy-Iz)*du[2]*sin(2*u[3])-8*Ix*du[5]*cos(u[3])*cos(u[4])+((8*Ix-4*Iy-4*Iz)*du[4]*sin(u[3])+(2*Ix-Iy-Iz)*du[2]*sin(2*u[3]))*cos(2*u[4])+(((-4*Iy)+4*Iz)*du[4]*sin(u[3])+((-3*Iy)+3*Iz)*du[2]*sin(2*u[3])+(8*Iy-8*Iz)*du[5]*cos(u[3])*cos(u[4])+((4*Iy-4*Iz)*du[4]*sin(u[3])+(Iy-Iz)*du[2]*sin(2*u[3]))*cos(2*u[4]))*cos(2*u[5])+((((-8*Iy)+8*Iz)*du[4]*cos(u[3])+((-4*Iy)+4*Iz)*du[2]*cos(2*u[3]))*sin(u[4])+((-4*Iy)+4*Iz)*du[5]*sin(u[3])*sin(2*u[4]))*sin(2*u[5]))
    c33=-(1/2)*(((-2*Ix)+Iy+Iz)*du[4]*sin(2*u[4])+((-Iy)+Iz)*du[4]*sin(2*u[4])*cos(2*u[5])+(((-Iy)+Iz)*du[5]+((-Iy)+Iz)*du[5]*cos(2*u[4]))*sin(2*u[5]))
    c34=-(1/2)*((-2*Ix*du[5]*cos(u[4]))+(2*Iy-2*Iz)*du[5]*cos(u[4])*cos(2*u[5])+((-Iy)+Iz)*du[4]*sin(u[4])*sin(2*u[5]))
    c35=0
    
    c41=-(1/16)*(((-8*Iy)-8*Iz)*du[3]*cos(u[2])*cos(u[3])+(8*Iy+8*Iz)*du[2]*sin(u[2])*sin(u[3])-16*Ix*du[5]*sin(u[2])*cos(u[4])-16*Ix*du[5]*cos(u[2])*cos(u[3])*sin(u[4])+(((16*Ix-8*Iy-8*Iz)*du[3]*cos(u[2])+((-8*Ix)+4*Iy+4*Iz)*du[1]*sin(2*u[2]))*cos(u[3])+(16*Ix-8*Iy-8*Iz)*du[2]*sin(u[2])*sin(u[3]))*cos(2*u[4])+((2*Ix-Iy-Iz)*du[1]+((-16*Ix)+8*Iy+8*Iz)*du[3]*sin(u[2])+((-6*Ix)+3*Iy+3*Iz)*du[1]*cos(2*u[2])+(((-2*Ix)+Iy+Iz)*du[1]+((-2*Ix)+Iy+Iz)*du[1]*cos(2*u[2]))*cos(2*u[3])+(8*Ix-4*Iy-4*Iz)*du[2]*cos(u[2])*sin(2*u[3]))*sin(2*u[4])+(((-8*Iy)+8*Iz)*du[3]*cos(u[2])*cos(u[3])+(8*Iy-8*Iz)*du[2]*sin(u[2])*sin(u[3])+((-16*Iy)+16*Iz)*du[5]*sin(u[2])*cos(u[4])+((-16*Iy)+16*Iz)*du[5]*cos(u[2])*cos(u[3])*sin(u[4])+(((8*Iy-8*Iz)*du[3]*cos(u[2])+((-4*Iy)+4*Iz)*du[1]*sin(2*u[2]))*cos(u[3])+(8*Iy-8*Iz)*du[2]*sin(u[2])*sin(u[3]))*cos(2*u[4])+((Iy-Iz)*du[1]+((-8*Iy)+8*Iz)*du[3]*sin(u[2])+((-3*Iy)+3*Iz)*du[1]*cos(2*u[2])+(((-Iy)+Iz)*du[1]+((-Iy)+Iz)*du[1]*cos(2*u[2]))*cos(2*u[3])+(4*Iy-4*Iz)*du[2]*cos(u[2])*sin(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+((16*Iy-16*Iz)*du[5]*cos(u[2])*sin(u[3])+(((-8*Iy)+8*Iz)*du[2]*cos(u[2])+(8*Iy-8*Iz)*du[2]*cos(u[2])*cos(2*u[3])+((2*Iy-2*Iz)*du[1]+(2*Iy-2*Iz)*du[1]*cos(2*u[2]))*sin(2*u[3]))*cos(u[4])+((16*Iy-16*Iz)*du[3]*cos(u[2])+((-4*Iy)+4*Iz)*du[1]*sin(2*u[2]))*sin(u[3])*sin(u[4]))*sin(2*u[5]))
    c42=(1/8)*(((-4*Iy)-4*Iz)*du[3]*sin(u[3])-8*Ix*du[5]*sin(u[3])*sin(u[4])+(8*Ix-4*Iy-4*Iz)*du[3]*sin(u[3])*cos(2*u[4])+((2*Ix-Iy-Iz)*du[2]+((-2*Ix)+Iy+Iz)*du[2]*cos(2*u[3]))*sin(2*u[4])+(((-4*Iy)+4*Iz)*du[3]*sin(u[3])+((-8*Iy)+8*Iz)*du[5]*sin(u[3])*sin(u[4])+(4*Iy-4*Iz)*du[3]*sin(u[3])*cos(2*u[4])+((Iy-Iz)*du[2]+((-Iy)+Iz)*du[2]*cos(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+(((-8*Iy)+8*Iz)*du[5]*cos(u[3])+(2*Iy-2*Iz)*du[2]*sin(2*u[3])*cos(u[4])+((-8*Iy)+8*Iz)*du[3]*cos(u[3])*sin(u[4]))*sin(2*u[5]))
    c43=(1/4)*((-4*Ix*du[5]*cos(u[4]))+((-2*Ix)+Iy+Iz)*du[3]*sin(2*u[4])+(((-4*Iy)+4*Iz)*du[5]*cos(u[4])+((-Iy)+Iz)*du[3]*sin(2*u[4]))*cos(2*u[5]))
    c44=((-Iy)+Iz)*du[5]*sin(2*u[5])
    
    c45=0
    
    c51=-(1/16)*((16*Ix*du[4]*sin(u[2])+16*Ix*du[2]*sin(u[2])*cos(u[3])+16*Ix*du[3]*cos(u[2])*sin(u[3]))*cos(u[4])+(16*Ix*du[2]*cos(u[2])+16*Ix*du[4]*cos(u[2])*cos(u[3]))*sin(u[4])+(((16*Iy-16*Iz)*du[4]*sin(u[2])+(16*Iy-16*Iz)*du[2]*sin(u[2])*cos(u[3])+(((-16*Iy)+16*Iz)*du[3]*cos(u[2])+(8*Iy-8*Iz)*du[1]*sin(2*u[2]))*sin(u[3]))*cos(u[4])+((16*Iy-16*Iz)*du[4]*cos(u[2])*cos(u[3])+(16*Iy-16*Iz)*du[2]*cos(u[2])*cos(2*u[3])+((4*Iy-4*Iz)*du[1]+(4*Iy-4*Iz)*du[1]*cos(2*u[2]))*sin(2*u[3]))*sin(u[4]))*cos(2*u[5])+((Iy-Iz)*du[1]+((-8*Iy)+8*Iz)*du[3]*sin(u[2])+((-3*Iy)+3*Iz)*du[1]*cos(2*u[2])+((-16*Iy)+16*Iz)*du[4]*cos(u[2])*sin(u[3])+((3*Iy-3*Iz)*du[1]+(3*Iy-3*Iz)*du[1]*cos(2*u[2]))*cos(2*u[3])+((-12*Iy)+12*Iz)*du[2]*cos(u[2])*sin(2*u[3])+((Iy-Iz)*du[1]+((-8*Iy)+8*Iz)*du[3]*sin(u[2])+((-3*Iy)+3*Iz)*du[1]*cos(2*u[2])+(((-Iy)+Iz)*du[1]+((-Iy)+Iz)*du[1]*cos(2*u[2]))*cos(2*u[3])+(4*Iy-4*Iz)*du[2]*cos(u[2])*sin(2*u[3]))*cos(2*u[4])+((((-8*Iy)+8*Iz)*du[3]*cos(u[2])+(4*Iy-4*Iz)*du[1]*sin(2*u[2]))*cos(u[3])+((-8*Iy)+8*Iz)*du[2]*sin(u[2])*sin(u[3]))*sin(2*u[4]))*sin(2*u[5]))
    c52=(1/8)*((-8*Ix*du[3]*cos(u[3])*cos(u[4]))+8*Ix*du[4]*sin(u[3])*sin(u[4])+((8*Iy-8*Iz)*du[3]*cos(u[3])*cos(u[4])+((8*Iy-8*Iz)*du[4]*sin(u[3])+(4*Iy-4*Iz)*du[2]*sin(2*u[3]))*sin(u[4]))*cos(2*u[5])+((Iy-Iz)*du[2]+(8*Iy-8*Iz)*du[4]*cos(u[3])+(3*Iy-3*Iz)*du[2]*cos(2*u[3])+((Iy-Iz)*du[2]+((-Iy)+Iz)*du[2]*cos(2*u[3]))*cos(2*u[4])+((-4*Iy)+4*Iz)*du[3]*sin(u[3])*sin(2*u[4]))*sin(2*u[5]))
    c53=(1/4)*(4*Ix*du[4]*cos(u[4])+(4*Iy-4*Iz)*du[4]*cos(u[4])*cos(2*u[5])+(((-Iy)+Iz)*du[3]+((-Iy)+Iz)*du[3]*cos(2*u[4]))*sin(2*u[5]))
    c54=-(1/2)*((-Iy)+Iz)*du[4]*sin(2*u[5])
    
    c55=0


    M=[m11 m12 m13 m14 m15;m21 m22 m23 m24 m25;m31 m32 m33 m34 m35;m41 m42 m43 m44 m45;m51 m52 m53 m54 m55]
    C=[c11 c12 c13 c14 c15;c21 c22 c23 c24 c25;c31 c32 c33 c34 c35;c41 c42 c43 c44 c45;c51 c52 c53 c54 c55]

    ddu = inv(M)*(-C*du)

    end

    u1_0  = 0.0
    du1_0 = 0.0
    
    u2_0  = 0.0
    du2_0 = 0.0
    
    u3_0  = 0.0
    du3_0 = 0.0

    u4_0  = 0.0
    du4_0 = 0.0

    u5_0  = pi/2
    du5_0 = 0.0
    
    u0=[u1_0,u2_0,u3_0,u4_0,u5_0]
    du0=[du1_0,du2_0,du3_0,du4_0,du5_0]
    tspan = (0.0,100)

    prob=SecondOrderODEProblem(rotor,du0,u0,tspan,dt=0.001,saveat=0.001)
    global sol = solve(prob)

    df=DataFrame(sol)
    json_str = JSON.json(df)

open("./Prototipo/simulaciones/datos_GCMRA_PRIMSA.json", "w") do io
    write(io, json_str)
end  

    pos=plot(sol,idxs=[6,7,8,9,10],label=[L"$x_1$" L"$x_2$" L"$x_3$" L"$x_4$" L"$x_5$"],linewidth=2) 
    
    vel=plot(sol,idxs=[1,2,3,4,5],label=[L"$x_6$" L"$x_7$" L"$x_8$" L"$x_9$" L"$x_10$"],linewidth=2)

    display(vel)
    display(pos)
    