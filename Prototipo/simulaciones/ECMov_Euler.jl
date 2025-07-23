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

qd1, qd2, qd3 = p

    #primsa
    Ix = 1
    Iy = 2
    Iz = 3

    m11 = Ix*cos(u[2])*cos(u[3]) 
    m12 = -Ix*sin(u[3]) 
    m13 = 0 
    
     m21 = Iy*cos(u[2])*sin(u[3]) 
    m22 = Iy*cos(u[3]) 
    m23 = 0 
    
     m31 = -Iz*sin(u[2]) 
    
     m32 = 0 
    
     m33 = Iz 
     
     c11 = -(1/2)*((2*Ix-2*Iy+2*Iz)*du[2]*sin(u[2])*cos(u[3])+((-Iy)+Iz)*du[1]*sin(2*u[2])*sin(u[3])) 
    c12 = ((-Ix)-Iy+Iz)*du[3]*cos(u[3]) 
    
     c13 = ((-Ix)-Iy+Iz)*du[1]*cos(u[2])*sin(u[3]) 
    c21 = -(1/2)*((Ix-Iz)*du[1]*sin(2*u[2])*cos(u[3])+((-2*Ix)+2*Iy+2*Iz)*du[2]*sin(u[2])*sin(u[3])) 
    c22 = ((-Ix)-Iy+Iz)*du[3]*sin(u[3]) 
    
     c23 = (Ix+Iy-Iz)*du[1]*cos(u[2])*cos(u[3]) 
    c31 = (1/4)*((-4*Iz*du[2]*cos(u[2]))+((-4*Ix)+4*Iy)*du[2]*cos(u[2])*cos(2*u[3])+(((-Ix)+Iy)*du[1]+((-Ix)+Iy)*du[1]*cos(2*u[2]))*sin(2*u[3])) 
    c32 = -(1/2)*((-Ix)+Iy)*du[2]*sin(2*u[3]) 
    
     c33 = 0 

    M=[m11 m12 m13;m21 m22 m23;m31 m32 m33]
    C=[c11 c12 c13;c21 c22 c23;c31 c32 c33]

    K1 = 5
    K0 = 1
    
    qt1 = qd1-u[1]
    qtp1 = - du[1]

    qt2 = qd2-u[2]
    qtp2 = - du[2]

    qt3 = qd3-u[3]
    qtp3 = - du[3]


    u1=K0*qt1 + K1*qtp1
    u2=K0*qt2 + K1*qtp2
    u3=K0*qt3 + K1*qtp3


    #tau = [u1;u2;u3]
    tau = [0;0;0]

    ddu = inv(M)*(-C*du + tau )

end

  qd1 = 0.0
  qd2 = 0.0
  qd3 = 0.0

  w20 = 1.0

    u1_0  = 0.01
    du1_0 = 0.0
    
    u2_0  = 0.0
    du2_0 = cos(u1_0)*w20
    
    u3_0  = 0.01
    du3_0 = sin(u1_0)*w20

    
    u0=[u1_0,u2_0,u3_0]
    du0=[du1_0,du2_0,du3_0]

    tspan = (0.0,40.0)

    p = [qd1,qd2,qd3]
  

    prob=SecondOrderODEProblem(rotor,du0,u0,tspan,dt=0.001,saveat=0.001,p)
    
      # Events
function condition(t,integrator)
     t in collect(20:0.001:30)
        affect!(integrator)
        qd = integrator.p
         #integrator.p = qd
        println("t = $t, \t a = $qd")
    
    
end

function affect!(integrator)
    integrator.p = 0.0
end

cb = DiscreteCallback(condition, affect!)

    
global sol = solve(prob)

    df=DataFrame(sol)
    json_str = JSON.json(df)

open("./Prototipo/simulaciones/datos_Euler.json", "w") do io
    write(io, json_str)
end  

traces = Vector{AbstractTrace}() 

t1p = [u[1] for u in sol.u]
t2p = [u[2] for u in sol.u]
t3p = [u[3] for u in sol.u]

t1 = [u[4] for u in sol.u]
t2 = [u[5] for u in sol.u]
t3 = [u[6] for u in sol.u]

function angulo_continuo(theta)
    vuelta_completa = 2*pi  # 2*pi es una vuelta completa en radianes
    return theta .- floor.(theta ./ vuelta_completa) .* vuelta_completa
end

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


display(TD)
display(pos)
display(vel)