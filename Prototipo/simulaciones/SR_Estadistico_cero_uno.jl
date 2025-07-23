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
    t = 500.0
    tspan = (0.0,t)
    datos = []
    savetimes = 0.0:0.01:t;
function rotor(du,u,p,t)
   
    #satelite
    Ixs = 33.581e-3
    Iys = 33.147e-3
    Izs = 6.921e-3
    
    # Gimball #Original -6, -3 Para la inversión
    Ixg = 3.77e-6
    Iyg = 2.74e-6
    Izg = 6.49e-6
    #
    
    #Prisma con agujero 
    Ix = 3.250e-6
    Iy = 4.681e-6
    Iz = 6.909e-6
    
    ##primsa normal #-7
    #Ix = 3.502e-3
    #Iy = 4.084e-3
    #Iz = 1.052e-3  

#sensibilidad = 0.001
m11 = 0.02+0.013*cos(2*u[2])+1.1E-4*cos(2*u[3])+1.1E-4*cos(2*u[2])*cos(2*u[3])
m12 = -2.2E-4*cos(u[2])*sin(2*u[3])+1.3E-6*cos(u[2])*sin(2*u[3])*cos(2*u[4])+-2.6E-6*sin(u[2])*sin(u[3])*sin(2*u[4])+-8.6E-7*cos(u[2])*sin(2*u[3])*cos(2*u[5])+2.9E-7*cos(u[2])*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])+-5.7E-7*sin(u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])+-1.1E-6*sin(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])+-1.1E-6*cos(u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])
m13 = -0.0069*sin(u[2])+-2.6E-6*cos(u[2])*cos(u[3])*sin(2*u[4])+-5.7E-7*cos(u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])+1.1E-6*cos(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])
m14 = 8.5E-6*cos(u[2])*sin(u[3])+-1.1E-6*cos(u[2])*sin(u[3])*cos(2*u[5])+-1.1E-6*sin(u[2])*cos(u[4])*sin(2*u[5])+-1.1E-6*cos(u[2])*cos(u[3])*sin(u[4])*sin(2*u[5])
m15 = 3.3E-6*cos(u[2])*cos(u[3])*cos(u[4])+-3.3E-6*sin(u[2])*sin(u[4])

m21 = -2.2E-4*cos(u[2])*sin(2*u[3])+1.3E-6*cos(u[2])*sin(2*u[3])*cos(2*u[4])+-2.6E-6*sin(u[2])*sin(u[3])*sin(2*u[4])+-8.6E-7*cos(u[2])*sin(2*u[3])*cos(2*u[5])+2.9E-7*cos(u[2])*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])+-5.7E-7*sin(u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])+-1.1E-6*sin(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])+-1.1E-6*cos(u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])
m22 = 0.033+-2.2E-4*cos(2*u[3])
m23 = 2.6E-6*sin(u[3])*sin(2*u[4])+5.7E-7*sin(u[3])*sin(2*u[4])*cos(2*u[5])+1.1E-6*cos(u[3])*cos(u[4])*sin(2*u[5])
m24 = 8.5E-6*cos(u[3])+-1.1E-6*cos(u[3])*cos(2*u[5])+1.1E-6*sin(u[3])*sin(u[4])*sin(2*u[5])
m25 = -3.3E-6*sin(u[3])*cos(u[4])

m31 = -0.0069*sin(u[2])+-2.6E-6*cos(u[2])*cos(u[3])*sin(2*u[4])+-5.7E-7*cos(u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])+1.1E-6*cos(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])
m32 = 2.6E-6*sin(u[3])*sin(2*u[4])+5.7E-7*sin(u[3])*sin(2*u[4])*cos(2*u[5])+1.1E-6*cos(u[3])*cos(u[4])*sin(2*u[5])
m33 = 0.0069
m34 = 1.1E-6*cos(u[4])*sin(2*u[5])
m35 = 3.3E-6*sin(u[4])

