using DifferentialEquations
using LinearAlgebra
#using Plots
using LaTeXStrings
using SciMLBase
using SimulationLogs
using JSON
using DataFrames
using PlotlyJS
using ForwardDiff
using Symbolics
#PARAMETROS
    #simulacion
    t = 1000.0
    tspan = (0.0,t)

    savetimes = 0.0:0.01:t;
function rotor(du,u,p,t)
    θᵈ,vᵈ  = p
    #satelite
    Ixs = 33.581e-3
    Iys = 33.147e-3
    Izs = 6.921e-3
    
    # Gimball #-6, con -3 no hay inestabilidad 
    Ixg = 3.77e-3
    Iyg = 2.74e-3
    Izg = 6.49e-3
    #
    ##primsa normal #-7
    #Ix = 3.502e-7
    #Iy = 4.084e-7
    #Iz = 1.052e-7  

    #Prisma con agujero #-6
    Ix = 3.250e-3
    Iy = 4.681e-3
    Iz = 6.909e-3
    
    m11 = -(1/16)*((-6*Ix)-6*Ixg-4*Ixs-5*Iy-4*Iyg-5*Iz-6*Izg-8*Izs+(2*Ix+2*Ixg-4*Ixs-Iy-4*Iyg-Iz+2*Izg+8*Izs)*cos(2*u[2])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*cos(2*u[2]))*cos(2*u[3])+(2*Ix+2*Ixg-Iy-Iz-2*Izg+((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*cos(2*u[2])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+(8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*sin(2*u[2])*cos(u[3])*sin(2*u[4])+(Iy-Iz+((-3*Iy)+3*Iz)*cos(2*u[2])+(3*Iy-3*Iz+(3*Iy-3*Iz)*cos(2*u[2]))*cos(2*u[3])+(Iy-Iz+((-3*Iy)+3*Iz)*cos(2*u[2])+((-Iy)+Iz+((-Iy)+Iz)*cos(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+(4*Iy-4*Iz)*sin(2*u[2])*cos(u[3])*sin(2*u[4]))*cos(2*u[5])+(((-8*Iy)+8*Iz)*sin(2*u[2])*sin(u[3])*cos(u[4])+((-4*Iy)+4*Iz+((-4*Iy)+4*Iz)*cos(2*u[2]))*sin(2*u[3])*sin(u[4]))*sin(2*u[5])+((-4)-4*cos(2*u[2])+(4+4*cos(2*u[2]))*cos(2*u[3]))*Iys) 
    m12 = (1/8)*(((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*cos(u[2])*sin(2*u[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(u[2])*sin(2*u[3])*cos(2*u[4])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*sin(u[2])*sin(u[3])*sin(2*u[4])+((3*Iy-3*Iz)*cos(u[2])*sin(2*u[3])+((-Iy)+Iz)*cos(u[2])*sin(2*u[3])*cos(2*u[4])+(2*Iy-2*Iz)*sin(u[2])*sin(u[3])*sin(2*u[4]))*cos(2*u[5])+((4*Iy-4*Iz)*sin(u[2])*cos(u[3])*cos(u[4])+(4*Iy-4*Iz)*cos(u[2])*cos(2*u[3])*sin(u[4]))*sin(2*u[5])+4*cos(u[2])*sin(2*u[3])*Iys) 
    m13 = (1/4)*(((-2*Ix)-2*Ixg-Iy-Iz-2*Izg-4*Izs)*sin(u[2])+(2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(u[2])*cos(2*u[4])+(2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(u[2])*cos(u[3])*sin(2*u[4])+((Iy-Iz)*sin(u[2])+(Iy-Iz)*sin(u[2])*cos(2*u[4])+(Iy-Iz)*cos(u[2])*cos(u[3])*sin(2*u[4]))*cos(2*u[5])+((-2*Iy)+2*Iz)*cos(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])) 
    m14 = -(1/2)*(((-Iy)-2*Iyg-Iz)*cos(u[2])*sin(u[3])+((-Iy)+Iz)*cos(u[2])*sin(u[3])*cos(2*u[5])+(((-Iy)+Iz)*sin(u[2])*cos(u[4])+((-Iy)+Iz)*cos(u[2])*cos(u[3])*sin(u[4]))*sin(2*u[5])) 
    m15 = Ix*cos(u[2])*cos(u[3])*cos(u[4])-Ix*sin(u[2])*sin(u[4]) 
    
    m22 = (1/8)*(2*Ix+2*Ixg+4*Ixs+3*Iy+4*Iyg+3*Iz+2*Izg+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*cos(2*u[3])+(2*Ix+2*Ixg-Iy-Iz-2*Izg+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*u[3]))*cos(2*u[4])+(Iy-Iz+(3*Iy-3*Iz)*cos(2*u[3])+(Iy-Iz+((-Iy)+Iz)*cos(2*u[3]))*cos(2*u[4]))*cos(2*u[5])+((-4*Iy)+4*Iz)*sin(2*u[3])*sin(u[4])*sin(2*u[5])+(4+4*cos(2*u[3]))*Iys) 
    m23 = (1/4)*(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(u[3])*sin(2*u[4])+((-Iy)+Iz)*sin(u[3])*sin(2*u[4])*cos(2*u[5])+((-2*Iy)+2*Iz)*cos(u[3])*cos(u[4])*sin(2*u[5])) 
    m24 = (1/2)*((Iy+2*Iyg+Iz)*cos(u[3])+(Iy-Iz)*cos(u[3])*cos(2*u[5])+((-Iy)+Iz)*sin(u[3])*sin(u[4])*sin(2*u[5])) 
    m25 = -Ix*sin(u[3])*cos(u[4]) 
    
    m33 = (1/4)*(2*Ix+2*Ixg+Iy+Iz+2*Izg+4*Izs+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*u[4])+((-Iy)+Iz+((-Iy)+Iz)*cos(2*u[4]))*cos(2*u[5])) 
    m34 = (1/2)*((-Iy)+Iz)*cos(u[4])*sin(2*u[5]) 
    m35 = Ix*sin(u[4])   

    m44 = -(1/2)*((-Iy)-2*Iyg-Iz+((-Iy)+Iz)*cos(2*u[5])) 
    m45 = 0 
   
    m55 = Ix 
        
    #Sistema original
    c11 = (1/8)*((2*Ix+2*Ixg-4*Ixs-Iy-4*Iyg-Iz+2*Izg+8*Izs)*du[2]*sin(2*u[2])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[2]*sin(2*u[2])*cos(2*u[3])+(((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[3]+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[3]*cos(2*u[2]))*sin(2*u[3])+(((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*du[2]*sin(2*u[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[4]*sin(2*u[2])*cos(u[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[2]*sin(2*u[2])*cos(2*u[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[3]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[3]*cos(2*u[2]))*sin(2*u[3]))*cos(2*u[4])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*du[4]+((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*du[4]*cos(2*u[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[2]*cos(2*u[2])*cos(u[3])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*du[3]*sin(2*u[2])*sin(u[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[4]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[4]*cos(2*u[2]))*cos(2*u[3]))*sin(2*u[4])+(((-3*Iy)+3*Iz)*du[2]*sin(2*u[2])+(3*Iy-3*Iz)*du[2]*sin(2*u[2])*cos(2*u[3])+((3*Iy-3*Iz)*du[3]+(3*Iy-3*Iz)*du[3]*cos(2*u[2]))*sin(2*u[3])+(8*Iy-8*Iz)*du[5]*sin(2*u[2])*sin(u[3])*cos(u[4])+((4*Iy-4*Iz)*du[5]+(4*Iy-4*Iz)*du[5]*cos(2*u[2]))*sin(2*u[3])*sin(u[4])+(((-3*Iy)+3*Iz)*du[2]*sin(2*u[2])+((-4*Iy)+4*Iz)*du[4]*sin(2*u[2])*cos(u[3])+((-Iy)+Iz)*du[2]*sin(2*u[2])*cos(2*u[3])+(((-Iy)+Iz)*du[3]+((-Iy)+Iz)*du[3]*cos(2*u[2]))*sin(2*u[3]))*cos(2*u[4])+((Iy-Iz)*du[4]+((-3*Iy)+3*Iz)*du[4]*cos(2*u[2])+((-4*Iy)+4*Iz)*du[2]*cos(2*u[2])*cos(u[3])+(2*Iy-2*Iz)*du[3]*sin(2*u[2])*sin(u[3])+(((-Iy)+Iz)*du[4]+((-Iy)+Iz)*du[4]*cos(2*u[2]))*cos(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+((Iy-Iz)*du[5]+((-3*Iy)+3*Iz)*du[5]*cos(2*u[2])+((3*Iy-3*Iz)*du[5]+(3*Iy-3*Iz)*du[5]*cos(2*u[2]))*cos(2*u[3])+((4*Iy-4*Iz)*du[3]*sin(2*u[2])*cos(u[3])+(8*Iy-8*Iz)*du[2]*cos(2*u[2])*sin(u[3])+((2*Iy-2*Iz)*du[4]+(2*Iy-2*Iz)*du[4]*cos(2*u[2]))*sin(2*u[3]))*cos(u[4])+(((-4*Iy)+4*Iz)*du[4]*sin(2*u[2])*sin(u[3])+((4*Iy-4*Iz)*du[3]+(4*Iy-4*Iz)*du[3]*cos(2*u[2]))*cos(2*u[3])+((-4*Iy)+4*Iz)*du[2]*sin(2*u[2])*sin(2*u[3]))*sin(u[4])+((Iy-Iz)*du[5]+((-3*Iy)+3*Iz)*du[5]*cos(2*u[2])+(((-Iy)+Iz)*du[5]+((-Iy)+Iz)*du[5]*cos(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+(4*Iy-4*Iz)*du[5]*sin(2*u[2])*cos(u[3])*sin(2*u[4]))*sin(2*u[5])+((-4*du[2]*sin(2*u[2]))+4*du[2]*sin(2*u[2])*cos(2*u[3])+(4*du[3]+4*du[3]*cos(2*u[2]))*sin(2*u[3]))*Iys) 
    c12 = -(1/8)*((4*Ix+4*Ixg+2*Iy+2*Iz+4*Izg+8*Izs)*du[3]*cos(u[2])+(4*Iy+8*Iyg+4*Iz)*du[4]*sin(u[2])*sin(u[3])+(4*Ix+4*Ixg+8*Ixs-2*Iy-8*Iyg-2*Iz+4*Izg)*du[3]*cos(u[2])*cos(2*u[3])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[2]*sin(u[2])*sin(2*u[3])+8*Ix*du[5]*sin(u[2])*cos(u[3])*cos(u[4])+8*Ix*du[5]*cos(u[2])*sin(u[4])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*du[3]*cos(u[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[4]*sin(u[2])*sin(u[3])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*du[3]*cos(u[2])*cos(2*u[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[2]*sin(u[2])*sin(2*u[3]))*cos(2*u[4])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*du[2]*cos(u[2])*sin(u[3])+((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*du[4]*cos(u[2])*sin(2*u[3]))*sin(2*u[4])+(((-2*Iy)+2*Iz)*du[3]*cos(u[2])+(4*Iy-4*Iz)*du[4]*sin(u[2])*sin(u[3])+((-6*Iy)+6*Iz)*du[3]*cos(u[2])*cos(2*u[3])+(3*Iy-3*Iz)*du[2]*sin(u[2])*sin(2*u[3])+((-8*Iy)+8*Iz)*du[5]*sin(u[2])*cos(u[3])*cos(u[4])+((-8*Iy)+8*Iz)*du[5]*cos(u[2])*cos(2*u[3])*sin(u[4])+(((-2*Iy)+2*Iz)*du[3]*cos(u[2])+((-4*Iy)+4*Iz)*du[4]*sin(u[2])*sin(u[3])+(2*Iy-2*Iz)*du[3]*cos(u[2])*cos(2*u[3])+((-Iy)+Iz)*du[2]*sin(u[2])*sin(2*u[3]))*cos(2*u[4])+(((-2*Iy)+2*Iz)*du[2]*cos(u[2])*sin(u[3])+((-2*Iy)+2*Iz)*du[4]*cos(u[2])*sin(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+((6*Iy-6*Iz)*du[5]*cos(u[2])*sin(2*u[3])+(((-4*Iy)+4*Iz)*du[4]*cos(u[2])+((-4*Iy)+4*Iz)*du[2]*cos(u[2])*cos(u[3])+((-4*Iy)+4*Iz)*du[4]*cos(u[2])*cos(2*u[3]))*cos(u[4])+((8*Iy-8*Iz)*du[4]*sin(u[2])*cos(u[3])+(4*Iy-4*Iz)*du[2]*sin(u[2])*cos(2*u[3])+(8*Iy-8*Iz)*du[3]*cos(u[2])*sin(2*u[3]))*sin(u[4])+((-2*Iy)+2*Iz)*du[5]*cos(u[2])*sin(2*u[3])*cos(2*u[4])+(4*Iy-4*Iz)*du[5]*sin(u[2])*sin(u[3])*sin(2*u[4]))*sin(2*u[5])+((-8*du[3]*cos(u[2])*cos(2*u[3]))+4*du[2]*sin(u[2])*sin(2*u[3]))*Iys) 
    c13 = (1/4)*((2*Iy+4*Iyg+2*Iz)*du[4]*cos(u[2])*cos(u[3])-4*Ix*du[5]*cos(u[2])*sin(u[3])*cos(u[4])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*du[4]*cos(u[2])*cos(u[3])*cos(2*u[4])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*du[4]*sin(u[2])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[3]*cos(u[2])*sin(u[3]))*sin(2*u[4])+((2*Iy-2*Iz)*du[4]*cos(u[2])*cos(u[3])+((-4*Iy)+4*Iz)*du[5]*cos(u[2])*sin(u[3])*cos(u[4])+(2*Iy-2*Iz)*du[4]*cos(u[2])*cos(u[3])*cos(2*u[4])+(((-2*Iy)+2*Iz)*du[4]*sin(u[2])+((-Iy)+Iz)*du[3]*cos(u[2])*sin(u[3]))*sin(2*u[4]))*cos(2*u[5])+(((-2*Iy)+2*Iz)*du[5]*sin(u[2])+((-2*Iy)+2*Iz)*du[3]*cos(u[2])*cos(u[3])*cos(u[4])+((-2*Iy)+2*Iz)*du[5]*sin(u[2])*cos(2*u[4])+((-2*Iy)+2*Iz)*du[5]*cos(u[2])*cos(u[3])*sin(2*u[4]))*sin(2*u[5])) 
    c14 = (1/2)*((-2*Ix*du[5]*sin(u[2])*cos(u[4]))-2*Ix*du[5]*cos(u[2])*cos(u[3])*sin(u[4])+((2*Iy-2*Iz)*du[5]*sin(u[2])*cos(u[4])+(2*Iy-2*Iz)*du[5]*cos(u[2])*cos(u[3])*sin(u[4]))*cos(2*u[5])+(((-2*Iy)+2*Iz)*du[5]*cos(u[2])*sin(u[3])+(Iy-Iz)*du[4]*cos(u[2])*cos(u[3])*cos(u[4])+((-Iy)+Iz)*du[4]*sin(u[2])*sin(u[4]))*sin(2*u[5])) 
    c15 = 0 

    c21 = -(1/16)*(((-8*Ix)-8*Ixg-4*Iy-4*Iz-8*Izg-16*Izs)*du[3]*cos(u[2])+(2*Ix+2*Ixg-4*Ixs-Iy-4*Iyg-Iz+2*Izg+8*Izs)*du[1]*sin(2*u[2])+((-8*Iy)-16*Iyg-8*Iz)*du[4]*sin(u[2])*sin(u[3])+((8*Ix+8*Ixg+16*Ixs-4*Iy-16*Iyg-4*Iz+8*Izg)*du[3]*cos(u[2])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[1]*sin(2*u[2]))*cos(2*u[3])-16*Ix*du[5]*sin(u[2])*cos(u[3])*cos(u[4])-16*Ix*du[5]*cos(u[2])*sin(u[4])+((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*du[3]*cos(u[2])+((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*du[1]*sin(2*u[2])+((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*du[4]*sin(u[2])*sin(u[3])+((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*du[3]*cos(u[2])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[1]*sin(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+((((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*du[3]*sin(u[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[1]*cos(2*u[2]))*cos(u[3])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[4]*cos(u[2])*sin(2*u[3]))*sin(2*u[4])+((4*Iy-4*Iz)*du[3]*cos(u[2])+((-3*Iy)+3*Iz)*du[1]*sin(2*u[2])+((-8*Iy)+8*Iz)*du[4]*sin(u[2])*sin(u[3])+(((-12*Iy)+12*Iz)*du[3]*cos(u[2])+(3*Iy-3*Iz)*du[1]*sin(2*u[2]))*cos(2*u[3])+((-16*Iy)+16*Iz)*du[5]*sin(u[2])*cos(u[3])*cos(u[4])+((-16*Iy)+16*Iz)*du[5]*cos(u[2])*cos(2*u[3])*sin(u[4])+((4*Iy-4*Iz)*du[3]*cos(u[2])+((-3*Iy)+3*Iz)*du[1]*sin(2*u[2])+((-8*Iy)+8*Iz)*du[4]*sin(u[2])*sin(u[3])+((4*Iy-4*Iz)*du[3]*cos(u[2])+((-Iy)+Iz)*du[1]*sin(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+((((-8*Iy)+8*Iz)*du[3]*sin(u[2])+((-4*Iy)+4*Iz)*du[1]*cos(2*u[2]))*cos(u[3])+((-4*Iy)+4*Iz)*du[4]*cos(u[2])*sin(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+((12*Iy-12*Iz)*du[5]*cos(u[2])*sin(2*u[3])+((8*Iy-8*Iz)*du[4]*cos(u[2])+((16*Iy-16*Iz)*du[3]*sin(u[2])+(8*Iy-8*Iz)*du[1]*cos(2*u[2]))*sin(u[3])+((-8*Iy)+8*Iz)*du[4]*cos(u[2])*cos(2*u[3]))*cos(u[4])+((16*Iy-16*Iz)*du[3]*cos(u[2])+((-4*Iy)+4*Iz)*du[1]*sin(2*u[2]))*sin(2*u[3])*sin(u[4])+((-4*Iy)+4*Iz)*du[5]*cos(u[2])*sin(2*u[3])*cos(2*u[4])+(8*Iy-8*Iz)*du[5]*sin(u[2])*sin(u[3])*sin(2*u[4]))*sin(2*u[5])+((-4*du[1]*sin(2*u[2]))+((-16*du[3]*cos(u[2]))+4*du[1]*sin(2*u[2]))*cos(2*u[3]))*Iys) 
    c22 = -(1/4)*(((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[3]*sin(2*u[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[3]*sin(2*u[3])*cos(2*u[4])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*du[4]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[4]*cos(2*u[3]))*sin(2*u[4])+((3*Iy-3*Iz)*du[3]*sin(2*u[3])+(4*Iy-4*Iz)*du[5]*sin(2*u[3])*sin(u[4])+((-Iy)+Iz)*du[3]*sin(2*u[3])*cos(2*u[4])+((Iy-Iz)*du[4]+((-Iy)+Iz)*du[4]*cos(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+((Iy-Iz)*du[5]+(3*Iy-3*Iz)*du[5]*cos(2*u[3])+(2*Iy-2*Iz)*du[4]*sin(2*u[3])*cos(u[4])+(4*Iy-4*Iz)*du[3]*cos(2*u[3])*sin(u[4])+((Iy-Iz)*du[5]+((-Iy)+Iz)*du[5]*cos(2*u[3]))*cos(2*u[4]))*sin(2*u[5])+4*du[3]*sin(2*u[3])*Iys) 
    c23 = -(1/4)*((2*Iy+4*Iyg+2*Iz)*du[4]*sin(u[3])+4*Ix*du[5]*cos(u[3])*cos(u[4])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*du[4]*sin(u[3])*cos(2*u[4])+(2*Ix+2*Ixg-Iy-Iz-2*Izg)*du[3]*cos(u[3])*sin(2*u[4])+((2*Iy-2*Iz)*du[4]*sin(u[3])+(4*Iy-4*Iz)*du[5]*cos(u[3])*cos(u[4])+(2*Iy-2*Iz)*du[4]*sin(u[3])*cos(2*u[4])+(Iy-Iz)*du[3]*cos(u[3])*sin(2*u[4]))*cos(2*u[5])+(((-2*Iy)+2*Iz)*du[3]*sin(u[3])*cos(u[4])+((-2*Iy)+2*Iz)*du[5]*sin(u[3])*sin(2*u[4]))*sin(2*u[5])) 
    c24 = (1/2)*(2*Ix*du[5]*sin(u[3])*sin(u[4])+((-2*Iy)+2*Iz)*du[5]*sin(u[3])*sin(u[4])*cos(2*u[5])+(((-2*Iy)+2*Iz)*du[5]*cos(u[3])+((-Iy)+Iz)*du[4]*sin(u[3])*cos(u[4]))*sin(2*u[5])) 
    c25 = 0 

    c31 = -(1/16)*((8*Ix+8*Ixg+4*Iy+4*Iz+8*Izg+16*Izs)*du[2]*cos(u[2])+(8*Iy+16*Iyg+8*Iz)*du[4]*cos(u[2])*cos(u[3])+((-8*Ix)-8*Ixg-16*Ixs+4*Iy+16*Iyg+4*Iz-8*Izg)*du[2]*cos(u[2])*cos(2*u[3])+(((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[1]+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[1]*cos(2*u[2]))*sin(2*u[3])-16*Ix*du[5]*cos(u[2])*sin(u[3])*cos(u[4])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[2]*cos(u[2])+((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*du[4]*cos(u[2])*cos(u[3])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[2]*cos(u[2])*cos(2*u[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[1]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[1]*cos(2*u[2]))*sin(2*u[3]))*cos(2*u[4])+((16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*du[4]*sin(u[2])+(16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*du[2]*sin(u[2])*cos(u[3])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*du[1]*sin(2*u[2])*sin(u[3]))*sin(2*u[4])+(((-4*Iy)+4*Iz)*du[2]*cos(u[2])+(8*Iy-8*Iz)*du[4]*cos(u[2])*cos(u[3])+(12*Iy-12*Iz)*du[2]*cos(u[2])*cos(2*u[3])+((3*Iy-3*Iz)*du[1]+(3*Iy-3*Iz)*du[1]*cos(2*u[2]))*sin(2*u[3])+(16*Iy-16*Iz)*du[5]*cos(u[2])*sin(u[3])*cos(u[4])+(((-4*Iy)+4*Iz)*du[2]*cos(u[2])+((-8*Iy)+8*Iz)*du[4]*cos(u[2])*cos(u[3])+((-4*Iy)+4*Iz)*du[2]*cos(u[2])*cos(2*u[3])+(((-Iy)+Iz)*du[1]+((-Iy)+Iz)*du[1]*cos(2*u[2]))*sin(2*u[3]))*cos(2*u[4])+((8*Iy-8*Iz)*du[4]*sin(u[2])+(8*Iy-8*Iz)*du[2]*sin(u[2])*cos(u[3])+(2*Iy-2*Iz)*du[1]*sin(2*u[2])*sin(u[3]))*sin(2*u[4]))*cos(2*u[5])+((8*Iy-8*Iz)*du[5]*sin(u[2])+((4*Iy-4*Iz)*du[1]*sin(2*u[2])*cos(u[3])+((-16*Iy)+16*Iz)*du[2]*sin(u[2])*sin(u[3]))*cos(u[4])+(((-16*Iy)+16*Iz)*du[4]*cos(u[2])*sin(u[3])+((4*Iy-4*Iz)*du[1]+(4*Iy-4*Iz)*du[1]*cos(2*u[2]))*cos(2*u[3])+((-16*Iy)+16*Iz)*du[2]*cos(u[2])*sin(2*u[3]))*sin(u[4])+(8*Iy-8*Iz)*du[5]*sin(u[2])*cos(2*u[4])+(8*Iy-8*Iz)*du[5]*cos(u[2])*cos(u[3])*sin(2*u[4]))*sin(2*u[5])+(16*du[2]*cos(u[2])*cos(2*u[3])+(4*du[1]+4*du[1]*cos(2*u[2]))*sin(2*u[3]))*Iys) 
    c32 = (1/8)*((4*Iy+8*Iyg+4*Iz)*du[4]*sin(u[3])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[2]*sin(2*u[3])+8*Ix*du[5]*cos(u[3])*cos(u[4])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[4]*sin(u[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[2]*sin(2*u[3]))*cos(2*u[4])+((4*Iy-4*Iz)*du[4]*sin(u[3])+(3*Iy-3*Iz)*du[2]*sin(2*u[3])+((-8*Iy)+8*Iz)*du[5]*cos(u[3])*cos(u[4])+(((-4*Iy)+4*Iz)*du[4]*sin(u[3])+((-Iy)+Iz)*du[2]*sin(2*u[3]))*cos(2*u[4]))*cos(2*u[5])+(((8*Iy-8*Iz)*du[4]*cos(u[3])+(4*Iy-4*Iz)*du[2]*cos(2*u[3]))*sin(u[4])+(4*Iy-4*Iz)*du[5]*sin(u[3])*sin(2*u[4]))*sin(2*u[5])+4*du[2]*sin(2*u[3])*Iys) 
    c33 = -(1/2)*(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[4]*sin(2*u[4])+((-Iy)+Iz)*du[4]*sin(2*u[4])*cos(2*u[5])+(((-Iy)+Iz)*du[5]+((-Iy)+Iz)*du[5]*cos(2*u[4]))*sin(2*u[5])) 
    c34 = -(1/2)*((-2*Ix*du[5]*cos(u[4]))+(2*Iy-2*Iz)*du[5]*cos(u[4])*cos(2*u[5])+((-Iy)+Iz)*du[4]*sin(u[4])*sin(2*u[5])) 
    c35 = 0 

    c41 = -(1/16)*(((-8*Iy)-16*Iyg-8*Iz)*du[3]*cos(u[2])*cos(u[3])+(8*Iy+16*Iyg+8*Iz)*du[2]*sin(u[2])*sin(u[3])-16*Ix*du[5]*sin(u[2])*cos(u[4])-16*Ix*du[5]*cos(u[2])*cos(u[3])*sin(u[4])+(((16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*du[3]*cos(u[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[1]*sin(2*u[2]))*cos(u[3])+(16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*du[2]*sin(u[2])*sin(u[3]))*cos(2*u[4])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*du[1]+((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*du[3]*sin(u[2])+((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*du[1]*cos(2*u[2])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[1]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[1]*cos(2*u[2]))*cos(2*u[3])+(8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*du[2]*cos(u[2])*sin(2*u[3]))*sin(2*u[4])+(((-8*Iy)+8*Iz)*du[3]*cos(u[2])*cos(u[3])+(8*Iy-8*Iz)*du[2]*sin(u[2])*sin(u[3])+((-16*Iy)+16*Iz)*du[5]*sin(u[2])*cos(u[4])+((-16*Iy)+16*Iz)*du[5]*cos(u[2])*cos(u[3])*sin(u[4])+(((8*Iy-8*Iz)*du[3]*cos(u[2])+((-4*Iy)+4*Iz)*du[1]*sin(2*u[2]))*cos(u[3])+(8*Iy-8*Iz)*du[2]*sin(u[2])*sin(u[3]))*cos(2*u[4])+((Iy-Iz)*du[1]+((-8*Iy)+8*Iz)*du[3]*sin(u[2])+((-3*Iy)+3*Iz)*du[1]*cos(2*u[2])+(((-Iy)+Iz)*du[1]+((-Iy)+Iz)*du[1]*cos(2*u[2]))*cos(2*u[3])+(4*Iy-4*Iz)*du[2]*cos(u[2])*sin(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+((16*Iy-16*Iz)*du[5]*cos(u[2])*sin(u[3])+(((-8*Iy)+8*Iz)*du[2]*cos(u[2])+(8*Iy-8*Iz)*du[2]*cos(u[2])*cos(2*u[3])+((2*Iy-2*Iz)*du[1]+(2*Iy-2*Iz)*du[1]*cos(2*u[2]))*sin(2*u[3]))*cos(u[4])+((16*Iy-16*Iz)*du[3]*cos(u[2])+((-4*Iy)+4*Iz)*du[1]*sin(2*u[2]))*sin(u[3])*sin(u[4]))*sin(2*u[5])) 
    c42 = (1/8)*(((-4*Iy)-8*Iyg-4*Iz)*du[3]*sin(u[3])-8*Ix*du[5]*sin(u[3])*sin(u[4])+(8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*du[3]*sin(u[3])*cos(2*u[4])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*du[2]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[2]*cos(2*u[3]))*sin(2*u[4])+(((-4*Iy)+4*Iz)*du[3]*sin(u[3])+((-8*Iy)+8*Iz)*du[5]*sin(u[3])*sin(u[4])+(4*Iy-4*Iz)*du[3]*sin(u[3])*cos(2*u[4])+((Iy-Iz)*du[2]+((-Iy)+Iz)*du[2]*cos(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+(((-8*Iy)+8*Iz)*du[5]*cos(u[3])+(2*Iy-2*Iz)*du[2]*sin(2*u[3])*cos(u[4])+((-8*Iy)+8*Iz)*du[3]*cos(u[3])*sin(u[4]))*sin(2*u[5])) 
    c43 = (1/4)*((-4*Ix*du[5]*cos(u[4]))+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[3]*sin(2*u[4])+(((-4*Iy)+4*Iz)*du[5]*cos(u[4])+((-Iy)+Iz)*du[3]*sin(2*u[4]))*cos(2*u[5])) 
    c44 = ((-Iy)+Iz)*du[5]*sin(2*u[5]) 

    c45 = 0 

    c51 = -(1/16)*((16*Ix*du[4]*sin(u[2])+16*Ix*du[2]*sin(u[2])*cos(u[3])+16*Ix*du[3]*cos(u[2])*sin(u[3]))*cos(u[4])+(16*Ix*du[2]*cos(u[2])+16*Ix*du[4]*cos(u[2])*cos(u[3]))*sin(u[4])+(((16*Iy-16*Iz)*du[4]*sin(u[2])+(16*Iy-16*Iz)*du[2]*sin(u[2])*cos(u[3])+(((-16*Iy)+16*Iz)*du[3]*cos(u[2])+(8*Iy-8*Iz)*du[1]*sin(2*u[2]))*sin(u[3]))*cos(u[4])+((16*Iy-16*Iz)*du[4]*cos(u[2])*cos(u[3])+(16*Iy-16*Iz)*du[2]*cos(u[2])*cos(2*u[3])+((4*Iy-4*Iz)*du[1]+(4*Iy-4*Iz)*du[1]*cos(2*u[2]))*sin(2*u[3]))*sin(u[4]))*cos(2*u[5])+((Iy-Iz)*du[1]+((-8*Iy)+8*Iz)*du[3]*sin(u[2])+((-3*Iy)+3*Iz)*du[1]*cos(2*u[2])+((-16*Iy)+16*Iz)*du[4]*cos(u[2])*sin(u[3])+((3*Iy-3*Iz)*du[1]+(3*Iy-3*Iz)*du[1]*cos(2*u[2]))*cos(2*u[3])+((-12*Iy)+12*Iz)*du[2]*cos(u[2])*sin(2*u[3])+((Iy-Iz)*du[1]+((-8*Iy)+8*Iz)*du[3]*sin(u[2])+((-3*Iy)+3*Iz)*du[1]*cos(2*u[2])+(((-Iy)+Iz)*du[1]+((-Iy)+Iz)*du[1]*cos(2*u[2]))*cos(2*u[3])+(4*Iy-4*Iz)*du[2]*cos(u[2])*sin(2*u[3]))*cos(2*u[4])+((((-8*Iy)+8*Iz)*du[3]*cos(u[2])+(4*Iy-4*Iz)*du[1]*sin(2*u[2]))*cos(u[3])+((-8*Iy)+8*Iz)*du[2]*sin(u[2])*sin(u[3]))*sin(2*u[4]))*sin(2*u[5])) 
    c52 = (1/8)*((-8*Ix*du[3]*cos(u[3])*cos(u[4]))+8*Ix*du[4]*sin(u[3])*sin(u[4])+((8*Iy-8*Iz)*du[3]*cos(u[3])*cos(u[4])+((8*Iy-8*Iz)*du[4]*sin(u[3])+(4*Iy-4*Iz)*du[2]*sin(2*u[3]))*sin(u[4]))*cos(2*u[5])+((Iy-Iz)*du[2]+(8*Iy-8*Iz)*du[4]*cos(u[3])+(3*Iy-3*Iz)*du[2]*cos(2*u[3])+((Iy-Iz)*du[2]+((-Iy)+Iz)*du[2]*cos(2*u[3]))*cos(2*u[4])+((-4*Iy)+4*Iz)*du[3]*sin(u[3])*sin(2*u[4]))*sin(2*u[5])) 
    c53 = (1/4)*(4*Ix*du[4]*cos(u[4])+(4*Iy-4*Iz)*du[4]*cos(u[4])*cos(2*u[5])+(((-Iy)+Iz)*du[3]+((-Iy)+Iz)*du[3]*cos(2*u[4]))*sin(2*u[5])) 
    c54 = -(1/2)*((-Iy)+Iz)*du[4]*sin(2*u[5]) 
    
    c55 = 0 

    M=[m11 m12 m13 m14 m15
       m12 m22 m23 m24 m25
       m13 m23 m33 m34 m35
       m14 m24 m34 m44 m45
       m15 m25 m35 m45 m55]

    C=[c11 c12 c13 c14 c15
       c21 c22 c23 c24 c25
       c31 c32 c33 c34 c35
       c41 c42 c43 c44 c45
       c51 c52 c53 c54 c55]
       #CONTROL DE VELOCIDAD
       e1 = du[4] - vᵈ; # Gimbal
       ep1 = du[9];
       
       k₀1 = 1.8e-5 ;#1.8e-2 experimento de comparacion
       k₁1 = 2*sqrt(k₀1) + k₀1;
       v₁ = - (k₀1*e1 + k₁1*ep1 );
       
       e2 = u[5] - θᵈ #Prisma
       ep2 = du[5];
       
       k₀2 = 1.0e-5; #-1 funciona bien sin controlar al gimbal
       k₁2 = 2*sqrt(k₀2) + k₀2 ;
       v₂ = - (k₀2*e2 + k₁2*ep2 );
       v = [v₁
       v₂];
       
    g = inv(M)
    f = (-C * du[1:5] )

    β₁ = g[19];
    β₂ = g[24];
    β₃ = g[20];
    β₄ = g[25];
    
    α₁ = f[4];
    α₂ = f[5];
    
    B = [β₁ β₂
         β₃ β₄];
    
    A = [α₁
         α₂];
    v = [v₁
         v₂];
    τ = B \ (v - A)
    
    
       
    du[1:5] .= u[6:10]     
    du[6:10] .= g * (f + [0;0;0;τ])
end
#Condiciones iniciales

u1_0  = 0.0
du1_0 = 0.0

u2_0  = 0.0
du2_0 = 0.0

u3_0  = 0.0
du3_0 = 0.0

u4_0  = 0.0 #Gimbal interno
du4_0 = 0.0 #110rad/2 = 1050 rpm's

u5_0  = 0.0 # Rotor
du5_0 = 0.0

u0=[u1_0,u2_0,u3_0,u4_0,u5_0]
du0=[du1_0,du2_0,du3_0,du4_0,du5_0]

#Parametros de CONTROL
θᵈ = pi/4;
vᵈ = 110.0;
p = [θᵈ,vᵈ];


prob=ODEProblem(rotor,vcat(u0,du0),tspan,dt=0.01,saveat=0.01,p)


global sol = solve(prob,TRBDF2(),tstops=savetimes)

df=DataFrame(sol)
json_str = JSON.json(df)

open("./Prototipo/simulaciones/datos_GCMRA_PRIMSA.json", "w") do io
    write(io, json_str)
end  

#Posicones
t1 = [u[1] for u in sol.u]
t2 = [u[2] for u in sol.u]
t3 = [u[3] for u in sol.u]
t4 = [u[4] for u in sol.u]
t5 = [u[5] for u in sol.u]
#Velocidades
t1p = [u[6] for u in sol.u]
t2p = [u[7] for u in sol.u]
t3p = [u[8] for u in sol.u]
t4p = [u[9] for u in sol.u]
t5p = [u[10] for u in sol.u]

tiempo = sol.t
#Posiciones
traces1 = PlotlyJS.scatter(x=tiempo, y=t1, mode="lines",name="t1(t)")
traces2 = PlotlyJS.scatter(x=tiempo, y=t2, mode="lines",name="t2(t)")
traces3 = PlotlyJS.scatter(x=tiempo, y=t3, mode="lines",name="t3(t)")
traces4 = PlotlyJS.scatter(x=tiempo, y=t4, mode="lines",name="t4(t)")
traces5 = PlotlyJS.scatter(x=tiempo, y=t5, mode="lines",name="t5(t)")

#Velocidades
traces6 = PlotlyJS.scatter(x=tiempo, y=t1p, mode="lines",name="t1p(t)")
traces7 = PlotlyJS.scatter(x=tiempo, y=t2p, mode="lines",name="t2p(t)")
traces8 = PlotlyJS.scatter(x=tiempo, y=t3p, mode="lines",name="t3p(t)")
traces9 = PlotlyJS.scatter(x=tiempo, y=t4p, mode="lines",name="t4p(t)")
traces10 = PlotlyJS.scatter(x=tiempo, y=t5p, mode="lines",name="t5p(t)")

#Términos
traces11 = PlotlyJS.scatter(x=tiempo, y=datos, mode="lines",name="p_6")



pos = plot([traces1,traces2,traces3,traces5], Layout(title="Posiciones"))
vel = plot([traces6,traces7,traces8,traces9,traces10], Layout(title="Velocidades"))
termino = plot(traces11, Layout(title="Terminos"))
#display(fase)
#display(TD)
display(pos)
display(vel)
#display(MomAng)
savefig(pos, "VelocidadControlOriginal.png")
