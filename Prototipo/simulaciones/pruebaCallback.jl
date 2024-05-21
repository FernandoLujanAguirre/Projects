using DifferentialEquations
using LinearAlgebra
using Plots
using LaTeXStrings
using SciMLBase
using SimulationLogs
using JSON
using DataFrames

# parameters

qd=0.0

function rotor(du,u,p,t)
qd = p
M4 = 0.1
l4 = 0.2

Ix=6.666666666666668*10^(-4)

m11=-(1/8)*(M4*((-6)+2*cos(2*u[2])+((-2)-2*cos(2*u[2]))*cos(2*u[3]))+M4*l4*(((-12)+4*cos(2*u[2])+((-4)-4*cos(2*u[2]))*cos(2*u[3]))*cos(u[4])+8*sin(2*u[2])*sin(u[3])*sin(u[4]))+M4*l4^2*((-5)-cos(2*u[2])+((-1)-cos(2*u[2]))*cos(2*u[3])+((-1)+3*cos(2*u[2])+((-1)-cos(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+4*sin(2*u[2])*sin(u[3])*sin(2*u[4]))-8*Ix)
m12=-(1/4)*(2*M4*cos(u[2])*sin(2*u[3])+M4*l4*(4*cos(u[2])*sin(2*u[3])*cos(u[4])+4*sin(u[2])*cos(u[3])*sin(u[4]))+M4*l4^2*(cos(u[2])*sin(2*u[3])+cos(u[2])*sin(2*u[3])*cos(2*u[4])+2*sin(u[2])*cos(u[3])*sin(2*u[4])))
m13=(1/2)*((-2*M4*sin(u[2]))+M4*l4*((-4*sin(u[2])*cos(u[4]))+2*cos(u[2])*sin(u[3])*sin(u[4]))+M4*l4^2*((-sin(u[2]))-sin(u[2])*cos(2*u[4])+cos(u[2])*sin(u[3])*sin(2*u[4]))-2*sin(u[2])*Ix)
m14=M4*l4^2*cos(u[2])*cos(u[3])+M4*l4*cos(u[2])*cos(u[3])*cos(u[4])
m21=-(1/4)*(2*M4*cos(u[2])*sin(2*u[3])+M4*l4*(4*cos(u[2])*sin(2*u[3])*cos(u[4])+4*sin(u[2])*cos(u[3])*sin(u[4]))+M4*l4^2*(cos(u[2])*sin(2*u[3])+cos(u[2])*sin(2*u[3])*cos(2*u[4])+2*sin(u[2])*cos(u[3])*sin(2*u[4])))
m22=-(1/4)*(M4*((-2)+2*cos(2*u[3]))+M4*l4*((-4)+4*cos(2*u[3]))*cos(u[4])+M4*l4^2*((-3)+cos(2*u[3])+(1+cos(2*u[3]))*cos(2*u[4]))-4*Ix)
m23=(1/2)*(2*M4*l4*cos(u[3])*sin(u[4])+M4*l4^2*cos(u[3])*sin(2*u[4]))
m24=(-M4*l4^2*sin(u[3]))-M4*l4*sin(u[3])*cos(u[4])
m31=(1/2)*((-2*M4*sin(u[2]))+M4*l4*((-4*sin(u[2])*cos(u[4]))+2*cos(u[2])*sin(u[3])*sin(u[4]))+M4*l4^2*((-sin(u[2]))-sin(u[2])*cos(2*u[4])+cos(u[2])*sin(u[3])*sin(2*u[4]))-2*sin(u[2])*Ix)
m32=(1/2)*(2*M4*l4*cos(u[3])*sin(u[4])+M4*l4^2*cos(u[3])*sin(2*u[4]))
m33=(1/2)*(2*M4+4*M4*l4*cos(u[4])+M4*l4^2*(1+cos(2*u[4]))+2*Ix)
m34=0

m41=M4*l4^2*cos(u[2])*cos(u[3])+M4*l4*cos(u[2])*cos(u[3])*cos(u[4])
m42=(-M4*l4^2*sin(u[3]))-M4*l4*sin(u[3])*cos(u[4])
m43=0

m44=M4*l4^2

c11=-(1/4)*du[2]*(M4*sin(2*u[2])*((-2)+2*cos(2*u[3]))+M4*l4*(sin(2*u[2])*((-4*cos(u[4]))+4*cos(2*u[3])*cos(u[4]))+8*cos(2*u[2])*sin(u[3])*sin(u[4]))+M4*l4^2*(sin(2*u[2])*(1-3*cos(2*u[4])+cos(2*u[3])*(1+cos(2*u[4])))+4*cos(2*u[2])*sin(u[3])*sin(2*u[4])))
c12=(1/4)*(du[2]*(2*M4*sin(u[2])*sin(2*u[3])+M4*l4*(4*sin(u[2])*sin(2*u[3])*cos(u[4])-4*cos(u[2])*cos(u[3])*sin(u[4]))+M4*l4^2*(sin(u[2])*(sin(2*u[3])+sin(2*u[3])*cos(2*u[4]))-2*cos(u[2])*cos(u[3])*sin(2*u[4])))+du[4]*(M4*l4*((-8*sin(u[2])*cos(u[3])*cos(u[4]))+4*cos(u[2])*sin(2*u[3])*sin(u[4]))+M4*l4^2*(sin(u[2])*cos(u[3])*((-4)-4*cos(2*u[4]))+2*cos(u[2])*sin(2*u[3])*sin(2*u[4])))+du[3]*(M4*cos(u[2])*((-4)-4*cos(2*u[3]))+M4*l4*cos(u[2])*((-8*cos(u[4]))-8*cos(2*u[3])*cos(u[4]))+M4*l4^2*cos(u[2])*((-2)+cos(2*u[3])*((-2)-2*cos(2*u[4]))-2*cos(2*u[4]))-4*cos(u[2])*Ix))
c13=(1/4)*(du[3]*(4*M4*l4*cos(u[2])*cos(u[3])*sin(u[4])+2*M4*l4^2*cos(u[2])*cos(u[3])*sin(2*u[4]))+du[4]*(8*M4*l4*sin(u[2])*sin(u[4])+M4*l4^2*(cos(u[2])*sin(u[3])*((-4)+4*cos(2*u[4]))+4*sin(u[2])*sin(2*u[4])))+du[1]*(M4*((-2*sin(2*u[3]))-2*cos(2*u[2])*sin(2*u[3]))+M4*l4*((-4*sin(2*u[3])*cos(u[4]))-4*cos(2*u[2])*sin(2*u[3])*cos(u[4])-4*sin(2*u[2])*cos(u[3])*sin(u[4]))+M4*l4^2*((-sin(2*u[3]))-sin(2*u[3])*cos(2*u[4])+cos(2*u[2])*((-sin(2*u[3]))-sin(2*u[3])*cos(2*u[4]))-2*sin(2*u[2])*cos(u[3])*sin(2*u[4]))))
c14=-(1/4)*(4*M4*l4*du[4]*cos(u[2])*cos(u[3])*sin(u[4])+du[1]*(M4*l4*(4*sin(2*u[2])*sin(u[3])*cos(u[4])+6*sin(u[4])+2*cos(2*u[3])*sin(u[4])+cos(2*u[2])*((-2*sin(u[4]))+2*cos(2*u[3])*sin(u[4])))+M4*l4^2*(4*sin(2*u[2])*sin(u[3])*cos(2*u[4])+sin(2*u[4])+cos(2*u[3])*sin(2*u[4])+cos(2*u[2])*((-3*sin(2*u[4]))+cos(2*u[3])*sin(2*u[4])))))
c21=(1/8)*du[1]*(M4*sin(2*u[2])*((-2)+2*cos(2*u[3]))+M4*l4*(sin(2*u[2])*((-4*cos(u[4]))+4*cos(2*u[3])*cos(u[4]))+8*cos(2*u[2])*sin(u[3])*sin(u[4]))+M4*l4^2*(sin(2*u[2])*(1-3*cos(2*u[4])+cos(2*u[3])*(1+cos(2*u[4])))+4*cos(2*u[2])*sin(u[3])*sin(2*u[4])))
c22=(1/2)*(du[3]*(2*M4*sin(2*u[3])+4*M4*l4*sin(2*u[3])*cos(u[4])+M4*l4^2*(sin(2*u[3])+sin(2*u[3])*cos(2*u[4])))+du[4]*(M4*l4*((-2*sin(u[4]))+2*cos(2*u[3])*sin(u[4]))+M4*l4^2*(sin(2*u[4])+cos(2*u[3])*sin(2*u[4]))))
c23=(1/2)*(M4*l4^2*du[4]*cos(u[3])*((-2)+2*cos(2*u[4]))+du[3]*((-2*M4*l4*sin(u[3])*sin(u[4]))-M4*l4^2*sin(u[3])*sin(2*u[4]))+du[1]*(M4*cos(u[2])*(2-2*cos(2*u[3]))+M4*l4*(cos(u[2])*(4*cos(u[4])-4*cos(2*u[3])*cos(u[4]))+4*sin(u[2])*sin(u[3])*sin(u[4]))+M4*l4^2*(cos(u[2])*(1+cos(2*u[3])*((-1)-cos(2*u[4]))+cos(2*u[4]))+2*sin(u[2])*sin(u[3])*sin(2*u[4]))+2*cos(u[2])*Ix))
c24=(1/2)*(2*M4*l4*du[4]*sin(u[3])*sin(u[4])+du[1]*(2*M4*l4*cos(u[2])*sin(2*u[3])*sin(u[4])+M4*l4^2*(sin(u[2])*cos(u[3])*(2-2*cos(2*u[4]))+cos(u[2])*sin(2*u[3])*sin(2*u[4]))))
c31=(1/8)*(du[1]*(M4*(2*sin(2*u[3])+2*cos(2*u[2])*sin(2*u[3]))+M4*l4*(4*sin(2*u[3])*cos(u[4])+4*cos(2*u[2])*sin(2*u[3])*cos(u[4])+4*sin(2*u[2])*cos(u[3])*sin(u[4]))+M4*l4^2*(sin(2*u[3])+sin(2*u[3])*cos(2*u[4])+cos(2*u[2])*(sin(2*u[3])+sin(2*u[3])*cos(2*u[4]))+2*sin(2*u[2])*cos(u[3])*sin(2*u[4])))+du[2]*(M4*cos(u[2])*((-8)+8*cos(2*u[3]))+M4*l4*(cos(u[2])*((-16*cos(u[4]))+16*cos(2*u[3])*cos(u[4]))-16*sin(u[2])*sin(u[3])*sin(u[4]))+M4*l4^2*(cos(u[2])*((-4)-4*cos(2*u[4])+cos(2*u[3])*(4+4*cos(2*u[4])))-8*sin(u[2])*sin(u[3])*sin(2*u[4]))-8*cos(u[2])*Ix))
c32=(1/4)*(du[4]*(8*M4*l4*cos(u[3])*cos(u[4])+M4*l4^2*cos(u[3])*(4+4*cos(2*u[4])))+du[2]*((-2*M4*sin(2*u[3]))-4*M4*l4*sin(2*u[3])*cos(u[4])+M4*l4^2*((-sin(2*u[3]))-sin(2*u[3])*cos(2*u[4]))))
c33=du[4]*((-2*M4*l4*sin(u[4]))-M4*l4^2*sin(2*u[4]))
c34=du[1]*(M4*l4*(2*cos(u[2])*sin(u[3])*cos(u[4])+2*sin(u[2])*sin(u[4]))+M4*l4^2*(cos(u[2])*sin(u[3])*(1+cos(2*u[4]))+sin(u[2])*sin(2*u[4])))
c41=-(1/8)*(du[2]*(8*M4*l4*cos(u[2])*sin(2*u[3])*sin(u[4])+M4*l4^2*(sin(u[2])*cos(u[3])*(8-8*cos(2*u[4]))+4*cos(u[2])*sin(2*u[3])*sin(2*u[4])))+du[1]*(M4*l4*((-4*sin(2*u[2])*sin(u[3])*cos(u[4]))-6*sin(u[4])-2*cos(2*u[3])*sin(u[4])+cos(2*u[2])*(2*sin(u[4])-2*cos(2*u[3])*sin(u[4])))+M4*l4^2*((-4*sin(2*u[2])*sin(u[3])*cos(2*u[4]))-sin(2*u[4])-cos(2*u[3])*sin(2*u[4])+cos(2*u[2])*(3*sin(2*u[4])-cos(2*u[3])*sin(2*u[4])))))
c42=-(1/4)*(du[3]*(8*M4*l4*cos(u[3])*cos(u[4])+M4*l4^2*cos(u[3])*(4+4*cos(2*u[4])))+du[2]*(M4*l4*((-2*sin(u[4]))+2*cos(2*u[3])*sin(u[4]))+M4*l4^2*(sin(2*u[4])+cos(2*u[3])*sin(2*u[4]))))
c43=(1/2)*(du[3]*(2*M4*l4*sin(u[4])+M4*l4^2*sin(2*u[4]))+du[1]*(M4*l4*((-4*cos(u[2])*sin(u[3])*cos(u[4]))-4*sin(u[2])*sin(u[4]))+M4*l4^2*(cos(u[2])*sin(u[3])*((-2)-2*cos(2*u[4]))-2*sin(u[2])*sin(2*u[4]))))
c44=0

M=[m11 m12 m13 m14;m21 m22 m23 m24;m31 m32 m33 m34;m41 m42 m43 m44]
C=[c11 c12 c13 c14;c21 c22 c23 c24;c31 c32 c33 c34;c41 c42 c43 c44]

Kp = 1
Kv = 1

qt = qd-u[4]

u=Kp*qt-Kv*du[4]


tau = [0;0;0;u]

ddu = inv(M)*(-C*du+tau)



end

u1_0  = 0.0
du1_0 = 0.0

u2_0  = 0.0
du2_0 = 10.0

u3_0  = 0.0
du3_0 = 0.0


u4_0  = 0.0
du4_0 = 0.0

u0=[u1_0,u2_0,u3_0,u4_0]
du0=[du1_0,du2_0,du3_0,du4_0]

tspan = (0.0,100.0)
p = qd
prob=SecondOrderODEProblem(rotor,du0,u0,tspan,dt=0.001,saveat=0.001,p)


# Events
function condition(y, t, integrator)
    if t < 50.03 && t > 49.96
        qd = integrator.p
        println("t = $t, \t a = $qd")
    end
    return t < 50
end

function affect!(integrator)
    integrator.p = 2.0
end
cb = ContinuousCallback(condition, affect!)


@time sol = solve(prob, Rodas4(), callback = cb)

#df=DataFrame(sol)
#json_str = JSON.json(df)

#open("./Template/simulaciones/datos_GCMRA_esfera.json", "w") do io
#write(io, json_str)
#end


pos=plot(sol,idxs=[5,6,7,8],label=[L"$x_1$" L"$x_2$" L"$x_3$" L"$x_4$"],linewidth=2) 

vel=plot(sol,idxs=[1,2,3,4],label=[L"$x_5$" L"$x_6$" L"$x_7$" L"$x_8$"],linewidth=2)

display(pos)
display(vel)