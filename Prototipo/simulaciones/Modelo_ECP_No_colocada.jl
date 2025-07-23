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
    t = 40.0
    tspan = (0.0,t)
    datos = []
    savetimes = 0.0:0.01:t;

    function pared_suave(q, dq, q_pared, k, c)
       if q > q_pared
           return -k * (q - q_pared) - c * dq
       else
           return 0.0
       end
   end

function rotor(du,u,p,t)

Iz1 = 0.067

Ix2 = 0.012
Iy2 = 0.018
Iz2 = 0.030

Ix3 = 0.0092
Iy3 = 0.023
Iz3 = 0.022

Ix4 = 0.015
Iy4 = 0.027


a1 = 3*Ix4+Iy3+Iy4+4*Iz1+2*Iz2+Iz3
a2 = (-Ix4)+Iy3+Iy4-Iz3
a3 = 2*Ix3+4*Ix4-2*Iy3-2*Iy4+2*Iz3
a4 = Iy4
a5 = 2*Ix2+2*Ix3+Ix4-Iy3-Iy4-2*Iz2-Iz3
a6 = (-Ix4)-2*Iy2-Iy3-Iy4-Iz3
a7 = 2*Ix2+2*Ix3


m11 = -(1/4)*((-a1)+(1+cos(2*u[2]))*cos(2*u[3])*a2+cos(2*u[2])*a5-a7) 
m12 = (1/2)*cos(u[2])*sin(2*u[3])*a2 
m13 = -(1/2)*sin(u[2])*(2*a2+a3) 
m14 = cos(u[2])*sin(u[3])*a4 

m22 = (1/2)*(cos(2*u[3])*a2-a6) 
m23 = 0 
m24 = cos(u[3])*a4 

m33 = (1/2)*(2*a2+a3) 
m34 = 0 

m44 = a4 

c11 = (1/2)*(du[3]*(1+cos(2*u[2]))*sin(2*u[3])*a2+du[2]*sin(2*u[2])*(cos(2*u[3])*a2+a5)) 
c12 = -(1/2)*(du[2]*sin(u[2])*sin(2*u[3])*a2+du[3]*cos(u[2])*((2-2*cos(2*u[3]))*a2+a3)+2*du[4]*sin(u[2])*sin(u[3])*a4) 
c13 = du[4]*cos(u[2])*cos(u[3])*a4 

c14 = 0 

c21 = (1/4)*(du[3]*cos(u[2])*((4+4*cos(2*u[3]))*a2+2*a3)+4*du[4]*sin(u[2])*sin(u[3])*a4+du[1]*sin(2*u[2])*((-cos(2*u[3])*a2)-a5)) 
c22 = -du[3]*sin(2*u[3])*a2 

c23 = -du[4]*sin(u[3])*a4 
c24 = 0 

c31 = -(1/4)*(du[1]*(1+cos(2*u[2]))*sin(2*u[3])*a2+du[2]*cos(u[2])*((4+4*cos(2*u[3]))*a2+2*a3)+4*du[4]*cos(u[2])*cos(u[3])*a4) 
c32 = (1/2)*(du[2]*sin(2*u[3])*a2+2*du[4]*sin(u[3])*a4) 
c33 = 0 

c34 = 0 

c41 = du[3]*cos(u[2])*cos(u[3])*a4-du[2]*sin(u[2])*sin(u[3])*a4 
c42 = -du[3]*sin(u[3])*a4 

c43 = 0 

c44 = 0  

C=[c11 c12 c13 c14
   c21 c22 c23 c24
   c31 c32 c33 c34
   c41 c42 c43 c44];

M11 = [m11 m12
       m12 m22]
M12 = [m13 m14
       m23 m24]

M21 = [m13 m23
       m14 m24]

M22 = [m33 m34 
       m34 m44];

#Sistema v2
h = C*du[1:4];
h1 = h[1:2,:];
h2 = h[3:4,:];

M22b = M22 - M21*inv(M11)*M12
h2b = h2 - M21*inv(M11)*h1

