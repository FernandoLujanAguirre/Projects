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
    qd, vref = p

    Is = 4.324e-4

    #primsa
    Ix = 0.00000139
    Iy = 0.00000887
    Iyz = -6.1e-7

    #disco
    #Ix = 90
    #Iy = 90
    #Iz = 180

    m11 = (1/8)*(3*Ix+5*Iy+((-Ix)+Iy)*cos(2*u[2])+(Ix-Iy+(Ix-Iy)*cos(2*u[2]))*cos(2*u[3])-8*Iyz*sin(2*u[2])*sin(u[3])*cos(u[4])+((-4*Iyz)-4*Iyz*cos(2*u[2]))*sin(2*u[3])*sin(u[4])+((-Ix)+Iy+(3*Ix-3*Iy)*cos(2*u[2])+(Ix-Iy+(Ix-Iy)*cos(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+((-4*Ix)+4*Iy)*sin(2*u[2])*cos(u[3])*sin(2*u[4])+8*Is) 
    m12 = -(1/4)*((Ix-Iy)*cos(u[2])*sin(2*u[3])+4*Iyz*sin(u[2])*cos(u[3])*cos(u[4])+4*Iyz*cos(u[2])*cos(2*u[3])*sin(u[4])+(Ix-Iy)*cos(u[2])*sin(2*u[3])*cos(2*u[4])+((-2*Ix)+2*Iy)*sin(u[2])*sin(u[3])*sin(2*u[4])) 
    m13 = -(1/2)*((Ix+Iy)*sin(u[2])-2*Iyz*cos(u[2])*sin(u[3])*cos(u[4])+((-Ix)+Iy)*sin(u[2])*cos(2*u[4])+((-Ix)+Iy)*cos(u[2])*cos(u[3])*sin(2*u[4])+2*sin(u[2])*Is) 
    m14 = Iy*cos(u[2])*sin(u[3])-Iyz*sin(u[2])*cos(u[4])-Iyz*cos(u[2])*cos(u[3])*sin(u[4]) 
    m21 = -(1/4)*((Ix-Iy)*cos(u[2])*sin(2*u[3])+4*Iyz*sin(u[2])*cos(u[3])*cos(u[4])+4*Iyz*cos(u[2])*cos(2*u[3])*sin(u[4])+(Ix-Iy)*cos(u[2])*sin(2*u[3])*cos(2*u[4])+((-2*Ix)+2*Iy)*sin(u[2])*sin(u[3])*sin(2*u[4])) 
    m22 = (1/4)*(Ix+3*Iy+((-Ix)+Iy)*cos(2*u[3])+4*Iyz*sin(2*u[3])*sin(u[4])+(Ix-Iy+((-Ix)+Iy)*cos(2*u[3]))*cos(2*u[4])+4*Is) 
    m23 = (1/2)*(2*Iyz*cos(u[3])*cos(u[4])+((-Ix)+Iy)*sin(u[3])*sin(2*u[4])) 
    m24 = Iy*cos(u[3])+Iyz*sin(u[3])*sin(u[4]) 
    m31 = -(1/2)*((Ix+Iy)*sin(u[2])-2*Iyz*cos(u[2])*sin(u[3])*cos(u[4])+((-Ix)+Iy)*sin(u[2])*cos(2*u[4])+((-Ix)+Iy)*cos(u[2])*cos(u[3])*sin(2*u[4])+2*sin(u[2])*Is) 
    m32 = (1/2)*(2*Iyz*cos(u[3])*cos(u[4])+((-Ix)+Iy)*sin(u[3])*sin(2*u[4])) 
    m33 = (1/2)*(Ix+Iy+((-Ix)+Iy)*cos(2*u[4])+2*Is) 
    m34 = Iyz*cos(u[4]) 
    
     m41 = Iy*cos(u[2])*sin(u[3])-Iyz*sin(u[2])*cos(u[4])-Iyz*cos(u[2])*cos(u[3])*sin(u[4]) 
    m42 = Iy*cos(u[3])+Iyz*sin(u[3])*sin(u[4]) 
    m43 = Iyz*cos(u[4]) 
    
     m44 = Iy 
     
     c11 = (1/4)*((Ix-Iy)*du[2]*sin(2*u[2])+((-Ix)+Iy)*du[2]*sin(2*u[2])*cos(2*u[3])+(((-Ix)+Iy)*du[3]+((-Ix)+Iy)*du[3]*cos(2*u[2]))*sin(2*u[3])+((-4*Iyz*du[3]*sin(2*u[2])*cos(u[3]))-8*Iyz*du[2]*cos(2*u[2])*sin(u[3])+((-2*Iyz*du[4])-2*Iyz*du[4]*cos(2*u[2]))*sin(2*u[3]))*cos(u[4])+(4*Iyz*du[4]*sin(2*u[2])*sin(u[3])+((-4*Iyz*du[3])-4*Iyz*du[3]*cos(2*u[2]))*cos(2*u[3])+4*Iyz*du[2]*sin(2*u[2])*sin(2*u[3]))*sin(u[4])+(((-3*Ix)+3*Iy)*du[2]*sin(2*u[2])+((-4*Ix)+4*Iy)*du[4]*sin(2*u[2])*cos(u[3])+((-Ix)+Iy)*du[2]*sin(2*u[2])*cos(2*u[3])+(((-Ix)+Iy)*du[3]+((-Ix)+Iy)*du[3]*cos(2*u[2]))*sin(2*u[3]))*cos(2*u[4])+((Ix-Iy)*du[4]+((-3*Ix)+3*Iy)*du[4]*cos(2*u[2])+((-4*Ix)+4*Iy)*du[2]*cos(2*u[2])*cos(u[3])+(2*Ix-2*Iy)*du[3]*sin(2*u[2])*sin(u[3])+(((-Ix)+Iy)*du[4]+((-Ix)+Iy)*du[4]*cos(2*u[2]))*cos(2*u[3]))*sin(2*u[4])) 
    c12 = -(1/4)*((2*Ix+2*Iy)*du[3]*cos(u[2])+4*Iy*du[4]*sin(u[2])*sin(u[3])+(2*Ix-2*Iy)*du[3]*cos(u[2])*cos(2*u[3])+((-Ix)+Iy)*du[2]*sin(u[2])*sin(2*u[3])+(4*Iyz*du[4]*cos(u[2])+4*Iyz*du[2]*cos(u[2])*cos(u[3])+4*Iyz*du[4]*cos(u[2])*cos(2*u[3]))*cos(u[4])+((-8*Iyz*du[4]*sin(u[2])*cos(u[3]))-4*Iyz*du[2]*sin(u[2])*cos(2*u[3])-8*Iyz*du[3]*cos(u[2])*sin(2*u[3]))*sin(u[4])+(((-2*Ix)+2*Iy)*du[3]*cos(u[2])+((-4*Ix)+4*Iy)*du[4]*sin(u[2])*sin(u[3])+(2*Ix-2*Iy)*du[3]*cos(u[2])*cos(2*u[3])+((-Ix)+Iy)*du[2]*sin(u[2])*sin(2*u[3]))*cos(2*u[4])+(((-2*Ix)+2*Iy)*du[2]*cos(u[2])*sin(u[3])+((-2*Ix)+2*Iy)*du[4]*cos(u[2])*sin(2*u[3]))*sin(2*u[4])+4*du[3]*cos(u[2])*Is) 
    c13 = (1/2)*(2*Iy*du[4]*cos(u[2])*cos(u[3])+2*Iyz*du[3]*cos(u[2])*cos(u[3])*cos(u[4])+(2*Ix-2*Iy)*du[4]*cos(u[2])*cos(u[3])*cos(2*u[4])+(((-2*Ix)+2*Iy)*du[4]*sin(u[2])+((-Ix)+Iy)*du[3]*cos(u[2])*sin(u[3]))*sin(2*u[4])) 
    c14 = (-Iyz*du[4]*cos(u[2])*cos(u[3])*cos(u[4]))+Iyz*du[4]*sin(u[2])*sin(u[4]) 
    c21 = (1/8)*((4*Ix+4*Iy)*du[3]*cos(u[2])+((-Ix)+Iy)*du[1]*sin(2*u[2])+8*Iy*du[4]*sin(u[2])*sin(u[3])+(((-4*Ix)+4*Iy)*du[3]*cos(u[2])+(Ix-Iy)*du[1]*sin(2*u[2]))*cos(2*u[3])+(8*Iyz*du[4]*cos(u[2])+(16*Iyz*du[3]*sin(u[2])+8*Iyz*du[1]*cos(2*u[2]))*sin(u[3])-8*Iyz*du[4]*cos(u[2])*cos(2*u[3]))*cos(u[4])+(16*Iyz*du[3]*cos(u[2])-4*Iyz*du[1]*sin(2*u[2]))*sin(2*u[3])*sin(u[4])+(((-4*Ix)+4*Iy)*du[3]*cos(u[2])+(3*Ix-3*Iy)*du[1]*sin(2*u[2])+(8*Ix-8*Iy)*du[4]*sin(u[2])*sin(u[3])+(((-4*Ix)+4*Iy)*du[3]*cos(u[2])+(Ix-Iy)*du[1]*sin(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+(((8*Ix-8*Iy)*du[3]*sin(u[2])+(4*Ix-4*Iy)*du[1]*cos(2*u[2]))*cos(u[3])+(4*Ix-4*Iy)*du[4]*cos(u[2])*sin(2*u[3]))*sin(2*u[4])+8*du[3]*cos(u[2])*Is) 
    c22 = -(1/2)*(((-Ix)+Iy)*du[3]*sin(2*u[3])-2*Iyz*du[4]*sin(2*u[3])*cos(u[4])-4*Iyz*du[3]*cos(2*u[3])*sin(u[4])+((-Ix)+Iy)*du[3]*sin(2*u[3])*cos(2*u[4])+((Ix-Iy)*du[4]+((-Ix)+Iy)*du[4]*cos(2*u[3]))*sin(2*u[4])) 
    c23 = (1/2)*((-2*Iy*du[4]*sin(u[3]))-2*Iyz*du[3]*sin(u[3])*cos(u[4])+((-2*Ix)+2*Iy)*du[4]*sin(u[3])*cos(2*u[4])+((-Ix)+Iy)*du[3]*cos(u[3])*sin(2*u[4])) 
    c24 = Iyz*du[4]*sin(u[3])*cos(u[4]) 
    
     c31 = -(1/8)*((4*Ix+4*Iy)*du[2]*cos(u[2])+8*Iy*du[4]*cos(u[2])*cos(u[3])+((-4*Ix)+4*Iy)*du[2]*cos(u[2])*cos(2*u[3])+(((-Ix)+Iy)*du[1]+((-Ix)+Iy)*du[1]*cos(2*u[2]))*sin(2*u[3])+((-4*Iyz*du[1]*sin(2*u[2])*cos(u[3]))+16*Iyz*du[2]*sin(u[2])*sin(u[3]))*cos(u[4])+(16*Iyz*du[4]*cos(u[2])*sin(u[3])+((-4*Iyz*du[1])-4*Iyz*du[1]*cos(2*u[2]))*cos(2*u[3])+16*Iyz*du[2]*cos(u[2])*sin(2*u[3]))*sin(u[4])+(((-4*Ix)+4*Iy)*du[2]*cos(u[2])+((-8*Ix)+8*Iy)*du[4]*cos(u[2])*cos(u[3])+((-4*Ix)+4*Iy)*du[2]*cos(u[2])*cos(2*u[3])+(((-Ix)+Iy)*du[1]+((-Ix)+Iy)*du[1]*cos(2*u[2]))*sin(2*u[3]))*cos(2*u[4])+((8*Ix-8*Iy)*du[4]*sin(u[2])+(8*Ix-8*Iy)*du[2]*sin(u[2])*cos(u[3])+(2*Ix-2*Iy)*du[1]*sin(2*u[2])*sin(u[3]))*sin(2*u[4])+8*du[2]*cos(u[2])*Is) 
    c32 = (1/4)*(4*Iy*du[4]*sin(u[3])+((-Ix)+Iy)*du[2]*sin(2*u[3])+((-8*Iyz*du[4]*cos(u[3]))-4*Iyz*du[2]*cos(2*u[3]))*sin(u[4])+(((-4*Ix)+4*Iy)*du[4]*sin(u[3])+((-Ix)+Iy)*du[2]*sin(2*u[3]))*cos(2*u[4])) 
    c33 = (Ix-Iy)*du[4]*sin(2*u[4]) 
    
     c34 = -Iyz*du[4]*sin(u[4]) 
    c41 = (1/8)*(8*Iy*du[3]*cos(u[2])*cos(u[3])-8*Iy*du[2]*sin(u[2])*sin(u[3])+((-8*Iyz*du[2]*cos(u[2]))+8*Iyz*du[2]*cos(u[2])*cos(2*u[3])+(2*Iyz*du[1]+2*Iyz*du[1]*cos(2*u[2]))*sin(2*u[3]))*cos(u[4])+(16*Iyz*du[3]*cos(u[2])-4*Iyz*du[1]*sin(2*u[2]))*sin(u[3])*sin(u[4])+((((-8*Ix)+8*Iy)*du[3]*cos(u[2])+(4*Ix-4*Iy)*du[1]*sin(2*u[2]))*cos(u[3])+((-8*Ix)+8*Iy)*du[2]*sin(u[2])*sin(u[3]))*cos(2*u[4])+(((-Ix)+Iy)*du[1]+(8*Ix-8*Iy)*du[3]*sin(u[2])+(3*Ix-3*Iy)*du[1]*cos(2*u[2])+((Ix-Iy)*du[1]+(Ix-Iy)*du[1]*cos(2*u[2]))*cos(2*u[3])+((-4*Ix)+4*Iy)*du[2]*cos(u[2])*sin(2*u[3]))*sin(2*u[4])) 
    c42 = (1/4)*((-4*Iy*du[3]*sin(u[3]))-2*Iyz*du[2]*sin(2*u[3])*cos(u[4])+8*Iyz*du[3]*cos(u[3])*sin(u[4])+(4*Ix-4*Iy)*du[3]*sin(u[3])*cos(2*u[4])+((Ix-Iy)*du[2]+((-Ix)+Iy)*du[2]*cos(2*u[3]))*sin(2*u[4])) 
    c43 = (1/2)*((-Ix)+Iy)*du[3]*sin(2*u[4]) 
    
     c44 = 0     
 

    M=[m11 m12 m13 m14;m21 m22 m23 m24;m31 m32 m33 m34;m41 m42 m43 m44]
    C=[c11 c12 c13 c14;c21 c22 c23 c24;c31 c32 c33 c34;c41 c42 c43 c44]
    k_p = 0.1 
    u4 = k_p*(vref - du[4]) 
    ddu = inv(M)*(-C*du + [0;0;0;u4])



end

  
    qd = 1.56
    vref = 10.0

    w20 = 1.0

    u1_0  = 0.0
    du1_0 = 0.0
    
    u2_0  = 0.0
    du2_0 = 0.0
    
    u3_0  = 0.0
    du3_0 = 0.0

    u4_0  = 0.0 #Gimbal interno
    du4_0 = 0.0
    
    u0=[u1_0,u2_0,u3_0,u4_0]
    du0=[du1_0,du2_0,du3_0,du4_0]

    tspan = (0.0,200.0)
  
    p = [qd, vref]

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

open("./Prototipo/simulaciones/datos_GCMRA_FDOF.json", "w") do io
    write(io, json_str)
end  

traces = Vector{AbstractTrace}() 

t1p = [u[1] for u in sol.u]
t2p = [u[2] for u in sol.u]
t3p = [u[3] for u in sol.u]
t4p = [u[4] for u in sol.u]


t1 = [u[5] for u in sol.u]
t2 = [u[6] for u in sol.u]
t3 = [u[7] for u in sol.u]
t4 = [u[8] for u in sol.u]

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
traces4 = PlotlyJS.scatter(x=tiempo, y=t4, mode="lines",name="t4(t)")

traces11 = PlotlyJS.scatter(x=t1, y=t2, mode="lines",name="t5(t)")


traces6 = PlotlyJS.scatter(x=tiempo, y=t1p, mode="lines",name="t1p(t)")
traces7 = PlotlyJS.scatter(x=tiempo, y=t2p, mode="lines",name="t2p(t)")
traces8 = PlotlyJS.scatter(x=tiempo, y=t3p, mode="lines",name="t3p(t)")
traces9 = PlotlyJS.scatter(x=tiempo, y=t4p, mode="lines",name="t4p(t)")


trace_point=scatter3d(x=[t1e[1]], y=[t2e[1]], z=[t3e[1]], mode="markers", 
                        marker=attr(size=8, color="red"), name="Condición Inicial")
traces3d=scatter3d(x=t1e, y=t2e, z=t3e, mode="lines", name="x0=$u0")

pos = plot([traces1,traces2,traces3,traces4], Layout(title="Posiciones"))
vel = plot([traces6,traces7,traces8,traces9], Layout(title="Velocidades"))
TD = plot([traces3d, trace_point], Layout(title="Diagrama de Fase 3D variando x0", scene=attr(aspectmode="cube")))

fase = plot(traces11, Layout(title="t1t2"))

display(fase)
display(TD)
display(pos)
display(vel)