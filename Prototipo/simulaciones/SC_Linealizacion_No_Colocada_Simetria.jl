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
    t = 100.0
    tspan = (0.0,t)
    datos = []
    savetimes = 0.0:0.01:t;

    function pared_suave(q, dq, q_min, q_max, k, c)
        if q > q_max
            # pared superior
            return -k * (q - q_max) - c * dq
        elseif q < q_min
            # pared inferior
            return -k * (q - q_min) - c * dq
        else
            return 0.0
        end
    end

function rotor(du,u,p,t)
    
    #Satélite
    Ixs = 33.581e-3
    Iys = 33.147e-3
    Izs = 6.921e-3
    
    # Gimball #-6
    Ixg = 4.296e-6
    Iyg = 4.964e-7
    Izg = 4.767e-6
    
    
    #Prisma con agujero-6
    Ix = 3.126e-6
    Iy = 1.587e-6
    Iz = 1.587e-6
    
a1 = (-3*Ix)-3*Ixg-2*Ixs-5*Iy-2*Iyg-3*Izg-4*Izs
a2 = Ix+Ixg-Iy-Izg
a3 = Iys
a4 = (-Ix)-Ixg-2*Ixs+Iy+2*Iyg-Izg
a5 = Ix+Ixg-2*Ixs-Iy-2*Iyg+Izg+4*Izs
a6 = Ix
a7 = Iyg
a8 = Izg  

m11 = -(1/8)*(a1+4*sin(2*u[2])*cos(u[3])*sin(2*u[4])*a2+cos(2*u[4])*(a2-3*cos(2*u[2])*a2+cos(2*u[3])*((-a2)-cos(2*u[2])*a2))-2*a3+cos(2*u[3])*(2*a3+a4+cos(2*u[2])*(2*a3+a4))+cos(2*u[2])*((-2*a3)+a5)) 
m12 = (1/4)*((-cos(u[2])*sin(2*u[3])*cos(2*u[4])*a2)+2*sin(u[2])*sin(u[3])*sin(2*u[4])*a2+cos(u[2])*sin(2*u[3])*(2*a3+a4)) 
m13 = (1/8)*(4*sin(u[2])*cos(2*u[4])*a2+4*cos(u[2])*cos(u[3])*sin(2*u[4])*a2+sin(u[2])*(a1-a5)) 
m14 = -(1/8)*cos(u[2])*sin(u[3])*(a1-2*a4+a5) 
m15 = cos(u[2])*cos(u[3])*cos(u[4])*a6-sin(u[2])*sin(u[4])*a6 

m22 = -(1/8)*(a1+cos(2*u[4])*((-2*a2)+2*cos(2*u[3])*a2)-4*a3+cos(2*u[3])*((-4*a3)-2*a4)+a5) 
m23 = -(1/2)*sin(u[3])*sin(2*u[4])*a2 
m24 = -(1/8)*cos(u[3])*(a1-2*a4+a5) 
m25 = -sin(u[3])*cos(u[4])*a6 



m33 = -(1/8)*(a1+4*cos(2*u[4])*a2-a5) 
m34 = 0 
m35 = sin(u[4])*a6 

m44 = -(1/8)*(a1-2*a4+a5) 
m45 = 0 

m55 = a6 

