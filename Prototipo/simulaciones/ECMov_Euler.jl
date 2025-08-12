using DifferentialEquations
using LinearAlgebra
#using Plots
using LaTeXStrings
using SciMLBase
using SimulationLogs
using JSON
using DataFrames
using PlotlyJS

    t = 1500.0
    tspan = (0.0,t)
    savetimes = 0.0:0.01:t;
function rotor(du,u,p,t)

Ix = 4
Iy = 5
Iz = 3

a1 = Ix+Iy-2*Iz
a2 = Ix-Iy
a3 = Iz
    

m11 = (1/4)*(a1+4*a3+a1*cos(2*u[2])+(a2+a2*cos(2*u[2]))*cos(2*u[3])) 
m12 = -(1/2)*(a2*cos(u[2])*sin(2*u[3])) 

m13 = -a3*sin(u[2]) 

m21 = -(1/2)*(a2*cos(u[2])*sin(2*u[3])) 
m22 = -(1/2)*((-a1)-2*a3+a2*cos(2*u[3])) 

m23 = 0 

m31 = -a3*sin(u[2]) 

m32 = 0 

m33 = a3 


c11 = -(1/2)*((a1+a2*cos(2*u[3]))*sin(2*u[2])*du[2]) 
c12 = -(1/2)*((-a2*sin(u[2])*sin(2*u[3])*du[2])+(2*a3+2*a2*cos(2*u[3]))*cos(u[2])*du[3]) 
c13 = -(1/2)*((a2+a2*cos(2*u[2]))*sin(2*u[3])*du[1]) 
c21 = (1/4)*((a1+a2*cos(2*u[3]))*sin(2*u[2])*du[1]) 
c22 = a2*sin(2*u[3])*du[3] 
c23 = (a3-a2*cos(2*u[3]))*cos(u[2])*du[1] 

 c31 = (1/4)*((a2+a2*cos(2*u[2]))*sin(2*u[3])*du[1]+((-4*a3)+4*a2*cos(2*u[3]))*cos(u[2])*du[2]) 
c32 = -(1/2)*(a2*sin(2*u[3])*du[2]) 

 c33 = 0 

    M=[m11 m12 m13;m21 m22 m23;m31 m32 m33]
    C=[c11 c12 c13;c21 c22 c23;c31 c32 c33]



du[1:3] .= (u[4:6] )
du[4:6] .= inv(M)*( - C*du[1:3] ) 
    

end

    u1_0  = 0.0
    du1_0 = 0.0
    
    u2_0  = 0.0
    du2_0 = 0.1
    
    u3_0  = 0.01
    du3_0 = 0.0

    
    u0=[u1_0,u2_0,u3_0]
    du0=[du1_0,du2_0,du3_0]



 prob=ODEProblem(rotor,vcat(u0,du0),tspan,dt=0.01,saveat=0.01)
global sol = solve(prob,Tsit5(),maxiters=2_000_000,tstops=savetimes)

  

  

    
sol = solve(prob)

    df=DataFrame(sol)
    json_str = JSON.json(df)

open("./Prototipo/simulaciones/datos_Euler.json", "w") do io
    write(io, json_str)
end  

traces = Vector{AbstractTrace}() 

t1p = [u[4] for u in sol.u]
t2p = [u[5] for u in sol.u]
t3p = [u[6] for u in sol.u]

t1 = [u[1] for u in sol.u]
t2 = [u[2] for u in sol.u]
t3 = [u[3] for u in sol.u]


t1e = (t1)
t2e = (t2)
t3e = (t3)



tiempo = sol.t

traces1 = PlotlyJS.scatter(x=tiempo, y=t1, mode="lines",name="t1(t)")
traces2 = PlotlyJS.scatter(x=tiempo, y=t2, mode="lines",name="t2(t)")
traces3 = PlotlyJS.scatter(x=tiempo, y=t3, mode="lines",name="t3(t)")




traces6 = PlotlyJS.scatter(x=tiempo, y=t1p, mode="lines",name="t1p(t)")
traces7 = PlotlyJS.scatter(x=tiempo, y=t2p, mode="lines",name="t2p(t)")
traces8 = PlotlyJS.scatter(x=tiempo, y=t3p, mode="lines",name="t3p(t)")


trace_point=scatter3d(x=[t1e[1]], y=[t2e[1]], z=[t3e[1]], mode="markers", 
                        marker=attr(size=8, color="red"), name="Condición Inicial")
traces3d=scatter3d(x=t1e, y=t2e, z=t3e, mode="lines", name="x0=$u0")

pos = plot([traces1,traces2,traces3], Layout(title="Posiciones"))
vel = plot([traces6,traces7,traces8], Layout(title="Velocidades"))
TD = plot([traces3d, trace_point], Layout(title="Diagrama de Fase 3D variando x0", scene=attr(aspectmode="cube")))



display(pos)
display(vel)