m41 = 8.5E-6*cos(u[2])*sin(u[3])+-1.1E-6*cos(u[2])*sin(u[3])*cos(2*u[5])+-1.1E-6*sin(u[2])*cos(u[4])*sin(2*u[5])+-1.1E-6*cos(u[2])*cos(u[3])*sin(u[4])*sin(2*u[5])
m42 = 8.5E-6*cos(u[3])+-1.1E-6*cos(u[3])*cos(2*u[5])+1.1E-6*sin(u[3])*sin(u[4])*sin(2*u[5])
m43 = 1.1E-6*cos(u[4])*sin(2*u[5])
m44 = 8.5E-6+-1.1E-6*cos(2*u[5])
m45 = 0

m51 = 3.3E-6*cos(u[2])*cos(u[3])*cos(u[4])+-3.3E-6*sin(u[2])*sin(u[4])
m52 = -3.3E-6*sin(u[3])*cos(u[4])
m53 = 3.3E-6*sin(u[4])
m54 = 0
m55 = 3.3E-6


c15 = 0
c25 = 0
c35 = 0
c45 = 0
c55 = 0
#sensibilidad = 0.001
c11 = -0.026*u[7]*sin(2*u[2])+-2.2E-4*u[7]*sin(2*u[2])*cos(2*u[3])+-2.2E-4*u[8]*sin(2*u[3])+-2.2E-4*u[8]*cos(2*u[2])*sin(2*u[3])+5.2E-6*u[9]*sin(2*u[2])*cos(u[3])*cos(2*u[4])+1.3E-6*u[8]*sin(2*u[3])*cos(2*u[4])+1.3E-6*u[8]*cos(2*u[2])*sin(2*u[3])*cos(2*u[4])+-1.3E-6*u[9]*sin(2*u[4])+3.9E-6*u[9]*cos(2*u[2])*sin(2*u[4])+5.2E-6*u[7]*cos(2*u[2])*cos(u[3])*sin(2*u[4])+-2.6E-6*u[8]*sin(2*u[2])*sin(u[3])*sin(2*u[4])+1.3E-6*u[9]*cos(2*u[3])*sin(2*u[4])+1.3E-6*u[9]*cos(2*u[2])*cos(2*u[3])*sin(2*u[4])+-8.6E-7*u[8]*sin(2*u[3])*cos(2*u[5])+-8.6E-7*u[8]*cos(2*u[2])*sin(2*u[3])*cos(2*u[5])+-2.3E-6*u[10]*sin(2*u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])+-1.1E-6*u[10]*sin(2*u[3])*sin(u[4])*cos(2*u[5])+-1.1E-6*u[10]*cos(2*u[2])*sin(2*u[3])*sin(u[4])*cos(2*u[5])+1.1E-6*u[9]*sin(2*u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])+-2.9E-7*u[9]*sin(2*u[4])*cos(2*u[5])+8.6E-7*u[9]*cos(2*u[2])*sin(2*u[4])*cos(2*u[5])+1.1E-6*u[7]*cos(2*u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])+-5.7E-7*u[8]*sin(2*u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])+2.9E-7*u[9]*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])+2.9E-7*u[9]*cos(2*u[2])*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])+-2.9E-7*u[10]*sin(2*u[5])+8.6E-7*u[10]*cos(2*u[2])*sin(2*u[5])+-8.6E-7*u[10]*cos(2*u[3])*sin(2*u[5])+-8.6E-7*u[10]*cos(2*u[2])*cos(2*u[3])*sin(2*u[5])+-1.1E-6*u[8]*sin(2*u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])+-2.3E-6*u[7]*cos(2*u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])+-5.7E-7*u[9]*sin(2*u[3])*cos(u[4])*sin(2*u[5])+-5.7E-7*u[9]*cos(2*u[2])*sin(2*u[3])*cos(u[4])*sin(2*u[5])+-1.1E-6*u[8]*cos(2*u[3])*sin(u[4])*sin(2*u[5])+-1.1E-6*u[8]*cos(2*u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])+-2.9E-7*u[10]*cos(2*u[4])*sin(2*u[5])+8.6E-7*u[10]*cos(2*u[2])*cos(2*u[4])*sin(2*u[5])+2.9E-7*u[10]*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])+2.9E-7*u[10]*cos(2*u[2])*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])+-1.1E-6*u[10]*sin(2*u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5])
c12 = -0.0069*u[8]*cos(u[2])+-8.5E-6*u[9]*sin(u[2])*sin(u[3])+-4.4E-4*u[8]*cos(u[2])*cos(2*u[3])+2.2E-4*u[7]*sin(u[2])*sin(2*u[3])+-3.2E-6*u[10]*sin(u[2])*cos(u[3])*cos(u[4])+-3.2E-6*u[10]*cos(u[2])*sin(u[4])+-5.2E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[4])+-1.3E-6*u[7]*sin(u[2])*sin(2*u[3])*cos(2*u[4])+-2.6E-6*u[7]*cos(u[2])*sin(u[3])*sin(2*u[4])+-2.6E-6*u[9]*cos(u[2])*sin(2*u[3])*sin(2*u[4])+1.1E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[5])+8.6E-7*u[7]*sin(u[2])*sin(2*u[3])*cos(2*u[5])+-2.3E-6*u[10]*sin(u[2])*cos(u[3])*cos(u[4])*cos(2*u[5])+-2.3E-6*u[10]*cos(u[2])*cos(2*u[3])*sin(u[4])*cos(2*u[5])+-1.1E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[4])*cos(2*u[5])+-5.7E-7*u[7]*cos(u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])+-5.7E-7*u[9]*cos(u[2])*sin(2*u[3])*sin(2*u[4])*cos(2*u[5])+1.7E-6*u[10]*cos(u[2])*sin(2*u[3])*sin(2*u[5])+-1.1E-6*u[9]*cos(u[2])*cos(u[4])*sin(2*u[5])+-1.1E-6*u[7]*cos(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])+-1.1E-6*u[9]*cos(u[2])*cos(2*u[3])*cos(u[4])*sin(2*u[5])+2.3E-6*u[9]*sin(u[2])*cos(u[3])*sin(u[4])*sin(2*u[5])+1.1E-6*u[7]*sin(u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])+-5.7E-7*u[10]*cos(u[2])*sin(2*u[3])*cos(2*u[4])*sin(2*u[5])+1.1E-6*u[10]*sin(u[2])*sin(u[3])*sin(2*u[4])*sin(2*u[5])
c13 = 8.5E-6*u[9]*cos(u[2])*cos(u[3])+-3.3E-6*u[10]*cos(u[2])*sin(u[3])*cos(u[4])+-5.2E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[4])+5.2E-6*u[9]*sin(u[2])*sin(2*u[4])+2.6E-6*u[8]*cos(u[2])*sin(u[3])*sin(2*u[4])+-1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[5])+2.3E-6*u[10]*cos(u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])+-1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])+1.1E-6*u[9]*sin(u[2])*sin(2*u[4])*cos(2*u[5])+5.7E-7*u[8]*cos(u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])+1.1E-6*u[10]*sin(u[2])*sin(2*u[5])+1.1E-6*u[8]*cos(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])+1.1E-6*u[10]*sin(u[2])*cos(2*u[4])*sin(2*u[5])+1.1E-6*u[10]*cos(u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5])
c14 = -3.3E-6*u[10]*sin(u[2])*cos(u[4])+-3.3E-6*u[10]*cos(u[2])*cos(u[3])*sin(u[4])+-2.3E-6*u[10]*sin(u[2])*cos(u[4])*cos(2*u[5])+-2.3E-6*u[10]*cos(u[2])*cos(u[3])*sin(u[4])*cos(2*u[5])+2.3E-6*u[10]*cos(u[2])*sin(u[3])*sin(2*u[5])+-1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])+1.1E-6*u[9]*sin(u[2])*sin(u[4])*sin(2*u[5])

