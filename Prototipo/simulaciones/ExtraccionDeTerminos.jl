using Symbolics

@variables Ix Iy Iz Ixg Iyg Izg Ixs Iys Izs
@variables u[1] u[2] u[3] u[4] u[5] u[6]  u[7] u[8]  u[9]  u[10]
@variables du[1] du[2] du[3] du[4] du[5] du[6] du[7] du[8] du[9] du[10]

c11 = [3.0E-7*u[10]*sin(2*u[2])*sin(u[3])*cos(u[4])*cos(2*u[5]),1.5E-7*u[10]*sin(2*u[3])*sin(u[4])*cos(2*u[5]),1.5E-7*u[10]*cos(2*u[2])*sin(2*u[3])*sin(u[4])*cos(2*u[5]),3.8E-8*u[10]*sin(2*u[5]),-1.1E-7*u[10]*cos(2*u[2])*sin(2*u[5]),1.1E-7*u[10]*cos(2*u[3])*sin(2*u[5]),1.1E-7*u[10]*cos(2*u[2])*cos(2*u[3])*sin(2*u[5]),3.8E-8*u[10]*cos(2*u[4])*sin(2*u[5]),-1.1E-7*u[10]*cos(2*u[2])*cos(2*u[4])*sin(2*u[5]),-3.8E-8*u[10]*cos(2*u[3])*cos(2*u[4])*sin(2*u[5]),-3.8E-8*u[10]*cos(2*u[2])*cos(2*u[3])*cos(2*u[4])*sin(2*u[5]),1.5E-7*u[10]*sin(2*u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5]),-0.026*sin(2*u[2])*u[7],-2.2E-4*sin(2*u[2])*cos(2*u[3])*u[7],2.0E-6*sin(2*u[2])*cos(2*u[4])*u[7],6.6E-7*sin(2*u[2])*cos(2*u[3])*cos(2*u[4])*u[7],2.6E-6*cos(2*u[2])*cos(u[3])*sin(2*u[4])*u[7],-1.1E-7*sin(2*u[2])*cos(2*u[5])*u[7],1.1E-7*sin(2*u[2])*cos(2*u[3])*cos(2*u[5])*u[7],-1.1E-7*sin(2*u[2])*cos(2*u[4])*cos(2*u[5])*u[7],-3.8E-8*sin(2*u[2])*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])*u[7],-1.5E-7*cos(2*u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])*u[7],3.0E-7*cos(2*u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])*u[7],-1.5E-7*sin(2*u[2])*sin(2*u[3])*sin(u[4])*sin(2*u[5])*u[7],-2.2E-4*sin(2*u[3])*u[8],-2.2E-4*cos(2*u[2])*sin(2*u[3])*u[8],6.6E-7*sin(2*u[3])*cos(2*u[4])*u[8],6.6E-7*cos(2*u[2])*sin(2*u[3])*cos(2*u[4])*u[8],-1.3E-6*sin(2*u[2])*sin(u[3])*sin(2*u[4])*u[8],1.1E-7*sin(2*u[3])*cos(2*u[5])*u[8],1.1E-7*cos(2*u[2])*sin(2*u[3])*cos(2*u[5])*u[8],-3.8E-8*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])*u[8],-3.8E-8*cos(2*u[2])*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])*u[8],7.6E-8*sin(2*u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])*u[8],1.5E-7*sin(2*u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])*u[8],1.5E-7*cos(2*u[3])*sin(u[4])*sin(2*u[5])*u[8],1.5E-7*cos(2*u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])*u[8],2.6E-6*sin(2*u[2])*cos(u[3])*cos(2*u[4])*u[9],-6.6E-7*sin(2*u[4])*u[9],2.0E-6*cos(2*u[2])*sin(2*u[4])*u[9],6.6E-7*cos(2*u[3])*sin(2*u[4])*u[9],6.6E-7*cos(2*u[2])*cos(2*u[3])*sin(2*u[4])*u[9],-1.5E-7*sin(2*u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])*u[9],3.8E-8*sin(2*u[4])*cos(2*u[5])*u[9],-1.1E-7*cos(2*u[2])*sin(2*u[4])*cos(2*u[5])*u[9],-3.8E-8*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])*u[9],-3.8E-8*cos(2*u[2])*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])*u[9],7.6E-8*sin(2*u[3])*cos(u[4])*sin(2*u[5])*u[9],7.6E-8*cos(2*u[2])*sin(2*u[3])*cos(u[4])*sin(2*u[5])*u[9],-1.5E-7*sin(2*u[2])*sin(u[3])*sin(u[4])*sin(2*u[5])*u[9]];

variables = Dict()

for (i, func) in enumerate(c11)
    variables["p_$i = println( \" p_$i = \" ,maximum( abs.(["] = func
end

for (var, func) in variables
    println("$var  $func for u in sol.u ])) )")
end
