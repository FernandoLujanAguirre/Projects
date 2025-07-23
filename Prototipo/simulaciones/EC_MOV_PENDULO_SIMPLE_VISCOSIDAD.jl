using DifferentialEquations
using LinearAlgebra
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
    t = 100.0
    tspan = (0.0,t)
    datos = []
    savetimes = 0.0:0.01:t;
function pendulo!(du,u,p,t)
   
    l = 1.1;
    b = 0.1;

    M = l;

    g = 9.81*sin(u[1])  
   
    v = b*u[2]

    du[1] = u[2]     
    # Lazo abierto
    du[2] = inv(M)*(-g) - v

end
#Condiciones iniciales inversion

# Condiciones lazo abierto
u1_0  = 1.0
du1_0 = 0.0



u0 = u1_0
du0 = du1_0

prob=ODEProblem(pendulo!,vcat(u0,du0),tspan,dt=0.01,saveat=0.01)

global sol = solve(prob,TRBDF2(),tstops=savetimes)



#Posicones
t1 = [u[1] for u in sol.u]
#Velocidades
t1p = [u[2] for u in sol.u]


tiempo = sol.t
#Posiciones
traces1 = PlotlyJS.scatter(x=tiempo, y=t1, mode="lines",name="t1(t)")

#Velocidades
traces2 = PlotlyJS.scatter(x=tiempo, y=t1p, mode="lines",name="t1p(t)")

pos = plot(traces1, Layout(title="Pendulo simple"))
vel = plot(traces2, Layout(title="Velocidades"))

display(pos)