c21 = 0.0069*u[8]*cos(u[2])+0.013*u[6]*sin(2*u[2])+8.5E-6*u[9]*sin(u[2])*sin(u[3])+-4.4E-4*u[8]*cos(u[2])*cos(2*u[3])+1.1E-4*u[6]*sin(2*u[2])*cos(2*u[3])+3.3E-6*u[10]*sin(u[2])*cos(u[3])*cos(u[4])+3.3E-6*u[10]*cos(u[2])*sin(u[4])+-5.2E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[4])+-2.6E-6*u[6]*cos(2*u[2])*cos(u[3])*sin(2*u[4])+-2.6E-6*u[9]*cos(u[2])*sin(2*u[3])*sin(2*u[4])+-2.3E-6*u[10]*cos(u[2])*cos(2*u[3])*sin(u[4])*cos(2*u[5])+-5.7E-7*u[6]*cos(2*u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])+-5.7E-7*u[9]*cos(u[2])*sin(2*u[3])*sin(2*u[4])*cos(2*u[5])+1.7E-6*u[10]*cos(u[2])*sin(2*u[3])*sin(2*u[5])+1.1E-6*u[9]*cos(u[2])*cos(u[4])*sin(2*u[5])+-1.1E-6*u[9]*cos(u[2])*cos(2*u[3])*cos(u[4])*sin(2*u[5])+-5.7E-7*u[10]*cos(u[2])*sin(2*u[3])*cos(2*u[4])*sin(2*u[5])
c22 = 4.4E-4*u[8]*sin(2*u[3])+-2.6E-6*u[8]*sin(2*u[3])*cos(2*u[4])+2.6E-6*u[9]*sin(2*u[4])+-2.6E-6*u[9]*cos(2*u[3])*sin(2*u[4])+1.7E-6*u[8]*sin(2*u[3])*cos(2*u[5])+2.3E-6*u[10]*sin(2*u[3])*sin(u[4])*cos(2*u[5])+-5.7E-7*u[8]*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])+5.7E-7*u[9]*sin(2*u[4])*cos(2*u[5])+-5.7E-7*u[9]*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])+5.7E-7*u[10]*sin(2*u[5])+1.7E-6*u[10]*cos(2*u[3])*sin(2*u[5])+1.1E-6*u[9]*sin(2*u[3])*cos(u[4])*sin(2*u[5])+2.3E-6*u[8]*cos(2*u[3])*sin(u[4])*sin(2*u[5])+5.7E-7*u[10]*cos(2*u[4])*sin(2*u[5])+-5.7E-7*u[10]*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])
c23 = -8.5E-6*u[9]*sin(u[3])+-3.3E-6*u[10]*cos(u[3])*cos(u[4])+5.2E-6*u[9]*sin(u[3])*cos(2*u[4])+2.6E-6*u[8]*cos(u[3])*sin(2*u[4])+1.1E-6*u[9]*sin(u[3])*cos(2*u[5])+2.3E-6*u[10]*cos(u[3])*cos(u[4])*cos(2*u[5])+1.1E-6*u[9]*sin(u[3])*cos(2*u[4])*cos(2*u[5])+5.7E-7*u[8]*cos(u[3])*sin(2*u[4])*cos(2*u[5])+-1.1E-6*u[8]*sin(u[3])*cos(u[4])*sin(2*u[5])+-1.1E-6*u[10]*sin(u[3])*sin(2*u[4])*sin(2*u[5])
c24 = 3.3E-6*u[10]*sin(u[3])*sin(u[4])+2.3E-6*u[10]*sin(u[3])*sin(u[4])*cos(2*u[5])+2.3E-6*u[10]*cos(u[3])*sin(2*u[5])+1.1E-6*u[9]*sin(u[3])*cos(u[4])*sin(2*u[5])