c11 = -(1/4)*(sin(2*u[4])*(4*cos(2*u[2])*cos(u[3])*u[7]*a2-2*sin(2*u[2])*sin(u[3])*u[8]*a2)+cos(2*u[4])*(3*sin(2*u[2])*u[7]*a2+sin(2*u[2])*cos(2*u[3])*u[7]*a2+sin(2*u[3])*u[8]*(a2+cos(2*u[2])*a2))+u[9]*(4*sin(2*u[2])*cos(u[3])*cos(2*u[4])*a2+sin(2*u[4])*((-a2)+3*cos(2*u[2])*a2+cos(2*u[3])*(a2+cos(2*u[2])*a2)))+sin(2*u[2])*cos(2*u[3])*u[7]*((-2*a3)-a4)+sin(2*u[3])*u[8]*((-2*a3)+cos(2*u[2])*((-2*a3)-a4)-a4)+sin(2*u[2])*u[7]*(2*a3-a5)) 
c12 = -(1/8)*((-4*cos(u[2])*sin(u[3])*sin(2*u[4])*u[7]*a2)+cos(2*u[4])*((-2*sin(u[2])*sin(2*u[3])*u[7]*a2)+u[8]*((-4*cos(u[2])*a2)+4*cos(u[2])*cos(2*u[3])*a2))+sin(u[2])*sin(2*u[3])*u[7]*(4*a3+2*a4)+u[9]*((-8*sin(u[2])*sin(u[3])*cos(2*u[4])*a2)-4*cos(u[2])*sin(2*u[3])*sin(2*u[4])*a2+sin(u[2])*sin(u[3])*((-a1)+2*a4-a5))+u[8]*(cos(u[2])*cos(2*u[3])*((-8*a3)-4*a4)+cos(u[2])*((-a1)+a5))+u[10]*(8*sin(u[2])*cos(u[3])*cos(u[4])*a6+8*cos(u[2])*sin(u[4])*a6)) 
c13 = -(1/8)*(4*cos(u[2])*sin(u[3])*sin(2*u[4])*u[8]*a2+u[9]*((-8*cos(u[2])*cos(u[3])*cos(2*u[4])*a2)+8*sin(u[2])*sin(2*u[4])*a2+cos(u[2])*cos(u[3])*(a1-2*a4+a5))+8*u[10]*cos(u[2])*sin(u[3])*cos(u[4])*a6) 
c14 = u[10]*((-sin(u[2])*cos(u[4])*a6)-cos(u[2])*cos(u[3])*sin(u[4])*a6) 
c15 = 0 

c21 = (1/8)*(sin(2*u[4])*(4*cos(2*u[2])*cos(u[3])*u[6]*a2+8*sin(u[2])*cos(u[3])*u[8]*a2)+cos(2*u[4])*(3*sin(2*u[2])*u[6]*a2+sin(2*u[2])*cos(2*u[3])*u[6]*a2+u[8]*((-4*cos(u[2])*a2)-4*cos(u[2])*cos(2*u[3])*a2))+sin(2*u[2])*cos(2*u[3])*u[6]*((-2*a3)-a4)+u[9]*(8*sin(u[2])*sin(u[3])*cos(2*u[4])*a2+4*cos(u[2])*sin(2*u[3])*sin(2*u[4])*a2+sin(u[2])*sin(u[3])*((-a1)+2*a4-a5))+sin(2*u[2])*u[6]*(2*a3-a5)+u[8]*(cos(u[2])*cos(2*u[3])*(8*a3+4*a4)+cos(u[2])*((-a1)+a5))+u[10]*(8*sin(u[2])*cos(u[3])*cos(u[4])*a6+8*cos(u[2])*sin(u[4])*a6)) 
c22 = (1/2)*(sin(2*u[3])*cos(2*u[4])*u[8]*a2+sin(2*u[4])*u[9]*((-a2)+cos(2*u[3])*a2)+sin(2*u[3])*u[8]*((-2*a3)-a4)) 
c23 = -(1/8)*(4*cos(u[3])*sin(2*u[4])*u[8]*a2+u[9]*(8*sin(u[3])*cos(2*u[4])*a2+sin(u[3])*((-a1)+2*a4-a5))+8*u[10]*cos(u[3])*cos(u[4])*a6) 
c24 = u[10]*sin(u[3])*sin(u[4])*a6 

c25 = 0 

c31 = (1/8)*(sin(2*u[4])*((-2*sin(2*u[2])*sin(u[3])*u[6]*a2)-8*sin(u[2])*cos(u[3])*u[7]*a2)+cos(2*u[4])*(4*cos(u[2])*u[7]*a2+4*cos(u[2])*cos(2*u[3])*u[7]*a2+sin(2*u[3])*(u[6]*a2+cos(2*u[2])*u[6]*a2))+sin(2*u[3])*(u[6]*((-2*a3)-a4)+cos(2*u[2])*u[6]*((-2*a3)-a4))+cos(u[2])*cos(2*u[3])*u[7]*((-8*a3)-4*a4)+cos(u[2])*u[7]*(a1-a5)+u[9]*(8*cos(u[2])*cos(u[3])*cos(2*u[4])*a2-8*sin(u[2])*sin(2*u[4])*a2+cos(u[2])*cos(u[3])*(a1-2*a4+a5))+8*u[10]*cos(u[2])*sin(u[3])*cos(u[4])*a6) 
c32 = (1/8)*((-2*sin(2*u[3])*cos(2*u[4])*u[7]*a2)+sin(2*u[3])*u[7]*(4*a3+2*a4)+u[9]*((-8*sin(u[3])*cos(2*u[4])*a2)+sin(u[3])*((-a1)+2*a4-a5))+8*u[10]*cos(u[3])*cos(u[4])*a6) 
c33 = sin(2*u[4])*u[9]*a2 

