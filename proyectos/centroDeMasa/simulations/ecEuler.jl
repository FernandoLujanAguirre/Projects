using DifferentialEquations
using SciMLBase
using OrdinaryDiffEq
using Plots
using LaTeXStrings
function ecEuler!(du,u,p,t)

    I11=1.083333333333333*10^(-4)
    I22=3.766666666666666*10^(-4)
    I33=4.816666666666666*10^(-4)

    du[1] = -u[5]*u[3]+u[6]*u[2]
    du[2] = -u[6]*u[1]+u[4]*u[3]
    du[3] = -u[4]*u[2]+u[5]*u[1]

    du[4]=-(I33-I22)*u[5]*u[6]*1/I11
    du[5]=-(I11-I33)*u[6]*u[4]*1/I22
    du[6]=-(I22-I11)*u[4]*u[5]*1/I33
   
  I=[I11 0 0;0 I22 0;0 0 I33];

  Om=[u[4];u[5];u[6]];

  M=I*Om;
  end

u1_0=0.0#x
u2_0=0.0#y
u3_0=0.0#z

u4_0=0.01#
u5_0=0.1
u6_0=0.0



#du1_0=0.0
#du2_0=0.0
#du3_0=0.0
#du4_0=0.0
#du5_0=0.0
#du6_0=0.0

u0=[u1_0,u2_0,u3_0,u4_0,u5_0,u6_0]
tspan = (0.0,100.0)
prob = ODEProblem(ecEuler!,u0,tspan)


sol = solve(prob,Tsit5())

pos=plot(sol,idxs=[1,2,3],label=[L"$x_1$" L"$x_3$" L"$x_5$"],linewidth=2)

rot=plot(sol,idxs=[4,5,6])

display(pos)
#display(sol.x_1)

display(rot)