c31 = -0.0069*u[7]*cos(u[2])+-8.5E-6*u[9]*cos(u[2])*cos(u[3])+4.4E-4*u[7]*cos(u[2])*cos(2*u[3])+1.1E-4*u[6]*sin(2*u[3])+1.1E-4*u[6]*cos(2*u[2])*sin(2*u[3])+3.3E-6*u[10]*cos(u[2])*sin(u[3])*cos(u[4])+-5.2E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[4])+-6.5E-7*u[6]*sin(2*u[3])*cos(2*u[4])+-6.5E-7*u[6]*cos(2*u[2])*sin(2*u[3])*cos(2*u[4])+5.2E-6*u[9]*sin(u[2])*sin(2*u[4])+5.2E-6*u[7]*sin(u[2])*cos(u[3])*sin(2*u[4])+1.3E-6*u[6]*sin(2*u[2])*sin(u[3])*sin(2*u[4])+1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[5])+4.3E-7*u[6]*sin(2*u[3])*cos(2*u[5])+4.3E-7*u[6]*cos(2*u[2])*sin(2*u[3])*cos(2*u[5])+2.3E-6*u[10]*cos(u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])+-1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])+1.1E-6*u[9]*sin(u[2])*sin(2*u[4])*cos(2*u[5])+2.9E-7*u[6]*sin(2*u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])+1.1E-6*u[10]*sin(u[2])*sin(2*u[5])+5.7E-7*u[6]*sin(2*u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])+-2.3E-6*u[7]*sin(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])+-2.3E-6*u[9]*cos(u[2])*sin(u[3])*sin(u[4])*sin(2*u[5])+5.7E-7*u[6]*cos(2*u[3])*sin(u[4])*sin(2*u[5])+5.7E-7*u[6]*cos(2*u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])+1.1E-6*u[10]*sin(u[2])*cos(2*u[4])*sin(2*u[5])+1.1E-6*u[10]*cos(u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5])
c32 = 8.5E-6*u[9]*sin(u[3])+-2.2E-4*u[7]*sin(2*u[3])+3.3E-6*u[10]*cos(u[3])*cos(u[4])+5.2E-6*u[9]*sin(u[3])*cos(2*u[4])+1.3E-6*u[7]*sin(2*u[3])*cos(2*u[4])+-1.1E-6*u[9]*sin(u[3])*cos(2*u[5])+-8.6E-7*u[7]*sin(2*u[3])*cos(2*u[5])+2.3E-6*u[10]*cos(u[3])*cos(u[4])*cos(2*u[5])+1.1E-6*u[9]*sin(u[3])*cos(2*u[4])*cos(2*u[5])+2.9E-7*u[7]*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])+-2.3E-6*u[9]*cos(u[3])*sin(u[4])*sin(2*u[5])+-1.1E-6*u[7]*cos(2*u[3])*sin(u[4])*sin(2*u[5])+-1.1E-6*u[10]*sin(u[3])*sin(2*u[4])*sin(2*u[5])
c33 = -5.2E-6*u[9]*sin(2*u[4])+-1.1E-6*u[9]*sin(2*u[4])*cos(2*u[5])+-1.1E-6*u[10]*sin(2*u[5])+-1.1E-6*u[10]*cos(2*u[4])*sin(2*u[5])
c34 = 3.3E-6*u[10]*cos(u[4])+2.3E-6*u[10]*cos(u[4])*cos(2*u[5])+-1.1E-6*u[9]*sin(u[4])*sin(2*u[5])