kd = [5E-1 0    # z
       0 1E1]  # y

kp = [5E-1 0    # z
       0 1E1]  # y

q1p = [-du[1]
       -du[2]]

q1 = [pi/4-u[1]
      pi/4-u[2]]

 p = 1;

 
 torque_pared = pared_suave(u[3], du[3], 0.2, 1,1)

v1 = kd*(q1p) + kp*(q1) + [torque_pared;0]
v2 = -pinv(M12) * (h1 + M11 * v1)

τ = M22b*v2 + h2b;

μ1 = [1E-3*du[1]  #z
      1E-1*du[2]] #y
μ2 = [1E-3*du[3]   #gim
      1E-6*du[4]] #disco

μ2b = μ2 - M21*inv(M11)*μ1
du[1:4] .= u[5:8] 
du[5:6] .= inv(M11)*(-M12*(v2 - inv(M22b)*μ2b) - h1 - μ1)
du[7:8] .= inv(M22b)*(τ - h2b - μ2b)
end


u1_0  = 0.0
du1_0 = 0.0

u2_0  = 0.0 
du2_0 = 0.0

u3_0  = 0.0
du3_0 = 0.0

u4_0  = 0.0 
du4_0 = 0.0


u0=[u1_0,u2_0,u3_0,u4_0]
du0=[du1_0,du2_0,du3_0,du4_0]

               
prob=ODEProblem(rotor,vcat(u0,du0),tspan,dt=0.01,saveat=0.01)

#TRBDF2
global sol = solve(prob,Tsit5(),maxiters=2_000_000,tstops=savetimes)

df=DataFrame(sol)
json_str = JSON.json(df)

open("./Prototipo/simulaciones/datos_ECP_Model.json", "w") do io
    write(io, json_str)
end  

traces = Vector{AbstractTrace}() 
#Posicones
t1 = [u[1] for u in sol.u]
t2 = [u[2] for u in sol.u]
t3 = [u[3] for u in sol.u]
t4 = [u[4] for u in sol.u]
#Velocidades
t1p = [u[5] for u in sol.u]
t2p = [u[6] for u in sol.u]
t3p = [u[7] for u in sol.u]
t4p = [u[8] for u in sol.u]

t1e = (t1)
t2e = (t2)
t3e = (t3)

tiempo = sol.t

#Posiciones
traces1 = PlotlyJS.scatter(x=tiempo, y=t1, mode="lines",name="q₁(t)",line=attr(color="red"))
traces2 = PlotlyJS.scatter(x=tiempo, y=t2, mode="lines",name="q₂(t)",line=attr(color="green"))
traces3 = PlotlyJS.scatter(x=tiempo, y=t3, mode="lines",name="q₃(t)",line=attr(color="blue"))
traces4 = PlotlyJS.scatter(x=tiempo, y=t4, mode="lines",name="q₄(t)")

#Velocidades
traces6 = PlotlyJS.scatter(x=tiempo, y=t1p, mode="lines",name="t1p(t)")
traces7 = PlotlyJS.scatter(x=tiempo, y=t2p, mode="lines",name="t2p(t)")
traces8 = PlotlyJS.scatter(x=tiempo, y=t3p, mode="lines",name="t3p(t)")
traces9 = PlotlyJS.scatter(x=tiempo, y=t4p, mode="lines",name="t4p(t)")


pos = plot([traces1,traces2,traces3,traces4], Layout(title="Posiciones, x1(0) = $u1_0, x2(0) = $u2_0, x3(0) = $u3_0",
    xaxis=attr(title="Tiempo [s]"),yaxis=attr(title="Posicion [rad]")))
vel = plot([traces6,traces7,traces8,traces9], Layout(title="Velocidades, x1p(0) = $du1_0, x2p(0) = $du2_0, x3p(0) = $du3_0"))


display(vel)
display(pos)

#savefig(pos, "./Prototipo/simulaciones/Graficas/Linealizacion_No_colocada_Simetria.svg")


