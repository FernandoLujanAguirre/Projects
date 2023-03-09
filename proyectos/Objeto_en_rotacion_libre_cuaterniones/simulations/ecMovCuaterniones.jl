using DifferentialEquations
using LinearAlgebra
using Plots
using LaTeXStrings
using SciMLBase
using LinearAlgebra
using SimulationLogs
using JSON
using DataFrames


function Conj(du,u,p,t)
    I11=1.083333333333333e-4;
    I22=3.766666666666666e-4;
    I33=4.816666666666666e-4;
    I3=Matrix(1.0I, 3, 3);  # Identity matrix of Float64 type;
    m=0.2;
    J=[I11 0 0;0 I22 0;0 0 I33];
    
    w=[u[1]; u[2]; u[3]];
    wTilde=[0 -u[3] u[2];u[3] 0 -u[1];-u[2] u[1] 0];
    wp=inv(J)*(-wTilde*J*w);

    du[1]=wp[1];
    du[2]=wp[2];
    du[3]=wp[3];

    du[4]=(-u[3]*u[7] -u[2]*u[6] -u[1]*u[5] )/2;
    du[5]=(-u[2]*u[7] +u[3]*u[6] +u[1]*u[4] )/2;
    du[6]=(u[1]*u[7] -u[3]*u[5] +u[2]*u[4] )/2;
    du[7]=(-u[1]*u[6] +u[2]*u[5] +u[3]*u[4] )/2;


    
end

u1_0=0.0;
u2_0=1;
u3_0=0.01;

u4_0=1.0;

u5_0=0;
u6_0=0;
u7_0=0;

u0=[u1_0,u2_0,u3_0,u4_0,u5_0,u6_0,u7_0];

tspan = (0.0,120.0)
prob = ODEProblem(Conj,u0,tspan,dt=0.001,saveat=0.001)
sol = solve(prob)

df=DataFrame(sol)
json_str = JSON.json(df)

open("./proyectos/Objeto_en_rotacion_libre_cuaterniones/simulations/datos_rotor_cuaterniones.json", "w") do io
    write(io, json_str)
end

pos=plot(sol,idxs=[1,2,3],label=[L"$x_1$" L"$x_2$" L"$x_3$"],linewidth=2)
cuat=plot(sol,idxs=[4,5,6,7],label=[L"$a_0$" L"$a_1$" L"$a_2$" L"$a_3$"],linewidth=2)
display(pos)
display(cuat)