c41 = 8.5E-6*u[8]*cos(u[2])*cos(u[3])+-8.5E-6*u[7]*sin(u[2])*sin(u[3])+3.3E-6*u[10]*sin(u[2])*cos(u[4])+3.3E-6*u[10]*cos(u[2])*cos(u[3])*sin(u[4])+5.2E-6*u[8]*cos(u[2])*cos(u[3])*cos(2*u[4])+-2.6E-6*u[6]*sin(2*u[2])*cos(u[3])*cos(2*u[4])+5.2E-6*u[7]*sin(u[2])*sin(u[3])*cos(2*u[4])+6.5E-7*u[6]*sin(2*u[4])+-5.2E-6*u[8]*sin(u[2])*sin(2*u[4])+-2.0E-6*u[6]*cos(2*u[2])*sin(2*u[4])+-6.5E-7*u[6]*cos(2*u[3])*sin(2*u[4])+-6.5E-7*u[6]*cos(2*u[2])*cos(2*u[3])*sin(2*u[4])+2.6E-6*u[7]*cos(u[2])*sin(2*u[3])*sin(2*u[4])+-1.1E-6*u[8]*cos(u[2])*cos(u[3])*cos(2*u[5])+1.1E-6*u[7]*sin(u[2])*sin(u[3])*cos(2*u[5])+-2.3E-6*u[10]*sin(u[2])*cos(u[4])*cos(2*u[5])+-2.3E-6*u[10]*cos(u[2])*cos(u[3])*sin(u[4])*cos(2*u[5])+1.1E-6*u[8]*cos(u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])+-5.7E-7*u[6]*sin(2*u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])+1.1E-6*u[7]*sin(u[2])*sin(u[3])*cos(2*u[4])*cos(2*u[5])+1.4E-7*u[6]*sin(2*u[4])*cos(2*u[5])+-1.1E-6*u[8]*sin(u[2])*sin(2*u[4])*cos(2*u[5])+-4.3E-7*u[6]*cos(2*u[2])*sin(2*u[4])*cos(2*u[5])+-1.4E-7*u[6]*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])+-1.4E-7*u[6]*cos(2*u[2])*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])+5.7E-7*u[7]*cos(u[2])*sin(2*u[3])*sin(2*u[4])*cos(2*u[5])+2.3E-6*u[10]*cos(u[2])*sin(u[3])*sin(2*u[5])+-1.1E-6*u[7]*cos(u[2])*cos(u[4])*sin(2*u[5])+1.1E-6*u[7]*cos(u[2])*cos(2*u[3])*cos(u[4])*sin(2*u[5])+2.9E-7*u[6]*sin(2*u[3])*cos(u[4])*sin(2*u[5])+2.9E-7*u[6]*cos(2*u[2])*sin(2*u[3])*cos(u[4])*sin(2*u[5])+2.3E-6*u[8]*cos(u[2])*sin(u[3])*sin(u[4])*sin(2*u[5])+-5.7E-7*u[6]*sin(2*u[2])*sin(u[3])*sin(u[4])*sin(2*u[5])
c42 = -8.5E-6*u[8]*sin(u[3])+-3.3E-6*u[10]*sin(u[3])*sin(u[4])+-5.2E-6*u[8]*sin(u[3])*cos(2*u[4])+-1.3E-6*u[7]*sin(2*u[4])+1.3E-6*u[7]*cos(2*u[3])*sin(2*u[4])+1.1E-6*u[8]*sin(u[3])*cos(2*u[5])+2.3E-6*u[10]*sin(u[3])*sin(u[4])*cos(2*u[5])+-1.1E-6*u[8]*sin(u[3])*cos(2*u[4])*cos(2*u[5])+-2.9E-7*u[7]*sin(2*u[4])*cos(2*u[5])+2.9E-7*u[7]*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])+2.3E-6*u[10]*cos(u[3])*sin(2*u[5])+-5.7E-7*u[7]*sin(2*u[3])*cos(u[4])*sin(2*u[5])+2.3E-6*u[8]*cos(u[3])*sin(u[4])*sin(2*u[5])
c43 = -3.3E-6*u[10]*cos(u[4])+2.6E-6*u[8]*sin(2*u[4])+2.3E-6*u[10]*cos(u[4])*cos(2*u[5])+5.7E-7*u[8]*sin(2*u[4])*cos(2*u[5])
c44 = 2.3E-6*u[10]*sin(2*u[5])

