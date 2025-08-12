using DifferentialEquations
using LinearAlgebra
using LaTeXStrings
using MathJaxRenderer
using SimulationLogs
using JSON
using DataFrames
using PlotlyJS



#PARAMETROS
    #simulacion
    t = 200.0
    tspan = (0.0,t)
    datos = []

    function soft_sat(x::AbstractVector, lim::Real, gain::Real=5.0)
        return lim .* tanh.(gain .* x ./ lim)
    end
    
    savetimes = 0.0:0.01:t;

function rotor(du,u,p,t)
    q1d, q2d = p
    #Satélite
    Ixs = 33.581e-3
    Iys = 33.147e-3
    Izs = 6.921e-3
    
    

    # Gimball #-6
    Ixg = 1.345e-6
    Iyg = 3.223e-6
    Izg = 4.560e-6
    # Rotor   
    Ix = 1.766e-5
    Iy = 4.056e-6

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
M = [M11 M12 M13
     M21 M22 M23
     M31 M32 M33]
h = C*du[1:5];
h1 = h[1:2,:];
h2 = h[3:3,:];
h3 = h[4:5,:];

#Friccion
μ = [1E-3*du[4] #gimbal
     1E-6 *du[5]] #rotor

M11i = inv(M11)

M22b = M22 - M21*M11i*M12
M22bi = inv(M22b)
M23b = M23 - M21*M11i*M13
h2b = h2 - M21*M11i*h1

M13b = M13 - M12*M22bi*M23b
h1b = h1 - M12*M22bi*h2b
M13b = M13 - M12*M22bi*M23b

M33b = M33 - M31*M11i*M13b - M32*M22bi*M23b
h3b = h3 - M31*M11i*h1b - M32*M22bi*h2b

qd = [q1d
      q2d]
Kp = diagm([1E6,1E6])
Kd = diagm([1E6,1E6])
e = qd - u[1:2]
ep = -du[1:2]
v3 = Kp*e + Kd*ep
 
τ = soft_sat(vec(M33b*v3 + h3b),0.1)
#Sistema v2
du[1:5] .= (u[6:10] )
du[6:10] .= inv(M)*( [0;0;0;τ]- C*du[1:5] )      
end

u1_0  = 0.0
du1_0 = 0.0 # 035

u2_0  = 0.0 
du2_0 = 0.0

u3_0  = 0.0
du3_0 = 0.0

u4_0  = 0.0 #Gimbal interno
du4_0 = 0.0

u5_0  = 0.0 # Rotor
du5_0 = 0.0

q1d = 10*(pi/180)
q2d = 10*(pi/180)
p = (q1d, q2d) 

u0=[u1_0,u2_0,u3_0,u4_0,u5_0]
du0=[du1_0,du2_0,du3_0,du4_0,du5_0]


prob=ODEProblem(rotor,vcat(u0,du0),tspan,dt=0.01,saveat=0.01,p)


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
# Controles

tiempo = sol.t

#Posiciones
traces1 = PlotlyJS.scatter(x=tiempo, y=t1*(180/pi), mode="lines",name=L"$\theta_1(t)$",legendgroup="Grupo A",line=attr(color="red"))
traces2 = PlotlyJS.scatter(x=tiempo, y=t2*(180/pi), mode="lines",name=L"$\theta_2(t)$",legendgroup="Grupo A",line=attr(color="green"))
traces3 = PlotlyJS.scatter(x=tiempo, y=t3*(180/pi), mode="lines",name=L"$\theta_3(t)$",legendgroup="Grupo B",line=attr(color="blue"),visible="legendonly")
traces4 = PlotlyJS.scatter(x=tiempo, y=t4*(180/pi), mode="lines",name=L"$\theta_4(t)$",legendgroup="Grupo C",line=attr(color="black"),visible="legendonly")
traces5 = PlotlyJS.scatter(x=tiempo, y=t5*(180/pi), mode="lines",name=L"$\theta_5(t)$",legendgroup="Grupo D",line=attr(color="deeppink"),visible="legendonly")
traces11 = PlotlyJS.scatter(x=tiempo, y=fill(q1d*(180/pi), length(tiempo)) , mode="lines",name=L"$\theta^d_1$",legendgroup="Grupo A",line=attr(color="red",dash="dash"))
traces12 = PlotlyJS.scatter(x=tiempo, y=fill(q2d*(180/pi), length(tiempo)) , mode="lines",name=L"$\theta^d_2$",legendgroup="Grupo A",line=attr(color="green",dash="dash"))

#Velocidades
traces6 = PlotlyJS.scatter(x=tiempo, y=t1p, mode="lines",name=L"\dot\theta_1(t)",legendgroup="Grupo E",line=attr(color="red"))
traces7 = PlotlyJS.scatter(x=tiempo, y=t2p, mode="lines",name=L"\dot\theta_2(t)",legendgroup="Grupo E",line=attr(color="green"))
traces8 = PlotlyJS.scatter(x=tiempo, y=t3p, mode="lines",name=L"\dot\theta_3(t)",legendgroup="Grupo F",line=attr(color="blue"),visible="legendonly")
traces9 = PlotlyJS.scatter(x=tiempo, y=t4p, mode="lines",name=L"\dot\theta_4(t)",legendgroup="Grupo G",line=attr(color="black"),visible="legendonly")
traces10 =PlotlyJS.scatter(x=tiempo, y=t5p*(60/(2*pi)), mode="lines",name=L"\dot\theta_5(t) (rpm)",legendgroup="Grupo H",line=attr(color="deeppink"),visible="legendonly")



pos = plot([traces1,traces2,traces3,traces4,traces5,traces11,traces12], 
Layout(title= "\$\\text{Posiciones: }\\theta_1(0) = $(u1_0)\\text{, } \\theta_2(0) = $(u2_0)\\text{, } \\theta_3(0) = $(u3_0)\$",
xaxis=attr(title="Tiempo [s]",gridcolor="black"),yaxis=attr(title="Posicion [rad]",gridcolor="black")))

vel = plot([traces6,traces7,traces8,traces9,traces10], 
Layout(title="\$\\text{Velocidades: }\\dot\\theta_1(0) = $(du1_0)\\text{, } \\dot\\theta_2(0) = $(du2_0)\\text{, } \\dot\\theta_3(0) = $(du3_0)\$",
xaxis=attr(title="Tiempo [s]",gridcolor="black"),yaxis=attr(title="Posicion [rad/s]",gridcolor="black")))
subplots= [pos; vel];

if t<1000
    width = 1000
elseif t>= 2000
    width =1900
else
    width=t

end

relayout!(subplots, 
          template="simple_white",
          title_text="Sat + Giro",
          width = width,
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


savefig(subplots, "./Prototipo/simulaciones/Graficas/Linealizacion_No_colocada_Simetria.html");
run(`notify-send "✅ Simulación Julia" "Tu simulación ha terminado."`)

#run(`xdg-open ./Prototipo/simulaciones/Graficas/Linealizacion_No_colocada_Simetria.html`)

#savefig(pos, "./Prototipo/simulaciones/Graficas/Linealizacion_No_colocada_Simetria.svg")