c34 = u[10]*cos(u[4])*a6 
c35 = 0 

c41 = (1/8)*(cos(2*u[4])*(4*sin(2*u[2])*cos(u[3])*u[6]*a2-8*sin(u[2])*sin(u[3])*u[7]*a2-8*cos(u[2])*cos(u[3])*u[8]*a2)+sin(2*u[4])*((-u[6]*a2)+3*cos(2*u[2])*u[6]*a2-4*cos(u[2])*sin(2*u[3])*u[7]*a2+8*sin(u[2])*u[8]*a2+cos(2*u[3])*(u[6]*a2+cos(2*u[2])*u[6]*a2))+cos(u[2])*cos(u[3])*u[8]*((-a1)+2*a4-a5)+sin(u[2])*sin(u[3])*u[7]*(a1-2*a4+a5)+u[10]*(8*sin(u[2])*cos(u[4])*a6+8*cos(u[2])*cos(u[3])*sin(u[4])*a6)) 
c42 = -(1/8)*((-8*sin(u[3])*cos(2*u[4])*u[8]*a2)+sin(2*u[4])*((-2*u[7]*a2)+2*cos(2*u[3])*u[7]*a2)+sin(u[3])*u[8]*((-a1)+2*a4-a5)+8*u[10]*sin(u[3])*sin(u[4])*a6) 
c43 = -(1/2)*(sin(2*u[4])*u[8]*a2+2*u[10]*cos(u[4])*a6) 
c44 = 0 

c45 = 0 

c51 = (-cos(u[2])*sin(u[4])*u[7]*a6)+u[9]*((-sin(u[2])*cos(u[4])*a6)-cos(u[2])*cos(u[3])*sin(u[4])*a6)+cos(u[4])*((-sin(u[2])*cos(u[3])*u[7]*a6)-cos(u[2])*sin(u[3])*u[8]*a6) 
c52 = (-cos(u[3])*cos(u[4])*u[8]*a6)+sin(u[3])*sin(u[4])*u[9]*a6 
c53 = cos(u[4])*u[9]*a6 

c54 = 0 

c55 = 0 

C=[c11 c12 c13 c14 c15
c21 c22 c23 c24 c25
c31 c32 c33 c34 c35
c41 c42 c43 c44 c45
c51 c52 c53 c54 c55];


M11 = [m11 m12
       m12 m22]

M12 = [m13
       m23]

M13 = [m14 m15
       m24 m25]

M21 = M12';

M22 = m33;

M23 = [m34 m35]

M31 = M13';

M32 = M23';

M33 = [m44 m45
    m45 m55]

h = C*du[1:5];
h1 = h[1:2,:];
h2 = h[3:3,:];
h3 = h[4:5,:];

M22bar =M22 - M21*inv(M11)*M12;
M23bar = M23 - M21*inv(M11)*M13;
h2bar = h2 - M21*inv(M11)*h1;

M13bar = (M13 - M12*inv(M22bar)*M23bar);
h1bar = h1 - M12*inv(M22bar)*h2bar;

M33bar = M33 - M31*inv(M11)*M13bar - M32*inv(M22bar)*M23bar;
h3bar = h3 - M31*inv(M11)*h1bar - M32*inv(M22)*h2bar;

#Friccion
μ = [1E-3*du[4] #gimbal
     1E-6 *du[5]] #rotor

#Disco
Kd = [1E-1 0
      0 3E-1]; 
Kp = [1.9E-2 0 
      0 8.0E-2]; 
qd = [1.0
     1.0]; 