c51 = -3.3E-6*u[9]*sin(u[2])*cos(u[4])+-3.3E-6*u[7]*sin(u[2])*cos(u[3])*cos(u[4])+-3.3E-6*u[8]*cos(u[2])*sin(u[3])*cos(u[4])+-3.3E-6*u[7]*cos(u[2])*sin(u[4])+-3.3E-6*u[9]*cos(u[2])*cos(u[3])*sin(u[4])+2.3E-6*u[9]*sin(u[2])*cos(u[4])*cos(2*u[5])+2.3E-6*u[7]*sin(u[2])*cos(u[3])*cos(u[4])*cos(2*u[5])+-2.3E-6*u[8]*cos(u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])+1.1E-6*u[6]*sin(2*u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])+2.3E-6*u[9]*cos(u[2])*cos(u[3])*sin(u[4])*cos(2*u[5])+2.3E-6*u[7]*cos(u[2])*cos(2*u[3])*sin(u[4])*cos(2*u[5])+5.7E-7*u[6]*sin(2*u[3])*sin(u[4])*cos(2*u[5])+5.7E-7*u[6]*cos(2*u[2])*sin(2*u[3])*sin(u[4])*cos(2*u[5])+1.4E-7*u[6]*sin(2*u[5])+-1.1E-6*u[8]*sin(u[2])*sin(2*u[5])+-4.3E-7*u[6]*cos(2*u[2])*sin(2*u[5])+-2.3E-6*u[9]*cos(u[2])*sin(u[3])*sin(2*u[5])+4.3E-7*u[6]*cos(2*u[3])*sin(2*u[5])+4.3E-7*u[6]*cos(2*u[2])*cos(2*u[3])*sin(2*u[5])+-1.7E-6*u[7]*cos(u[2])*sin(2*u[3])*sin(2*u[5])+1.4E-7*u[6]*cos(2*u[4])*sin(2*u[5])+-1.1E-6*u[8]*sin(u[2])*cos(2*u[4])*sin(2*u[5])+-4.3E-7*u[6]*cos(2*u[2])*cos(2*u[4])*sin(2*u[5])+-1.4E-7*u[6]*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])+-1.4E-7*u[6]*cos(2*u[2])*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])+5.7E-7*u[7]*cos(u[2])*sin(2*u[3])*cos(2*u[4])*sin(2*u[5])+-1.1E-6*u[8]*cos(u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5])+5.7E-7*u[6]*sin(2*u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5])+-1.1E-6*u[7]*sin(u[2])*sin(u[3])*sin(2*u[4])*sin(2*u[5])
c52 = -3.3E-6*u[8]*cos(u[3])*cos(u[4])+3.3E-6*u[9]*sin(u[3])*sin(u[4])+-2.3E-6*u[8]*cos(u[3])*cos(u[4])*cos(2*u[5])+-2.3E-6*u[9]*sin(u[3])*sin(u[4])*cos(2*u[5])+-1.1E-6*u[7]*sin(2*u[3])*sin(u[4])*cos(2*u[5])+-2.9E-7*u[7]*sin(2*u[5])+-2.3E-6*u[9]*cos(u[3])*sin(2*u[5])+-8.6E-7*u[7]*cos(2*u[3])*sin(2*u[5])+-2.9E-7*u[7]*cos(2*u[4])*sin(2*u[5])+2.9E-7*u[7]*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])+1.1E-6*u[8]*sin(u[3])*sin(2*u[4])*sin(2*u[5])
c53 = 3.3E-6*u[9]*cos(u[4])+-2.3E-6*u[9]*cos(u[4])*cos(2*u[5])+5.7E-7*u[8]*sin(2*u[5])+5.7E-7*u[8]*cos(2*u[4])*sin(2*u[5])
c54 = -1.1E-6*u[9]*sin(2*u[5])

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
    
    g = inv(M)
    
    f = (-C * du[1:5])
    #CONTROL DE VELOCIDAD
    e1 = du[4] - vᵈ; # Gimbal
    ep1 = du[9];

    k₀1 = 1.8e-2 ;
    k₁1 = 2*sqrt(k₀1) + k₀1;
    v₁ = - (k₀1*e1 + k₁1*ep1 );

    e2 = u[5] - θᵈ #Prisma
    ep2 = du[5];

    k₀2 = 1.0e-1;
    k₁2 = 2*sqrt(k₀2) + k₀2 ;
    v₂ = - (k₀2*e2 + k₁2*ep2 );
    v = [v₁
    v₂];
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
    
    # Lazo abierto
    du[6:10] .= g * f
    # Lazo cerrado
    #du[6:10] .=  g * (f + [0;0;0;τ])
