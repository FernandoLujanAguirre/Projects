using DifferentialEquations
using LinearAlgebra
using LaTeXStrings
using MathJaxRenderer
using SimulationLogs
using JSON
using DataFrames
using PlotlyJS
using ControlSystems


#PARAMETROS

t = 234.0
tspan = (0.0,t)
datos = []

savetimes = 0.0:0.01:t;

function rotor(du,u,p,t)
    #Satélite
    Ix = 3.4e-3
    Iy = 4.2e-3
    Iz = 7.4e-4

    a1 = Ix+Iy-2*Iz
    a2 = Ix-Iy
    a3 = Iz

    m11 = (1/4)*(a1+4*a3+a1*cos(2*u[2])+(a2+a2*cos(2*u[2]))*cos(2*u[3])) 
    m12 = -(1/2)*(a2*cos(u[2])*sin(2*u[3])) 
    m13 = -a3*sin(u[2]) 

    m22 = -(1/2)*((-a1)-2*a3+a2*cos(2*u[3])) 
    m23 = 0 

    m33 = a3 


    M = [m11 m12 m13
    m12 m22 m23
    m13 m23 m33]

    c11 = -(1/2)*((a1+a2*cos(2*u[3]))*sin(2*u[2])*du[2]) 
    c12 = -(1/2)*((-a2*sin(u[2])*sin(2*u[3])*du[2])+(2*a3+2*a2*cos(2*u[3]))*cos(u[2])*du[3]) 
    c13 = -(1/2)*((a2+a2*cos(2*u[2]))*sin(2*u[3])*du[1]) 
    c21 = (1/4)*((a1+a2*cos(2*u[3]))*sin(2*u[2])*du[1]) 
    c22 = a2*sin(2*u[3])*du[3] 
    c23 = (a3-a2*cos(2*u[3]))*cos(u[2])*du[1] 

    c31 = (1/4)*((a2+a2*cos(2*u[2]))*sin(2*u[3])*du[1]+((-4*a3)+4*a2*cos(2*u[3]))*cos(u[2])*du[2]) 
    c32 = -(1/2)*(a2*sin(2*u[3])*du[2]) 

    c33 = 0  

    C = [c11 c12 c13
    c21 c22 c23
    c31 c32 c33]


    du[1:3] .= (u[4:6] )
    du[4:6] .= inv(M)*( - C*du[1:3])      
end

# Velocdad incial maxima en los 3 ejes de 0.2 = 11.46grados/s
u1_0  = 0.0
du1_0 = 3.0

u2_0  = 0.0
du2_0 = 0.0

u3_0  = 0.05
du3_0 = 0.0


u0=[u1_0,u2_0,u3_0]
du0=[du1_0,du2_0,du3_0]


prob=ODEProblem(rotor,vcat(u0,du0),tspan,dt=0.01,saveat=0.01)


#TRBDF2
global sol = solve(prob,Tsit5(),maxiters=2_000_000,tstops=savetimes)

df=DataFrame(sol)
json_str = JSON.json(df)

open("/home/fernando/Documents/Projects/Simulations/Satellite/data/Satellite_data.json", "w") do io
    write(io, json_str)
end  
open("/home/fernando/Documents/Three_projects/proyectos/Objeto_en_rotacion_libre/datos/datos_rotor.json", "w") do io
    write(io, json_str)
end  

traces = Vector{AbstractTrace}() 
#Posicones
t1 = [u[1] for u in sol.u]
t2 = [u[2] for u in sol.u]
t3 = [u[3] for u in sol.u]

#Velocidades
t1p = [u[4] for u in sol.u]
t2p = [u[5] for u in sol.u]
t3p = [u[6] for u in sol.u]

tiempo = sol.t

#Posiciones
traces1 = PlotlyJS.scatter(x=tiempo, y=t1*(180/pi), mode="lines",name=L"$\theta_1(t)$",legendgroup="Grupo A",line=attr(color="red"))
traces2 = PlotlyJS.scatter(x=tiempo, y=t2*(180/pi), mode="lines",name=L"$\theta_2(t)$",legendgroup="Grupo B",line=attr(color="green"))
traces3 = PlotlyJS.scatter(x=tiempo, y=t3*(180/pi), mode="lines",name=L"$\theta_3(t)$",legendgroup="Grupo C",line=attr(color="blue"),visible="legendonly")
#Velocidades
traces4 = PlotlyJS.scatter(x=tiempo, y=t1p, mode="lines",name=L"\dot\theta_1(t)",legendgroup="Grupo E",line=attr(color="red"))
traces5 = PlotlyJS.scatter(x=tiempo, y=t2p, mode="lines",name=L"\dot\theta_2(t)",legendgroup="Grupo E",line=attr(color="green"))
traces6 = PlotlyJS.scatter(x=tiempo, y=t3p, mode="lines",name=L"\dot\theta_3(t)",legendgroup="Grupo F",line=attr(color="blue"),visible="legendonly")



pos = plot([traces1,traces2,traces3], 
Layout(title= "\$\\text{Posiciones: }\\theta_1(0) = $(u1_0)\\text{, } \\theta_2(0) = $(u2_0)\\text{, } \\theta_3(0) = $(u3_0)\$",
xaxis=attr(title="Tiempo [s]",gridcolor="black"),yaxis=attr(title="Posicion [rad]",gridcolor="black")))

vel = plot([traces4,traces5,traces6], 
Layout(title="\$\\text{Velocidades: }\\dot\\theta_1(0) = $(du1_0)\\text{, } \\dot\\theta_2(0) = $(du2_0)\\text{, } \\dot\\theta_3(0) = $(du3_0)\$",
xaxis=attr(title="Tiempo [s]",gridcolor="black"),yaxis=attr(title="Posicion [rad/s]",gridcolor="black")))
subplots= [pos; vel];



relayout!(subplots, 
         template="simple_white",
         title_text="Sat + Giro",
         width = 900,
         height=900, 
           xaxis = attr(
               tickmode = "linear",
               gridcolor="black",
               tick0 = 0.0,
               dtick = 100.0),
           xaxis2 = attr(
               tickmode = "linear",
               gridcolor="black",
               tick0 = 0.0,
               dtick = 100.0),
       )


savefig(subplots, "/home/fernando/Documents/Projects/Simulations/Satellite/Graphs/Satellite_movement.html");

run(`notify-send "✅ Simulación Julia" "Tu simulación ha terminado."`)

#run(`xdg-open ./Prototipo/simulaciones/Graficas/Linealizacion_No_colocada_Simetria.html`)
#savefig(pos, "./Prototipo/simulaciones/Graficas/Linealizacion_No_colocada_Simetria.svg")