q = [u[1]
     u[2]];

e = qd - q
   
ep = [-du[1]
      -du[2]];
#Kp, Kd
 torque_pared = pared_suave(u[4], du[4], -0.8,0.8, 5E-1,5E-1)
vd = 2
ev =vd-u[10];

evp = -du[10];
Kd_vel = 9.0E-7;
Kp_vel = 9.0E-7;   

reg_vel =  Kd_vel*(ev) + Kp_vel*evp
torques_aux = [torque_pared;0];


v1 = Kd*(ep) + Kp*e + torques_aux

v3 = -inv(M13bar)*(M11*v1 + h1bar);
τ = M33bar*v3 + h3bar 
#Sistema v2
du[1:5] .= (u[6:10] )
du[6:7] .= -inv(M11)*(M13bar*v3 + h1bar);
du[8] = only(-inv(M22bar)*(M23bar*v3 + h2bar));

du[9:10] .= inv(M33bar)*(τ - h3bar -μ )
end

u1_0  = 0.0
du1_0 = 0.0

u2_0  = 0.0 #0.1 WF
du2_0 = 0.0

u3_0  = 0.0
du3_0 = 0.0

u4_0  = 0.0 #Gimbal interno
du4_0 = 0.0

u5_0  = 0.0 # Rotor
du5_0 = 0.0

u0=[u1_0,u2_0,u3_0,u4_0,u5_0]
du0=[du1_0,du2_0,du3_0,du4_0,du5_0]

               
prob=ODEProblem(rotor,vcat(u0,du0),tspan,dt=0.01,saveat=0.01)

#TRBDF2
global sol = solve(prob,Tsit5(),maxiters=2_000_000,tstops=savetimes)

df=DataFrame(sol)
json_str = JSON.json(df)

open("./Prototipo/simulaciones/datos_GCMRA_PRIMSA_Linealizacion_No_Colocada_Simetria.json", "w") do io
    write(io, json_str)
end  

traces = Vector{AbstractTrace}() 
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

t1e = (t1)
t2e = (t2)
t3e = (t3)

tiempo = sol.t

#Posiciones
traces1 = PlotlyJS.scatter(x=tiempo, y=t1, mode="lines",name="q₁(t)",line=attr(color="red"))
traces2 = PlotlyJS.scatter(x=tiempo, y=t2, mode="lines",name="q₂(t)",line=attr(color="green"))
traces3 = PlotlyJS.scatter(x=tiempo, y=t3, mode="lines",name="q₃(t)",line=attr(color="blue"))
traces4 = PlotlyJS.scatter(x=tiempo, y=t4, mode="lines",name="q₄(t)")
traces5 = PlotlyJS.scatter(x=tiempo, y=t5, mode="lines",name="q₅(t)")

#Velocidades
traces6 = PlotlyJS.scatter(x=tiempo, y=t1p, mode="lines",name="t1p(t)")
traces7 = PlotlyJS.scatter(x=tiempo, y=t2p, mode="lines",name="t2p(t)")
traces8 = PlotlyJS.scatter(x=tiempo, y=t3p, mode="lines",name="t3p(t)")
traces9 = PlotlyJS.scatter(x=tiempo, y=t4p, mode="lines",name="t4p(t)")
traces10 = PlotlyJS.scatter(x=tiempo, y=t5p, mode="lines",name="t5p(t)")


pos = plot([traces1,traces2,traces3,traces4,traces5], Layout(title="Posiciones, x1(0) = $u1_0, x2(0) = $u2_0, x3(0) = $u3_0",
    xaxis=attr(title="Tiempo [s]"),yaxis=attr(title="Posicion [rad]")))
vel = plot([traces6,traces7,traces8,traces9,traces10], Layout(title="Velocidades, x1p(0) = $du1_0, x2p(0) = $du2_0, x3p(0) = $du3_0"))

mix = plot([traces1,traces2,traces3,traces4,traces10], Layout(title="Posiciones, x1(0) = $u1_0, x2(0) = $u2_0, x3(0) = $u3_0"))

#display(vel)
#display(pos)
display(mix)

#savefig(pos, "./Prototipo/simulaciones/Graficas/Linealizacion_No_colocada_Simetria.svg")