end
#Condiciones iniciales inversion

# Condiciones lazo abierto
u1_0  = 1.0
du1_0 = 1.0

u2_0  = 1.0
du2_0 = 1.0

u3_0  = 1.0
du3_0 = 1.0

u4_0  = 1.0 #Gimbal interno
du4_0 = 1.0 #110rad/s = 1050 rpm's

u5_0  = 1.0 # Rotor
du5_0 = 1.0

#Condiciones iniciales lazo cerrado
#u1_0  = 0.0
#du1_0 = 0.0
#
#u2_0  = 0.0
#du2_0 = 0.0
#
#u3_0  = 0.0
#du3_0 = 0.0
#
#u4_0  = 0.0 #Gimbal interno
#du4_0 = 0.0 #110rad/s = 1050 rpm's
#
#u5_0  = 0.0 # Rotor
#du5_0 = 0.0


# Inversion
#u4_0  = 0.0 #Gimbal interno
#du4_0 = 110.0 #110rad/s = 1050 rpm's
#
#u5_0  = pi/4 # Rotor
#du5_0 = 0.0

u0=[u1_0,u2_0,u3_0,u4_0,u5_0]
du0=[du1_0,du2_0,du3_0,du4_0,du5_0]
#Parametros de CONTROL
θᵈ = pi/4;
vᵈ = 110.0;
p = [θᵈ,vᵈ];

