using DifferentialEquations
using LinearAlgebra
#using Plots
using LaTeXStrings
using SciMLBase
using SimulationLogs
using JSON
using DataFrames
using PlotlyJS



function rotor(du,u,p,t)
    t40, v4,t50 = p  

        #satelite
        Ixs = 1
        Iys = 1
        Izs = 1
        
        # Gimball
        Ixg = 1
        Iyg = 1
        Izg = 1
    
        #primsa
        Ix = .1
        Iy = .2
        Iz = .3

    #satelite
    #Ixs = 0.033581
    #Iys = 0.033147
    #Izs = 0.006921
    #
    ## Gimball
    #Ixg = 0.0262866
    #Iyg = 0.0918351
    #Izg = 0.01179996
#
    ##primsa
    #Ix = .00329104
    #Iy = .001330387
    #Iz = .001652962


    m11 = (1/16)*(6*Ix+6*Ixg+4*Ixs+5*Iy+4*Iyg+5*Iz+6*Izg+8*Izs+((-Iy)+Iz)*cos(2*t50)+((-2*Ix)-2*Ixg+4*Ixs+Iy+4*Iyg+Iz-2*Izg-8*Izs+(3*Iy-3*Iz)*cos(2*t50))*cos(2*u[2])+(2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50)+(2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*cos(2*u[2]))*cos(2*u[3])+(4+4*cos(2*u[2])+((-4)-4*cos(2*u[2]))*cos(2*u[3]))*Iys+((8*Iy-8*Iz)*cos(t40)*sin(2*t50)*sin(2*u[2])*sin(u[3])+((4*Iy-4*Iz)*sin(t40)*sin(2*t50)+(4*Iy-4*Iz)*sin(t40)*sin(2*t50)*cos(2*u[2]))*sin(2*u[3]))*cos(v4*t)+(((-8*Iy)+8*Iz)*sin(t40)*sin(2*t50)*sin(2*u[2])*sin(u[3])+((4*Iy-4*Iz)*cos(t40)*sin(2*t50)+(4*Iy-4*Iz)*cos(t40)*sin(2*t50)*cos(2*u[2]))*sin(2*u[3]))*sin(v4*t)+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*t40)+((-Iy)+Iz)*cos(2*t40)*cos(2*t50)+((6*Ix+6*Ixg-3*Iy-3*Iz-6*Izg)*cos(2*t40)+(3*Iy-3*Iz)*cos(2*t40)*cos(2*t50))*cos(2*u[2])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*sin(2*t40)+((-4*Iy)+4*Iz)*sin(2*t40)*cos(2*t50))*sin(2*u[2])*cos(u[3])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50)+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*cos(2*u[2]))*cos(2*u[3]))*cos(2*v4*t)+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(2*t40)+(Iy-Iz)*sin(2*t40)*cos(2*t50)+(((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*sin(2*t40)+((-3*Iy)+3*Iz)*sin(2*t40)*cos(2*t50))*cos(2*u[2])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*cos(2*t40)+((-4*Iy)+4*Iz)*cos(2*t40)*cos(2*t50))*sin(2*u[2])*cos(u[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50)+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*cos(2*u[2]))*cos(2*u[3]))*sin(2*v4*t)) 
    m12 = -(1/8)*((2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*cos(u[2])*sin(2*u[3])-4*cos(u[2])*sin(2*u[3])*Iys+(((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*sin(u[2])*cos(u[3])+((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*cos(u[2])*cos(2*u[3]))*cos(v4*t)+((4*Iy-4*Iz)*sin(t40)*sin(2*t50)*sin(u[2])*cos(u[3])+((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*cos(u[2])*cos(2*u[3]))*sin(v4*t)+((((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*sin(2*t40)+((-2*Iy)+2*Iz)*sin(2*t40)*cos(2*t50))*sin(u[2])*sin(u[3])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*cos(u[2])*sin(2*u[3]))*cos(2*v4*t)+((((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*cos(2*t40)+((-2*Iy)+2*Iz)*cos(2*t40)*cos(2*t50))*sin(u[2])*sin(u[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*cos(u[2])*sin(2*u[3]))*sin(2*v4*t)) 
    m13 = -(1/4)*((2*Ix+2*Ixg+Iy+Iz+2*Izg+4*Izs+((-Iy)+Iz)*cos(2*t50))*sin(u[2])+(2*Iy-2*Iz)*cos(t40)*sin(2*t50)*cos(u[2])*sin(u[3])*cos(v4*t)+((-2*Iy)+2*Iz)*sin(t40)*sin(2*t50)*cos(u[2])*sin(u[3])*sin(v4*t)+((((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*t40)+((-Iy)+Iz)*cos(2*t40)*cos(2*t50))*sin(u[2])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*cos(u[2])*cos(u[3]))*cos(2*v4*t)+(((2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(2*t40)+(Iy-Iz)*sin(2*t40)*cos(2*t50))*sin(u[2])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*t40)+((-Iy)+Iz)*cos(2*t40)*cos(2*t50))*cos(u[2])*cos(u[3]))*sin(2*v4*t)) 
    m21 = -(1/8)*((2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*cos(u[2])*sin(2*u[3])-4*cos(u[2])*sin(2*u[3])*Iys+(((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*sin(u[2])*cos(u[3])+((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*cos(u[2])*cos(2*u[3]))*cos(v4*t)+((4*Iy-4*Iz)*sin(t40)*sin(2*t50)*sin(u[2])*cos(u[3])+((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*cos(u[2])*cos(2*u[3]))*sin(v4*t)+((((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*sin(2*t40)+((-2*Iy)+2*Iz)*sin(2*t40)*cos(2*t50))*sin(u[2])*sin(u[3])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*cos(u[2])*sin(2*u[3]))*cos(2*v4*t)+((((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*cos(2*t40)+((-2*Iy)+2*Iz)*cos(2*t40)*cos(2*t50))*sin(u[2])*sin(u[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*cos(u[2])*sin(2*u[3]))*sin(2*v4*t)) 
    m22 = -(1/8)*((-2*Ix)-2*Ixg-4*Ixs-3*Iy-4*Iyg-3*Iz-2*Izg+((-Iy)+Iz)*cos(2*t50)+(2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*cos(2*u[3])+((-4)-4*cos(2*u[3]))*Iys+(4*Iy-4*Iz)*sin(t40)*sin(2*t50)*sin(2*u[3])*cos(v4*t)+(4*Iy-4*Iz)*cos(t40)*sin(2*t50)*sin(2*u[3])*sin(v4*t)+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*t40)+((-Iy)+Iz)*cos(2*t40)*cos(2*t50)+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*cos(2*u[3]))*cos(2*v4*t)+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(2*t40)+(Iy-Iz)*sin(2*t40)*cos(2*t50)+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*cos(2*u[3]))*sin(2*v4*t)) 
    m23 = (1/4)*(((-2*Iy)+2*Iz)*cos(t40)*sin(2*t50)*cos(u[3])*cos(v4*t)+(2*Iy-2*Iz)*sin(t40)*sin(2*t50)*cos(u[3])*sin(v4*t)+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*sin(u[3])*cos(2*v4*t)+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*t40)+((-Iy)+Iz)*cos(2*t40)*cos(2*t50))*sin(u[3])*sin(2*v4*t)) 
    m31 = -(1/4)*((2*Ix+2*Ixg+Iy+Iz+2*Izg+4*Izs+((-Iy)+Iz)*cos(2*t50))*sin(u[2])+(2*Iy-2*Iz)*cos(t40)*sin(2*t50)*cos(u[2])*sin(u[3])*cos(v4*t)+((-2*Iy)+2*Iz)*sin(t40)*sin(2*t50)*cos(u[2])*sin(u[3])*sin(v4*t)+((((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*t40)+((-Iy)+Iz)*cos(2*t40)*cos(2*t50))*sin(u[2])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*cos(u[2])*cos(u[3]))*cos(2*v4*t)+(((2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(2*t40)+(Iy-Iz)*sin(2*t40)*cos(2*t50))*sin(u[2])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*t40)+((-Iy)+Iz)*cos(2*t40)*cos(2*t50))*cos(u[2])*cos(u[3]))*sin(2*v4*t)) 
    m32 = (1/4)*(((-2*Iy)+2*Iz)*cos(t40)*sin(2*t50)*cos(u[3])*cos(v4*t)+(2*Iy-2*Iz)*sin(t40)*sin(2*t50)*cos(u[3])*sin(v4*t)+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*sin(u[3])*cos(2*v4*t)+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*t40)+((-Iy)+Iz)*cos(2*t40)*cos(2*t50))*sin(u[3])*sin(2*v4*t)) 
    m33 = -(1/4)*((-2*Ix)-2*Ixg-Iy-Iz-2*Izg-4*Izs+(Iy-Iz)*cos(2*t50)+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*cos(2*v4*t)+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*sin(2*v4*t)) 
    
    c11 = -(1/8)*(((-2*Ix)-2*Ixg+4*Ixs+Iy+4*Iyg+Iz-2*Izg-8*Izs+(3*Iy-3*Iz)*cos(2*t50))*du[2]*sin(2*u[2])+(2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*du[2]*sin(2*u[2])*cos(2*u[3])+(4*du[2]*sin(2*u[2])-4*du[2]*sin(2*u[2])*cos(2*u[3]))*Iys+((((-8*Iy)+8*Iz)*cos(t40)*sin(2*t50)*du[2]*cos(2*u[2])+(4*Iy-4*Iz)*sin(t40)*sin(2*t50)*v4*sin(2*u[2]))*sin(u[3])+(((-2*Iy)+2*Iz)*cos(t40)*sin(2*t50)*v4+((-2*Iy)+2*Iz)*cos(t40)*sin(2*t50)*v4*cos(2*u[2])+(4*Iy-4*Iz)*sin(t40)*sin(2*t50)*du[2]*sin(2*u[2]))*sin(2*u[3]))*cos(v4*t)+(((8*Iy-8*Iz)*sin(t40)*sin(2*t50)*du[2]*cos(2*u[2])+(4*Iy-4*Iz)*cos(t40)*sin(2*t50)*v4*sin(2*u[2]))*sin(u[3])+((2*Iy-2*Iz)*sin(t40)*sin(2*t50)*v4+(2*Iy-2*Iz)*sin(t40)*sin(2*t50)*v4*cos(2*u[2])+(4*Iy-4*Iz)*cos(t40)*sin(2*t50)*du[2]*sin(2*u[2]))*sin(2*u[3]))*sin(v4*t)+((((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*v4+((6*Ix+6*Ixg-3*Iy-3*Iz-6*Izg)*sin(2*t40)+(3*Iy-3*Iz)*sin(2*t40)*cos(2*t50))*v4*cos(2*u[2])+((6*Ix+6*Ixg-3*Iy-3*Iz-6*Izg)*cos(2*t40)+(3*Iy-3*Iz)*cos(2*t40)*cos(2*t50))*du[2]*sin(2*u[2])+(((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*sin(2*t40)+(4*Iy-4*Iz)*sin(2*t40)*cos(2*t50))*du[2]*cos(2*u[2])+((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*cos(2*t40)+(4*Iy-4*Iz)*cos(2*t40)*cos(2*t50))*v4*sin(2*u[2]))*cos(u[3])+(((2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(2*t40)+(Iy-Iz)*sin(2*t40)*cos(2*t50))*v4+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(2*t40)+(Iy-Iz)*sin(2*t40)*cos(2*t50))*v4*cos(2*u[2])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*du[2]*sin(2*u[2]))*cos(2*u[3]))*cos(2*v4*t)+((((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*t40)+((-Iy)+Iz)*cos(2*t40)*cos(2*t50))*v4+((6*Ix+6*Ixg-3*Iy-3*Iz-6*Izg)*cos(2*t40)+(3*Iy-3*Iz)*cos(2*t40)*cos(2*t50))*v4*cos(2*u[2])+(((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*sin(2*t40)+((-3*Iy)+3*Iz)*sin(2*t40)*cos(2*t50))*du[2]*sin(2*u[2])+(((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*cos(2*t40)+(4*Iy-4*Iz)*cos(2*t40)*cos(2*t50))*du[2]*cos(2*u[2])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*sin(2*t40)+((-4*Iy)+4*Iz)*sin(2*t40)*cos(2*t50))*v4*sin(2*u[2]))*cos(u[3])+(((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*v4+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*v4*cos(2*u[2])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*du[2]*sin(2*u[2]))*cos(2*u[3]))*sin(2*v4*t)) 
    c12 = (1/8)*(((-4*Ix)-4*Ixg-2*Iy-2*Iz-4*Izg-8*Izs+(2*Iy-2*Iz)*cos(2*t50))*du[3]*cos(u[2])+((-4*Iy)-8*Iyg-4*Iz+((-4*Iy)+4*Iz)*cos(2*t50))*v4*sin(u[2])*sin(u[3])+((-4*Ix)-4*Ixg-8*Ixs+2*Iy+8*Iyg+2*Iz-4*Izg+(6*Iy-6*Iz)*cos(2*t50))*du[3]*cos(u[2])*cos(2*u[3])+(2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*du[2]*sin(u[2])*sin(2*u[3])+(8*du[3]*cos(u[2])*cos(2*u[3])-4*du[2]*sin(u[2])*sin(2*u[3]))*Iys+((4*Iy-4*Iz)*cos(t40)*sin(2*t50)*v4*cos(u[2])+((4*Iy-4*Iz)*cos(t40)*sin(2*t50)*du[2]*cos(u[2])+((-8*Iy)+8*Iz)*sin(t40)*sin(2*t50)*v4*sin(u[2]))*cos(u[3])+((4*Iy-4*Iz)*cos(t40)*sin(2*t50)*v4*cos(u[2])+((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*du[2]*sin(u[2]))*cos(2*u[3])+((-8*Iy)+8*Iz)*sin(t40)*sin(2*t50)*du[3]*cos(u[2])*sin(2*u[3]))*cos(v4*t)+(((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*v4*cos(u[2])+(((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*du[2]*cos(u[2])+((-8*Iy)+8*Iz)*cos(t40)*sin(2*t50)*v4*sin(u[2]))*cos(u[3])+(((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*v4*cos(u[2])+((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*du[2]*sin(u[2]))*cos(2*u[3])+((-8*Iy)+8*Iz)*cos(t40)*sin(2*t50)*du[3]*cos(u[2])*sin(2*u[3]))*sin(v4*t)+(((4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*cos(2*t40)+(2*Iy-2*Iz)*cos(2*t40)*cos(2*t50))*du[3]*cos(u[2])+(((4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*sin(2*t40)+(2*Iy-2*Iz)*sin(2*t40)*cos(2*t50))*du[2]*cos(u[2])+((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*cos(2*t40)+(4*Iy-4*Iz)*cos(2*t40)*cos(2*t50))*v4*sin(u[2]))*sin(u[3])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*cos(2*t40)+((-2*Iy)+2*Iz)*cos(2*t40)*cos(2*t50))*du[3]*cos(u[2])*cos(2*u[3])+(((4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*sin(2*t40)+(2*Iy-2*Iz)*sin(2*t40)*cos(2*t50))*v4*cos(u[2])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*du[2]*sin(u[2]))*sin(2*u[3]))*cos(2*v4*t)+((((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*sin(2*t40)+((-2*Iy)+2*Iz)*sin(2*t40)*cos(2*t50))*du[3]*cos(u[2])+(((4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*cos(2*t40)+(2*Iy-2*Iz)*cos(2*t40)*cos(2*t50))*du[2]*cos(u[2])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*sin(2*t40)+((-4*Iy)+4*Iz)*sin(2*t40)*cos(2*t50))*v4*sin(u[2]))*sin(u[3])+((4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*sin(2*t40)+(2*Iy-2*Iz)*sin(2*t40)*cos(2*t50))*du[3]*cos(u[2])*cos(2*u[3])+(((4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*cos(2*t40)+(2*Iy-2*Iz)*cos(2*t40)*cos(2*t50))*v4*cos(u[2])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*du[2]*sin(u[2]))*sin(2*u[3]))*sin(2*v4*t)) 
    c13 = -(1/8)*(((-4*Iy)-8*Iyg-4*Iz+((-4*Iy)+4*Iz)*cos(2*t50))*v4*cos(u[2])*cos(u[3])+((2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*du[1]+(2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*du[1]*cos(2*u[2]))*sin(2*u[3])+((-4*du[1])-4*du[1]*cos(2*u[2]))*sin(2*u[3])*Iys+(((4*Iy-4*Iz)*cos(t40)*sin(2*t50)*du[3]*cos(u[2])+((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*du[1]*sin(2*u[2]))*cos(u[3])+(((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*du[1]+((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*du[1]*cos(2*u[2]))*cos(2*u[3]))*cos(v4*t)+((((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*du[3]*cos(u[2])+(4*Iy-4*Iz)*sin(t40)*sin(2*t50)*du[1]*sin(2*u[2]))*cos(u[3])+(((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*du[1]+((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*du[1]*cos(2*u[2]))*cos(2*u[3]))*sin(v4*t)+(((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*sin(2*t40)+(4*Iy-4*Iz)*sin(2*t40)*cos(2*t50))*v4*sin(u[2])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*cos(2*t40)+((-4*Iy)+4*Iz)*cos(2*t40)*cos(2*t50))*v4*cos(u[2])*cos(u[3])+(((4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*sin(2*t40)+(2*Iy-2*Iz)*sin(2*t40)*cos(2*t50))*du[3]*cos(u[2])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*sin(2*t40)+((-2*Iy)+2*Iz)*sin(2*t40)*cos(2*t50))*du[1]*sin(2*u[2]))*sin(u[3])+(((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*du[1]+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*du[1]*cos(2*u[2]))*sin(2*u[3]))*cos(2*v4*t)+(((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*cos(2*t40)+(4*Iy-4*Iz)*cos(2*t40)*cos(2*t50))*v4*sin(u[2])+((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*sin(2*t40)+(4*Iy-4*Iz)*sin(2*t40)*cos(2*t50))*v4*cos(u[2])*cos(u[3])+(((4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*cos(2*t40)+(2*Iy-2*Iz)*cos(2*t40)*cos(2*t50))*du[3]*cos(u[2])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*cos(2*t40)+((-2*Iy)+2*Iz)*cos(2*t40)*cos(2*t50))*du[1]*sin(2*u[2]))*sin(u[3])+((((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*du[1]+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*du[1]*cos(2*u[2]))*sin(2*u[3]))*sin(2*v4*t)) 
    c21 = -(1/16)*((2*Ix+2*Ixg-4*Ixs-Iy-4*Iyg-Iz+2*Izg+8*Izs+((-3*Iy)+3*Iz)*cos(2*t50))*du[1]*sin(2*u[2])+((-8*Iy)-16*Iyg-8*Iz+((-8*Iy)+8*Iz)*cos(2*t50))*v4*sin(u[2])*sin(u[3])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg+(3*Iy-3*Iz)*cos(2*t50))*du[1]*sin(2*u[2])*cos(2*u[3])+((-4*du[1]*sin(2*u[2]))+4*du[1]*sin(2*u[2])*cos(2*u[3]))*Iys+((8*Iy-8*Iz)*cos(t40)*sin(2*t50)*v4*cos(u[2])+(8*Iy-8*Iz)*cos(t40)*sin(2*t50)*du[1]*cos(2*u[2])*sin(u[3])+((-8*Iy)+8*Iz)*cos(t40)*sin(2*t50)*v4*cos(u[2])*cos(2*u[3])+((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*du[1]*sin(2*u[2])*sin(2*u[3]))*cos(v4*t)+(((-8*Iy)+8*Iz)*sin(t40)*sin(2*t50)*v4*cos(u[2])+((-8*Iy)+8*Iz)*sin(t40)*sin(2*t50)*du[1]*cos(2*u[2])*sin(u[3])+(8*Iy-8*Iz)*sin(t40)*sin(2*t50)*v4*cos(u[2])*cos(2*u[3])+((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*du[1]*sin(2*u[2])*sin(2*u[3]))*sin(v4*t)+((((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*cos(2*t40)+((-3*Iy)+3*Iz)*cos(2*t40)*cos(2*t50))*du[1]*sin(2*u[2])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*sin(2*t40)+((-4*Iy)+4*Iz)*sin(2*t40)*cos(2*t50))*du[1]*cos(2*u[2])*cos(u[3])+(((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*cos(2*t40)+((-8*Iy)+8*Iz)*cos(2*t40)*cos(2*t50))*v4*sin(u[2])*sin(u[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*t40)+((-Iy)+Iz)*cos(2*t40)*cos(2*t50))*du[1]*sin(2*u[2])*cos(2*u[3])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*sin(2*t40)+((-4*Iy)+4*Iz)*sin(2*t40)*cos(2*t50))*v4*cos(u[2])*sin(2*u[3]))*cos(2*v4*t)+(((6*Ix+6*Ixg-3*Iy-3*Iz-6*Izg)*sin(2*t40)+(3*Iy-3*Iz)*sin(2*t40)*cos(2*t50))*du[1]*sin(2*u[2])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*cos(2*t40)+((-4*Iy)+4*Iz)*cos(2*t40)*cos(2*t50))*du[1]*cos(2*u[2])*cos(u[3])+((16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*sin(2*t40)+(8*Iy-8*Iz)*sin(2*t40)*cos(2*t50))*v4*sin(u[2])*sin(u[3])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(2*t40)+(Iy-Iz)*sin(2*t40)*cos(2*t50))*du[1]*sin(2*u[2])*cos(2*u[3])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*cos(2*t40)+((-4*Iy)+4*Iz)*cos(2*t40)*cos(2*t50))*v4*cos(u[2])*sin(2*u[3]))*sin(2*v4*t)) 
    c22 = (1/4)*((2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*du[3]*sin(2*u[3])-4*du[3]*sin(2*u[3])*Iys+(((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*du[3]*cos(2*u[3])+((-2*Iy)+2*Iz)*cos(t40)*sin(2*t50)*v4*sin(2*u[3]))*cos(v4*t)+(((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*du[3]*cos(2*u[3])+(2*Iy-2*Iz)*sin(t40)*sin(2*t50)*v4*sin(2*u[3]))*sin(v4*t)+((((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*v4+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(2*t40)+(Iy-Iz)*sin(2*t40)*cos(2*t50))*v4*cos(2*u[3])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*du[3]*sin(2*u[3]))*cos(2*v4*t)+((((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*t40)+((-Iy)+Iz)*cos(2*t40)*cos(2*t50))*v4+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*v4*cos(2*u[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*du[3]*sin(2*u[3]))*sin(2*v4*t)) 
    c23 = -(1/4)*(((-2*Ix)-2*Ixg-Iy-Iz-2*Izg-4*Izs+(Iy-Iz)*cos(2*t50))*du[1]*cos(u[2])+(2*Iy+4*Iyg+2*Iz+(2*Iy-2*Iz)*cos(2*t50))*v4*sin(u[3])+(2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*du[1]*cos(u[2])*cos(2*u[3])-4*du[1]*cos(u[2])*cos(2*u[3])*Iys+((((-2*Iy)+2*Iz)*cos(t40)*sin(2*t50)*du[3]+(4*Iy-4*Iz)*cos(t40)*sin(2*t50)*du[1]*sin(u[2]))*sin(u[3])+(4*Iy-4*Iz)*sin(t40)*sin(2*t50)*du[1]*cos(u[2])*sin(2*u[3]))*cos(v4*t)+(((2*Iy-2*Iz)*sin(t40)*sin(2*t50)*du[3]+((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*du[1]*sin(u[2]))*sin(u[3])+(4*Iy-4*Iz)*cos(t40)*sin(2*t50)*du[1]*cos(u[2])*sin(2*u[3]))*sin(v4*t)+(((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*du[1]*cos(u[2])+(((2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(2*t40)+(Iy-Iz)*sin(2*t40)*cos(2*t50))*du[3]+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*sin(2*t40)+((-2*Iy)+2*Iz)*sin(2*t40)*cos(2*t50))*du[1]*sin(u[2]))*cos(u[3])+((4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*cos(2*t40)+(2*Iy-2*Iz)*cos(2*t40)*cos(2*t50))*v4*sin(u[3])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*du[1]*cos(u[2])*cos(2*u[3]))*cos(2*v4*t)+((((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*du[1]*cos(u[2])+(((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*du[3]+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*cos(2*t40)+((-2*Iy)+2*Iz)*cos(2*t40)*cos(2*t50))*du[1]*sin(u[2]))*cos(u[3])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*sin(2*t40)+((-2*Iy)+2*Iz)*sin(2*t40)*cos(2*t50))*v4*sin(u[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*du[1]*cos(u[2])*cos(2*u[3]))*sin(2*v4*t)) 
    c31 = (1/16)*(((-8*Ix)-8*Ixg-4*Iy-4*Iz-8*Izg-16*Izs+(4*Iy-4*Iz)*cos(2*t50))*du[2]*cos(u[2])+((-8*Iy)-16*Iyg-8*Iz+((-8*Iy)+8*Iz)*cos(2*t50))*v4*cos(u[2])*cos(u[3])+(8*Ix+8*Ixg+16*Ixs-4*Iy-16*Iyg-4*Iz+8*Izg+((-12*Iy)+12*Iz)*cos(2*t50))*du[2]*cos(u[2])*cos(2*u[3])+((2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*du[1]+(2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*du[1]*cos(2*u[2]))*sin(2*u[3])+((-16*du[2]*cos(u[2])*cos(2*u[3]))+((-4*du[1])-4*du[1]*cos(2*u[2]))*sin(2*u[3]))*Iys+(((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*du[1]*sin(2*u[2])*cos(u[3])+((16*Iy-16*Iz)*sin(t40)*sin(2*t50)*v4*cos(u[2])+(16*Iy-16*Iz)*cos(t40)*sin(2*t50)*du[2]*sin(u[2]))*sin(u[3])+(((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*du[1]+((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*du[1]*cos(2*u[2]))*cos(2*u[3])+(16*Iy-16*Iz)*sin(t40)*sin(2*t50)*du[2]*cos(u[2])*sin(2*u[3]))*cos(v4*t)+((4*Iy-4*Iz)*sin(t40)*sin(2*t50)*du[1]*sin(2*u[2])*cos(u[3])+((16*Iy-16*Iz)*cos(t40)*sin(2*t50)*v4*cos(u[2])+((-16*Iy)+16*Iz)*sin(t40)*sin(2*t50)*du[2]*sin(u[2]))*sin(u[3])+(((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*du[1]+((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*du[1]*cos(2*u[2]))*cos(2*u[3])+(16*Iy-16*Iz)*cos(t40)*sin(2*t50)*du[2]*cos(u[2])*sin(2*u[3]))*sin(v4*t)+(((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*cos(2*t40)+(4*Iy-4*Iz)*cos(2*t40)*cos(2*t50))*du[2]*cos(u[2])+(((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*sin(2*t40)+((-8*Iy)+8*Iz)*sin(2*t40)*cos(2*t50))*v4*sin(u[2])+(((16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*cos(2*t40)+(8*Iy-8*Iz)*cos(2*t40)*cos(2*t50))*v4*cos(u[2])+(((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*sin(2*t40)+((-8*Iy)+8*Iz)*sin(2*t40)*cos(2*t50))*du[2]*sin(u[2]))*cos(u[3])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*sin(2*t40)+((-2*Iy)+2*Iz)*sin(2*t40)*cos(2*t50))*du[1]*sin(2*u[2])*sin(u[3])+((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*cos(2*t40)+(4*Iy-4*Iz)*cos(2*t40)*cos(2*t50))*du[2]*cos(u[2])*cos(2*u[3])+(((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*du[1]+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*du[1]*cos(2*u[2]))*sin(2*u[3]))*cos(2*v4*t)+((((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*sin(2*t40)+((-4*Iy)+4*Iz)*sin(2*t40)*cos(2*t50))*du[2]*cos(u[2])+(((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*cos(2*t40)+((-8*Iy)+8*Iz)*cos(2*t40)*cos(2*t50))*v4*sin(u[2])+((((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*sin(2*t40)+((-8*Iy)+8*Iz)*sin(2*t40)*cos(2*t50))*v4*cos(u[2])+(((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*cos(2*t40)+((-8*Iy)+8*Iz)*cos(2*t40)*cos(2*t50))*du[2]*sin(u[2]))*cos(u[3])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*cos(2*t40)+((-2*Iy)+2*Iz)*cos(2*t40)*cos(2*t50))*du[1]*sin(2*u[2])*sin(u[3])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*sin(2*t40)+((-4*Iy)+4*Iz)*sin(2*t40)*cos(2*t50))*du[2]*cos(u[2])*cos(2*u[3])+((((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*du[1]+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*du[1]*cos(2*u[2]))*sin(2*u[3]))*sin(2*v4*t)) 
    c32 = -(1/8)*(((-4*Iy)-8*Iyg-4*Iz+((-4*Iy)+4*Iz)*cos(2*t50))*v4*sin(u[3])+(2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*du[2]*sin(2*u[3])-4*du[2]*sin(2*u[3])*Iys+(((-8*Iy)+8*Iz)*sin(t40)*sin(2*t50)*v4*cos(u[3])+((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*du[2]*cos(2*u[3]))*cos(v4*t)+(((-8*Iy)+8*Iz)*cos(t40)*sin(2*t50)*v4*cos(u[3])+((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*du[2]*cos(2*u[3]))*sin(v4*t)+(((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*cos(2*t40)+(4*Iy-4*Iz)*cos(2*t40)*cos(2*t50))*v4*sin(u[3])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*du[2]*sin(2*u[3]))*cos(2*v4*t)+((((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*sin(2*t40)+((-4*Iy)+4*Iz)*sin(2*t40)*cos(2*t50))*v4*sin(u[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*du[2]*sin(2*u[3]))*sin(2*v4*t)) 
    c33 = -(1/2)*((((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*v4*cos(2*v4*t)+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*t40)+((-Iy)+Iz)*cos(2*t40)*cos(2*t50))*v4*sin(2*v4*t)) 
   
    g11 = -(1/8)*(((-2*Ix)-2*Ixg+4*Ixs+Iy+4*Iyg+Iz-2*Izg-8*Izs+(3*Iy-3*Iz)*cos(2*t50))*du[2]*sin(2*u[2])+(2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*du[2]*sin(2*u[2])*cos(2*u[3])+(4*du[2]*sin(2*u[2])-4*du[2]*sin(2*u[2])*cos(2*u[3]))*Iys+((((-8*Iy)+8*Iz)*cos(t40)*sin(2*t50)*du[2]*cos(2*u[2])+(4*Iy-4*Iz)*sin(t40)*sin(2*t50)*v4*sin(2*u[2]))*sin(u[3])+(((-2*Iy)+2*Iz)*cos(t40)*sin(2*t50)*v4+((-2*Iy)+2*Iz)*cos(t40)*sin(2*t50)*v4*cos(2*u[2])+(4*Iy-4*Iz)*sin(t40)*sin(2*t50)*du[2]*sin(2*u[2]))*sin(2*u[3]))*cos(v4*t)+(((8*Iy-8*Iz)*sin(t40)*sin(2*t50)*du[2]*cos(2*u[2])+(4*Iy-4*Iz)*cos(t40)*sin(2*t50)*v4*sin(2*u[2]))*sin(u[3])+((2*Iy-2*Iz)*sin(t40)*sin(2*t50)*v4+(2*Iy-2*Iz)*sin(t40)*sin(2*t50)*v4*cos(2*u[2])+(4*Iy-4*Iz)*cos(t40)*sin(2*t50)*du[2]*sin(2*u[2]))*sin(2*u[3]))*sin(v4*t)+((((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*v4+((6*Ix+6*Ixg-3*Iy-3*Iz-6*Izg)*sin(2*t40)+(3*Iy-3*Iz)*sin(2*t40)*cos(2*t50))*v4*cos(2*u[2])+((6*Ix+6*Ixg-3*Iy-3*Iz-6*Izg)*cos(2*t40)+(3*Iy-3*Iz)*cos(2*t40)*cos(2*t50))*du[2]*sin(2*u[2])+(((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*sin(2*t40)+(4*Iy-4*Iz)*sin(2*t40)*cos(2*t50))*du[2]*cos(2*u[2])+((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*cos(2*t40)+(4*Iy-4*Iz)*cos(2*t40)*cos(2*t50))*v4*sin(2*u[2]))*cos(u[3])+(((2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(2*t40)+(Iy-Iz)*sin(2*t40)*cos(2*t50))*v4+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(2*t40)+(Iy-Iz)*sin(2*t40)*cos(2*t50))*v4*cos(2*u[2])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*du[2]*sin(2*u[2]))*cos(2*u[3]))*cos(2*v4*t)+((((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*t40)+((-Iy)+Iz)*cos(2*t40)*cos(2*t50))*v4+((6*Ix+6*Ixg-3*Iy-3*Iz-6*Izg)*cos(2*t40)+(3*Iy-3*Iz)*cos(2*t40)*cos(2*t50))*v4*cos(2*u[2])+(((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*sin(2*t40)+((-3*Iy)+3*Iz)*sin(2*t40)*cos(2*t50))*du[2]*sin(2*u[2])+(((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*cos(2*t40)+(4*Iy-4*Iz)*cos(2*t40)*cos(2*t50))*du[2]*cos(2*u[2])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*sin(2*t40)+((-4*Iy)+4*Iz)*sin(2*t40)*cos(2*t50))*v4*sin(2*u[2]))*cos(u[3])+(((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*v4+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*v4*cos(2*u[2])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*du[2]*sin(2*u[2]))*cos(2*u[3]))*sin(2*v4*t)) 
    g21 = -(1/16)*((2*Ix+2*Ixg-4*Ixs-Iy-4*Iyg-Iz+2*Izg+8*Izs+((-3*Iy)+3*Iz)*cos(2*t50))*du[1]*sin(2*u[2])+((-8*Iy)-16*Iyg-8*Iz+((-8*Iy)+8*Iz)*cos(2*t50))*v4*sin(u[2])*sin(u[3])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg+(3*Iy-3*Iz)*cos(2*t50))*du[1]*sin(2*u[2])*cos(2*u[3])+((-4*du[1]*sin(2*u[2]))+4*du[1]*sin(2*u[2])*cos(2*u[3]))*Iys+((8*Iy-8*Iz)*cos(t40)*sin(2*t50)*v4*cos(u[2])+(8*Iy-8*Iz)*cos(t40)*sin(2*t50)*du[1]*cos(2*u[2])*sin(u[3])+((-8*Iy)+8*Iz)*cos(t40)*sin(2*t50)*v4*cos(u[2])*cos(2*u[3])+((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*du[1]*sin(2*u[2])*sin(2*u[3]))*cos(v4*t)+(((-8*Iy)+8*Iz)*sin(t40)*sin(2*t50)*v4*cos(u[2])+((-8*Iy)+8*Iz)*sin(t40)*sin(2*t50)*du[1]*cos(2*u[2])*sin(u[3])+(8*Iy-8*Iz)*sin(t40)*sin(2*t50)*v4*cos(u[2])*cos(2*u[3])+((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*du[1]*sin(2*u[2])*sin(2*u[3]))*sin(v4*t)+((((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*cos(2*t40)+((-3*Iy)+3*Iz)*cos(2*t40)*cos(2*t50))*du[1]*sin(2*u[2])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*sin(2*t40)+((-4*Iy)+4*Iz)*sin(2*t40)*cos(2*t50))*du[1]*cos(2*u[2])*cos(u[3])+(((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*cos(2*t40)+((-8*Iy)+8*Iz)*cos(2*t40)*cos(2*t50))*v4*sin(u[2])*sin(u[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*t40)+((-Iy)+Iz)*cos(2*t40)*cos(2*t50))*du[1]*sin(2*u[2])*cos(2*u[3])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*sin(2*t40)+((-4*Iy)+4*Iz)*sin(2*t40)*cos(2*t50))*v4*cos(u[2])*sin(2*u[3]))*cos(2*v4*t)+(((6*Ix+6*Ixg-3*Iy-3*Iz-6*Izg)*sin(2*t40)+(3*Iy-3*Iz)*sin(2*t40)*cos(2*t50))*du[1]*sin(2*u[2])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*cos(2*t40)+((-4*Iy)+4*Iz)*cos(2*t40)*cos(2*t50))*du[1]*cos(2*u[2])*cos(u[3])+((16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*sin(2*t40)+(8*Iy-8*Iz)*sin(2*t40)*cos(2*t50))*v4*sin(u[2])*sin(u[3])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(2*t40)+(Iy-Iz)*sin(2*t40)*cos(2*t50))*du[1]*sin(2*u[2])*cos(2*u[3])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*cos(2*t40)+((-4*Iy)+4*Iz)*cos(2*t40)*cos(2*t50))*v4*cos(u[2])*sin(2*u[3]))*sin(2*v4*t)) 
    g31 = (1/16)*(((-8*Ix)-8*Ixg-4*Iy-4*Iz-8*Izg-16*Izs+(4*Iy-4*Iz)*cos(2*t50))*du[2]*cos(u[2])+((-8*Iy)-16*Iyg-8*Iz+((-8*Iy)+8*Iz)*cos(2*t50))*v4*cos(u[2])*cos(u[3])+(8*Ix+8*Ixg+16*Ixs-4*Iy-16*Iyg-4*Iz+8*Izg+((-12*Iy)+12*Iz)*cos(2*t50))*du[2]*cos(u[2])*cos(2*u[3])+((2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*du[1]+(2*Ix+2*Ixg+4*Ixs-Iy-4*Iyg-Iz+2*Izg+((-3*Iy)+3*Iz)*cos(2*t50))*du[1]*cos(2*u[2]))*sin(2*u[3])+((-16*du[2]*cos(u[2])*cos(2*u[3]))+((-4*du[1])-4*du[1]*cos(2*u[2]))*sin(2*u[3]))*Iys+(((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*du[1]*sin(2*u[2])*cos(u[3])+((16*Iy-16*Iz)*sin(t40)*sin(2*t50)*v4*cos(u[2])+(16*Iy-16*Iz)*cos(t40)*sin(2*t50)*du[2]*sin(u[2]))*sin(u[3])+(((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*du[1]+((-4*Iy)+4*Iz)*sin(t40)*sin(2*t50)*du[1]*cos(2*u[2]))*cos(2*u[3])+(16*Iy-16*Iz)*sin(t40)*sin(2*t50)*du[2]*cos(u[2])*sin(2*u[3]))*cos(v4*t)+((4*Iy-4*Iz)*sin(t40)*sin(2*t50)*du[1]*sin(2*u[2])*cos(u[3])+((16*Iy-16*Iz)*cos(t40)*sin(2*t50)*v4*cos(u[2])+((-16*Iy)+16*Iz)*sin(t40)*sin(2*t50)*du[2]*sin(u[2]))*sin(u[3])+(((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*du[1]+((-4*Iy)+4*Iz)*cos(t40)*sin(2*t50)*du[1]*cos(2*u[2]))*cos(2*u[3])+(16*Iy-16*Iz)*cos(t40)*sin(2*t50)*du[2]*cos(u[2])*sin(2*u[3]))*sin(v4*t)+(((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*cos(2*t40)+(4*Iy-4*Iz)*cos(2*t40)*cos(2*t50))*du[2]*cos(u[2])+(((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*sin(2*t40)+((-8*Iy)+8*Iz)*sin(2*t40)*cos(2*t50))*v4*sin(u[2])+(((16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*cos(2*t40)+(8*Iy-8*Iz)*cos(2*t40)*cos(2*t50))*v4*cos(u[2])+(((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*sin(2*t40)+((-8*Iy)+8*Iz)*sin(2*t40)*cos(2*t50))*du[2]*sin(u[2]))*cos(u[3])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*sin(2*t40)+((-2*Iy)+2*Iz)*sin(2*t40)*cos(2*t50))*du[1]*sin(2*u[2])*sin(u[3])+((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*cos(2*t40)+(4*Iy-4*Iz)*cos(2*t40)*cos(2*t50))*du[2]*cos(u[2])*cos(2*u[3])+(((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*du[1]+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(2*t40)+(Iy-Iz)*cos(2*t40)*cos(2*t50))*du[1]*cos(2*u[2]))*sin(2*u[3]))*cos(2*v4*t)+((((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*sin(2*t40)+((-4*Iy)+4*Iz)*sin(2*t40)*cos(2*t50))*du[2]*cos(u[2])+(((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*cos(2*t40)+((-8*Iy)+8*Iz)*cos(2*t40)*cos(2*t50))*v4*sin(u[2])+((((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*sin(2*t40)+((-8*Iy)+8*Iz)*sin(2*t40)*cos(2*t50))*v4*cos(u[2])+(((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*cos(2*t40)+((-8*Iy)+8*Iz)*cos(2*t40)*cos(2*t50))*du[2]*sin(u[2]))*cos(u[3])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*cos(2*t40)+((-2*Iy)+2*Iz)*cos(2*t40)*cos(2*t50))*du[1]*sin(2*u[2])*sin(u[3])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*sin(2*t40)+((-4*Iy)+4*Iz)*sin(2*t40)*cos(2*t50))*du[2]*cos(u[2])*cos(2*u[3])+((((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*du[1]+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(2*t40)+((-Iy)+Iz)*sin(2*t40)*cos(2*t50))*du[1]*cos(2*u[2]))*sin(2*u[3]))*sin(2*v4*t)) 

    M=[m11 m12 m13;m21 m22 m23;m31 m32 m33]
    C=[c11 c12 c13;c21 c22 c23;c31 c32 c33]
    G=[g11;g21;g31]

    #K1 = 12.0
    #K0 = 20.0
    #qt = qd-u[5]
    #qtp = - du[5]
    #u=K0*qt + K1*qtp

    tau = [0;0;0]
    
    ddu = inv(M)*(-C*du - G + tau)
 
    end
    
    t40 = 0.0
    v4  = 1.0
    
    t50 = 1.0
    
    u1_0  = 0.0
    du1_0 = 0.0
    
    u2_0  = 0.0
    du2_0 = 0.0
    
    u3_0  = pi
    du3_0 = 0.0

    
    u0=[u1_0,u2_0,u3_0]
    du0=[du1_0,du2_0,du3_0]

    tspan = (0,100.0)
  
    p = [t40, v4, t50]

    prob=SecondOrderODEProblem(rotor,du0,u0,tspan,dt=0.001,saveat=0.001,p)
    
sol = solve(prob,Tsit5())

    df=DataFrame(sol)
    json_str = JSON.json(df)

open("./Prototipo/simulaciones/datos_GCMRA_PRIMSA.json", "w") do io
    write(io, json_str)
end  

traces_t1 = Vector{AbstractTrace}() 
traces_t2 = Vector{AbstractTrace}() 
traces_t3 = Vector{AbstractTrace}() 
#traces_t4 = Vector{AbstractTrace}() 
#traces_t5 = Vector{AbstractTrace}() 

traces_t1p = Vector{AbstractTrace}() 
traces_t2p = Vector{AbstractTrace}() 
traces_t3p = Vector{AbstractTrace}() 
#traces_t4p = Vector{AbstractTrace}() 
#traces_t5p = Vector{AbstractTrace}() 

t1 = [u[4] for u in sol.u]
t2 = [u[5] for u in sol.u]
t3 = [u[6] for u in sol.u]



t1p = [u[1] for u in sol.u]
t2p = [u[2] for u in sol.u]
t3p = [u[3] for u in sol.u]


tiempo = sol.t

traces_t1 = PlotlyJS.scatter(x=tiempo, y=t1, mode="lines",name="t1(t)")
traces_t2 = PlotlyJS.scatter(x=tiempo, y=t2, mode="lines",name="t2(t)")
traces_t3 = PlotlyJS.scatter(x=tiempo, y=t3, mode="lines",name="t3(t)")
#traces_t4 = PlotlyJS.scatter(x=tiempo, y=t4, mode="lines",name="t4(t)")
#traces_t5 = PlotlyJS.scatter(x=tiempo, y=t5, mode="lines",name="t5(t)")

traces_t1p = PlotlyJS.scatter(x=tiempo, y=t1p, mode="lines",name="t1p(t)")
traces_t2p = PlotlyJS.scatter(x=tiempo, y=t2p, mode="lines",name="t2p(t)")
traces_t3p = PlotlyJS.scatter(x=tiempo, y=t3p, mode="lines",name="t3p(t)")
#traces_t4p = PlotlyJS.scatter(x=tiempo, y=t4p, mode="lines",name="t4p(t)")
#traces_t5p = PlotlyJS.scatter(x=tiempo, y=t5p, mode="lines",name="t5p(t)")



pos = plot([traces_t1,traces_t2,traces_t3], Layout(title="Posiciones"))
vel = plot([traces_t1p,traces_t2p,traces_t3p], Layout(title="Velocidades"))

display(pos)
display(vel)