prob=ODEProblem(rotor,vcat(u0,du0),tspan,dt=0.01,saveat=0.01)


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
traces1 = PlotlyJS.scatter(x=tiempo, y=t1, mode="lines",aspect_ratio=1)
traces2 = PlotlyJS.scatter(x=tiempo, y=t2, mode="lines",aspect_ratio=1)
traces3 = PlotlyJS.scatter(x=tiempo, y=t3, mode="lines",aspect_ratio=1)
traces4 = PlotlyJS.scatter(x=tiempo, y=t4, mode="lines",aspect_ratio=1)
traces5 = PlotlyJS.scatter(x=tiempo, y=t5, mode="lines",aspect_ratio=1)

#Velocidades
traces6 = PlotlyJS.scatter(x=tiempo, y=t1p, mode="lines",name="t1p(t)")
traces7 = PlotlyJS.scatter(x=tiempo, y=t2p, mode="lines",name="t2p(t)")
traces8 = PlotlyJS.scatter(x=tiempo, y=t3p, mode="lines",name="t3p(t)")
traces9 = PlotlyJS.scatter(x=tiempo, y=t4p, mode="lines",name="t4p(t)")
traces10 = PlotlyJS.scatter(x=tiempo, y=t5p, mode="lines",name="t5p(t)")

#Términos
traces11 = PlotlyJS.scatter(x=tiempo, y=datos, mode="lines",name="p_6")

pos = plot([traces1,traces2,traces3,traces4,traces5], Layout(title="Posiciones Sistema Reducido Estadistico .1%"))
#vel = plot([traces6,traces7,traces8,traces9,traces10], Layout(title="Velocidades"))
#termino = plot(traces11, Layout(title="Terminos"))
#display(fase)
#display(TD)
display(pos)
#display(MomAng)
#display(vel)
#savefig(pos, "SR_001.svg")
#savefig(pos, "PosicionOriginal.png")