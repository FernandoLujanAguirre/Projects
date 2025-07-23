using Symbolics
using ForwardDiff
using Latexify      

function mycoeffs(f,var,order)
   if order == 0
       return substitute(f,Dict(var=>0))
   end
   D=Differential(var^order)
   newf=expand_derivatives(D(f))
   return substitute(newf,Dict(var=>0))
end

@variables Ix Iy Iz Ig Izg Is t τ₄ τ₅ v₁ v₂
@variables u[1] u[2] u[3] u[4] u[5]
@variables du[1] du[2] du[3] du[4] du[5] 

m11 = -(1/16)*((-6*Ix)-6*Ixg-4*Ixs-5*Iy-4*Iyg-5*Iz-6*Izg-8*Izs+(2*Ix+2*Ixg-4*Ixs-Iy-4*Iyg-Iz+2*Izg+8*Izs)*cos(2*u[2])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*cos(2*u[2]))*cos(2*u[3])+(2*Ix+2*Ixg-Iy-Iz-2*Izg+((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*cos(2*u[2])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+(8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*sin(2*u[2])*cos(u[3])*sin(2*u[4])+(Iy-Iz+((-3*Iy)+3*Iz)*cos(2*u[2])+(3*Iy-3*Iz+(3*Iy-3*Iz)*cos(2*u[2]))*cos(2*u[3])+(Iy-Iz+((-3*Iy)+3*Iz)*cos(2*u[2])+((-Iy)+Iz+((-Iy)+Iz)*cos(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+(4*Iy-4*Iz)*sin(2*u[2])*cos(u[3])*sin(2*u[4]))*cos(2*u[5])+(((-8*Iy)+8*Iz)*sin(2*u[2])*sin(u[3])*cos(u[4])+((-4*Iy)+4*Iz+((-4*Iy)+4*Iz)*cos(2*u[2]))*sin(2*u[3])*sin(u[4]))*sin(2*u[5])+((-4)-4*cos(2*u[2])+(4+4*cos(2*u[2]))*cos(2*u[3]))*Iys) 
m12 = (1/8)*(((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*cos(u[2])*sin(2*u[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(u[2])*sin(2*u[3])*cos(2*u[4])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*sin(u[2])*sin(u[3])*sin(2*u[4])+((3*Iy-3*Iz)*cos(u[2])*sin(2*u[3])+((-Iy)+Iz)*cos(u[2])*sin(2*u[3])*cos(2*u[4])+(2*Iy-2*Iz)*sin(u[2])*sin(u[3])*sin(2*u[4]))*cos(2*u[5])+((4*Iy-4*Iz)*sin(u[2])*cos(u[3])*cos(u[4])+(4*Iy-4*Iz)*cos(u[2])*cos(2*u[3])*sin(u[4]))*sin(2*u[5])+4*cos(u[2])*sin(2*u[3])*Iys) 
m13 = (1/4)*(((-2*Ix)-2*Ixg-Iy-Iz-2*Izg-4*Izs)*sin(u[2])+(2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(u[2])*cos(2*u[4])+(2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(u[2])*cos(u[3])*sin(2*u[4])+((Iy-Iz)*sin(u[2])+(Iy-Iz)*sin(u[2])*cos(2*u[4])+(Iy-Iz)*cos(u[2])*cos(u[3])*sin(2*u[4]))*cos(2*u[5])+((-2*Iy)+2*Iz)*cos(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])) 
m14 = -(1/2)*(((-Iy)-2*Iyg-Iz)*cos(u[2])*sin(u[3])+((-Iy)+Iz)*cos(u[2])*sin(u[3])*cos(2*u[5])+(((-Iy)+Iz)*sin(u[2])*cos(u[4])+((-Iy)+Iz)*cos(u[2])*cos(u[3])*sin(u[4]))*sin(2*u[5])) 
m15 = Ix*cos(u[2])*cos(u[3])*cos(u[4])-Ix*sin(u[2])*sin(u[4]) 
m21 = (1/8)*(((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*cos(u[2])*sin(2*u[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(u[2])*sin(2*u[3])*cos(2*u[4])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*sin(u[2])*sin(u[3])*sin(2*u[4])+((3*Iy-3*Iz)*cos(u[2])*sin(2*u[3])+((-Iy)+Iz)*cos(u[2])*sin(2*u[3])*cos(2*u[4])+(2*Iy-2*Iz)*sin(u[2])*sin(u[3])*sin(2*u[4]))*cos(2*u[5])+((4*Iy-4*Iz)*sin(u[2])*cos(u[3])*cos(u[4])+(4*Iy-4*Iz)*cos(u[2])*cos(2*u[3])*sin(u[4]))*sin(2*u[5])+4*cos(u[2])*sin(2*u[3])*Iys) 
m22 = (1/8)*(2*Ix+2*Ixg+4*Ixs+3*Iy+4*Iyg+3*Iz+2*Izg+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*cos(2*u[3])+(2*Ix+2*Ixg-Iy-Iz-2*Izg+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*u[3]))*cos(2*u[4])+(Iy-Iz+(3*Iy-3*Iz)*cos(2*u[3])+(Iy-Iz+((-Iy)+Iz)*cos(2*u[3]))*cos(2*u[4]))*cos(2*u[5])+((-4*Iy)+4*Iz)*sin(2*u[3])*sin(u[4])*sin(2*u[5])+(4+4*cos(2*u[3]))*Iys) 
m23 = (1/4)*(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(u[3])*sin(2*u[4])+((-Iy)+Iz)*sin(u[3])*sin(2*u[4])*cos(2*u[5])+((-2*Iy)+2*Iz)*cos(u[3])*cos(u[4])*sin(2*u[5])) 
m24 = (1/2)*((Iy+2*Iyg+Iz)*cos(u[3])+(Iy-Iz)*cos(u[3])*cos(2*u[5])+((-Iy)+Iz)*sin(u[3])*sin(u[4])*sin(2*u[5])) 
m25 = -Ix*sin(u[3])*cos(u[4]) 

m31 = (1/4)*(((-2*Ix)-2*Ixg-Iy-Iz-2*Izg-4*Izs)*sin(u[2])+(2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(u[2])*cos(2*u[4])+(2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(u[2])*cos(u[3])*sin(2*u[4])+((Iy-Iz)*sin(u[2])+(Iy-Iz)*sin(u[2])*cos(2*u[4])+(Iy-Iz)*cos(u[2])*cos(u[3])*sin(2*u[4]))*cos(2*u[5])+((-2*Iy)+2*Iz)*cos(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])) 
m32 = (1/4)*(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(u[3])*sin(2*u[4])+((-Iy)+Iz)*sin(u[3])*sin(2*u[4])*cos(2*u[5])+((-2*Iy)+2*Iz)*cos(u[3])*cos(u[4])*sin(2*u[5])) 
m33 = (1/4)*(2*Ix+2*Ixg+Iy+Iz+2*Izg+4*Izs+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*u[4])+((-Iy)+Iz+((-Iy)+Iz)*cos(2*u[4]))*cos(2*u[5])) 
m34 = (1/2)*((-Iy)+Iz)*cos(u[4])*sin(2*u[5]) 
m35 = Ix*sin(u[4]) 

m41 = -(1/2)*(((-Iy)-2*Iyg-Iz)*cos(u[2])*sin(u[3])+((-Iy)+Iz)*cos(u[2])*sin(u[3])*cos(2*u[5])+(((-Iy)+Iz)*sin(u[2])*cos(u[4])+((-Iy)+Iz)*cos(u[2])*cos(u[3])*sin(u[4]))*sin(2*u[5])) 
m42 = (1/2)*((Iy+2*Iyg+Iz)*cos(u[3])+(Iy-Iz)*cos(u[3])*cos(2*u[5])+((-Iy)+Iz)*sin(u[3])*sin(u[4])*sin(2*u[5])) 
m43 = (1/2)*((-Iy)+Iz)*cos(u[4])*sin(2*u[5]) 
m44 = -(1/2)*((-Iy)-2*Iyg-Iz+((-Iy)+Iz)*cos(2*u[5])) 
m45 = 0 

m51 = Ix*cos(u[2])*cos(u[3])*cos(u[4])-Ix*sin(u[2])*sin(u[4]) 
m52 = -Ix*sin(u[3])*cos(u[4]) 

m53 = Ix*sin(u[4]) 

m54 = 0 

m55 = Ix 

c11 = (1/8)*((2*Ix+2*Ixg-4*Ixs-Iy-4*Iyg-Iz+2*Izg+8*Izs)*du[2]*sin(2*u[2])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[2]*sin(2*u[2])*cos(2*u[3])+(((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[3]+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[3]*cos(2*u[2]))*sin(2*u[3])+(((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*du[2]*sin(2*u[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[4]*sin(2*u[2])*cos(u[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[2]*sin(2*u[2])*cos(2*u[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[3]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[3]*cos(2*u[2]))*sin(2*u[3]))*cos(2*u[4])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*du[4]+((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*du[4]*cos(2*u[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[2]*cos(2*u[2])*cos(u[3])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*du[3]*sin(2*u[2])*sin(u[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[4]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[4]*cos(2*u[2]))*cos(2*u[3]))*sin(2*u[4])+(((-3*Iy)+3*Iz)*du[2]*sin(2*u[2])+(3*Iy-3*Iz)*du[2]*sin(2*u[2])*cos(2*u[3])+((3*Iy-3*Iz)*du[3]+(3*Iy-3*Iz)*du[3]*cos(2*u[2]))*sin(2*u[3])+(8*Iy-8*Iz)*du[5]*sin(2*u[2])*sin(u[3])*cos(u[4])+((4*Iy-4*Iz)*du[5]+(4*Iy-4*Iz)*du[5]*cos(2*u[2]))*sin(2*u[3])*sin(u[4])+(((-3*Iy)+3*Iz)*du[2]*sin(2*u[2])+((-4*Iy)+4*Iz)*du[4]*sin(2*u[2])*cos(u[3])+((-Iy)+Iz)*du[2]*sin(2*u[2])*cos(2*u[3])+(((-Iy)+Iz)*du[3]+((-Iy)+Iz)*du[3]*cos(2*u[2]))*sin(2*u[3]))*cos(2*u[4])+((Iy-Iz)*du[4]+((-3*Iy)+3*Iz)*du[4]*cos(2*u[2])+((-4*Iy)+4*Iz)*du[2]*cos(2*u[2])*cos(u[3])+(2*Iy-2*Iz)*du[3]*sin(2*u[2])*sin(u[3])+(((-Iy)+Iz)*du[4]+((-Iy)+Iz)*du[4]*cos(2*u[2]))*cos(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+((Iy-Iz)*du[5]+((-3*Iy)+3*Iz)*du[5]*cos(2*u[2])+((3*Iy-3*Iz)*du[5]+(3*Iy-3*Iz)*du[5]*cos(2*u[2]))*cos(2*u[3])+((4*Iy-4*Iz)*du[3]*sin(2*u[2])*cos(u[3])+(8*Iy-8*Iz)*du[2]*cos(2*u[2])*sin(u[3])+((2*Iy-2*Iz)*du[4]+(2*Iy-2*Iz)*du[4]*cos(2*u[2]))*sin(2*u[3]))*cos(u[4])+(((-4*Iy)+4*Iz)*du[4]*sin(2*u[2])*sin(u[3])+((4*Iy-4*Iz)*du[3]+(4*Iy-4*Iz)*du[3]*cos(2*u[2]))*cos(2*u[3])+((-4*Iy)+4*Iz)*du[2]*sin(2*u[2])*sin(2*u[3]))*sin(u[4])+((Iy-Iz)*du[5]+((-3*Iy)+3*Iz)*du[5]*cos(2*u[2])+(((-Iy)+Iz)*du[5]+((-Iy)+Iz)*du[5]*cos(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+(4*Iy-4*Iz)*du[5]*sin(2*u[2])*cos(u[3])*sin(2*u[4]))*sin(2*u[5])+((-4*du[2]*sin(2*u[2]))+4*du[2]*sin(2*u[2])*cos(2*u[3])+(4*du[3]+4*du[3]*cos(2*u[2]))*sin(2*u[3]))*Iys) 
c12 = -(1/8)*((4*Ix+4*Ixg+2*Iy+2*Iz+4*Izg+8*Izs)*du[3]*cos(u[2])+(4*Iy+8*Iyg+4*Iz)*du[4]*sin(u[2])*sin(u[3])+(4*Ix+4*Ixg+8*Ixs-2*Iy-8*Iyg-2*Iz+4*Izg)*du[3]*cos(u[2])*cos(2*u[3])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[2]*sin(u[2])*sin(2*u[3])+8*Ix*du[5]*sin(u[2])*cos(u[3])*cos(u[4])+8*Ix*du[5]*cos(u[2])*sin(u[4])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*du[3]*cos(u[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[4]*sin(u[2])*sin(u[3])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*du[3]*cos(u[2])*cos(2*u[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[2]*sin(u[2])*sin(2*u[3]))*cos(2*u[4])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*du[2]*cos(u[2])*sin(u[3])+((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*du[4]*cos(u[2])*sin(2*u[3]))*sin(2*u[4])+(((-2*Iy)+2*Iz)*du[3]*cos(u[2])+(4*Iy-4*Iz)*du[4]*sin(u[2])*sin(u[3])+((-6*Iy)+6*Iz)*du[3]*cos(u[2])*cos(2*u[3])+(3*Iy-3*Iz)*du[2]*sin(u[2])*sin(2*u[3])+((-8*Iy)+8*Iz)*du[5]*sin(u[2])*cos(u[3])*cos(u[4])+((-8*Iy)+8*Iz)*du[5]*cos(u[2])*cos(2*u[3])*sin(u[4])+(((-2*Iy)+2*Iz)*du[3]*cos(u[2])+((-4*Iy)+4*Iz)*du[4]*sin(u[2])*sin(u[3])+(2*Iy-2*Iz)*du[3]*cos(u[2])*cos(2*u[3])+((-Iy)+Iz)*du[2]*sin(u[2])*sin(2*u[3]))*cos(2*u[4])+(((-2*Iy)+2*Iz)*du[2]*cos(u[2])*sin(u[3])+((-2*Iy)+2*Iz)*du[4]*cos(u[2])*sin(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+((6*Iy-6*Iz)*du[5]*cos(u[2])*sin(2*u[3])+(((-4*Iy)+4*Iz)*du[4]*cos(u[2])+((-4*Iy)+4*Iz)*du[2]*cos(u[2])*cos(u[3])+((-4*Iy)+4*Iz)*du[4]*cos(u[2])*cos(2*u[3]))*cos(u[4])+((8*Iy-8*Iz)*du[4]*sin(u[2])*cos(u[3])+(4*Iy-4*Iz)*du[2]*sin(u[2])*cos(2*u[3])+(8*Iy-8*Iz)*du[3]*cos(u[2])*sin(2*u[3]))*sin(u[4])+((-2*Iy)+2*Iz)*du[5]*cos(u[2])*sin(2*u[3])*cos(2*u[4])+(4*Iy-4*Iz)*du[5]*sin(u[2])*sin(u[3])*sin(2*u[4]))*sin(2*u[5])+((-8*du[3]*cos(u[2])*cos(2*u[3]))+4*du[2]*sin(u[2])*sin(2*u[3]))*Iys) 
c13 = (1/4)*((2*Iy+4*Iyg+2*Iz)*du[4]*cos(u[2])*cos(u[3])-4*Ix*du[5]*cos(u[2])*sin(u[3])*cos(u[4])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*du[4]*cos(u[2])*cos(u[3])*cos(2*u[4])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*du[4]*sin(u[2])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[3]*cos(u[2])*sin(u[3]))*sin(2*u[4])+((2*Iy-2*Iz)*du[4]*cos(u[2])*cos(u[3])+((-4*Iy)+4*Iz)*du[5]*cos(u[2])*sin(u[3])*cos(u[4])+(2*Iy-2*Iz)*du[4]*cos(u[2])*cos(u[3])*cos(2*u[4])+(((-2*Iy)+2*Iz)*du[4]*sin(u[2])+((-Iy)+Iz)*du[3]*cos(u[2])*sin(u[3]))*sin(2*u[4]))*cos(2*u[5])+(((-2*Iy)+2*Iz)*du[5]*sin(u[2])+((-2*Iy)+2*Iz)*du[3]*cos(u[2])*cos(u[3])*cos(u[4])+((-2*Iy)+2*Iz)*du[5]*sin(u[2])*cos(2*u[4])+((-2*Iy)+2*Iz)*du[5]*cos(u[2])*cos(u[3])*sin(2*u[4]))*sin(2*u[5])) 
c14 = (1/2)*((-2*Ix*du[5]*sin(u[2])*cos(u[4]))-2*Ix*du[5]*cos(u[2])*cos(u[3])*sin(u[4])+((2*Iy-2*Iz)*du[5]*sin(u[2])*cos(u[4])+(2*Iy-2*Iz)*du[5]*cos(u[2])*cos(u[3])*sin(u[4]))*cos(2*u[5])+(((-2*Iy)+2*Iz)*du[5]*cos(u[2])*sin(u[3])+(Iy-Iz)*du[4]*cos(u[2])*cos(u[3])*cos(u[4])+((-Iy)+Iz)*du[4]*sin(u[2])*sin(u[4]))*sin(2*u[5])) 
c15 = 0 

c21 = -(1/16)*(((-8*Ix)-8*Ixg-4*Iy-4*Iz-8*Izg-16*Izs)*du[3]*cos(u[2])+(2*Ix+2*Ixg-4*Ixs-Iy-4*Iyg-Iz+2*Izg+8*Izs)*du[1]*sin(2*u[2])+((-8*Iy)-16*Iyg-8*Iz)*du[4]*sin(u[2])*sin(u[3])+((8*Ix+8*Ixg+16*Ixs-4*Iy-16*Iyg-4*Iz+8*Izg)*du[3]*cos(u[2])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[1]*sin(2*u[2]))*cos(2*u[3])-16*Ix*du[5]*sin(u[2])*cos(u[3])*cos(u[4])-16*Ix*du[5]*cos(u[2])*sin(u[4])+((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*du[3]*cos(u[2])+((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*du[1]*sin(2*u[2])+((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*du[4]*sin(u[2])*sin(u[3])+((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*du[3]*cos(u[2])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[1]*sin(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+((((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*du[3]*sin(u[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[1]*cos(2*u[2]))*cos(u[3])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[4]*cos(u[2])*sin(2*u[3]))*sin(2*u[4])+((4*Iy-4*Iz)*du[3]*cos(u[2])+((-3*Iy)+3*Iz)*du[1]*sin(2*u[2])+((-8*Iy)+8*Iz)*du[4]*sin(u[2])*sin(u[3])+(((-12*Iy)+12*Iz)*du[3]*cos(u[2])+(3*Iy-3*Iz)*du[1]*sin(2*u[2]))*cos(2*u[3])+((-16*Iy)+16*Iz)*du[5]*sin(u[2])*cos(u[3])*cos(u[4])+((-16*Iy)+16*Iz)*du[5]*cos(u[2])*cos(2*u[3])*sin(u[4])+((4*Iy-4*Iz)*du[3]*cos(u[2])+((-3*Iy)+3*Iz)*du[1]*sin(2*u[2])+((-8*Iy)+8*Iz)*du[4]*sin(u[2])*sin(u[3])+((4*Iy-4*Iz)*du[3]*cos(u[2])+((-Iy)+Iz)*du[1]*sin(2*u[2]))*cos(2*u[3]))*cos(2*u[4])+((((-8*Iy)+8*Iz)*du[3]*sin(u[2])+((-4*Iy)+4*Iz)*du[1]*cos(2*u[2]))*cos(u[3])+((-4*Iy)+4*Iz)*du[4]*cos(u[2])*sin(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+((12*Iy-12*Iz)*du[5]*cos(u[2])*sin(2*u[3])+((8*Iy-8*Iz)*du[4]*cos(u[2])+((16*Iy-16*Iz)*du[3]*sin(u[2])+(8*Iy-8*Iz)*du[1]*cos(2*u[2]))*sin(u[3])+((-8*Iy)+8*Iz)*du[4]*cos(u[2])*cos(2*u[3]))*cos(u[4])+((16*Iy-16*Iz)*du[3]*cos(u[2])+((-4*Iy)+4*Iz)*du[1]*sin(2*u[2]))*sin(2*u[3])*sin(u[4])+((-4*Iy)+4*Iz)*du[5]*cos(u[2])*sin(2*u[3])*cos(2*u[4])+(8*Iy-8*Iz)*du[5]*sin(u[2])*sin(u[3])*sin(2*u[4]))*sin(2*u[5])+((-4*du[1]*sin(2*u[2]))+((-16*du[3]*cos(u[2]))+4*du[1]*sin(2*u[2]))*cos(2*u[3]))*Iys) 
c22 = -(1/4)*(((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[3]*sin(2*u[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[3]*sin(2*u[3])*cos(2*u[4])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*du[4]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[4]*cos(2*u[3]))*sin(2*u[4])+((3*Iy-3*Iz)*du[3]*sin(2*u[3])+(4*Iy-4*Iz)*du[5]*sin(2*u[3])*sin(u[4])+((-Iy)+Iz)*du[3]*sin(2*u[3])*cos(2*u[4])+((Iy-Iz)*du[4]+((-Iy)+Iz)*du[4]*cos(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+((Iy-Iz)*du[5]+(3*Iy-3*Iz)*du[5]*cos(2*u[3])+(2*Iy-2*Iz)*du[4]*sin(2*u[3])*cos(u[4])+(4*Iy-4*Iz)*du[3]*cos(2*u[3])*sin(u[4])+((Iy-Iz)*du[5]+((-Iy)+Iz)*du[5]*cos(2*u[3]))*cos(2*u[4]))*sin(2*u[5])+4*du[3]*sin(2*u[3])*Iys) 
c23 = -(1/4)*((2*Iy+4*Iyg+2*Iz)*du[4]*sin(u[3])+4*Ix*du[5]*cos(u[3])*cos(u[4])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*du[4]*sin(u[3])*cos(2*u[4])+(2*Ix+2*Ixg-Iy-Iz-2*Izg)*du[3]*cos(u[3])*sin(2*u[4])+((2*Iy-2*Iz)*du[4]*sin(u[3])+(4*Iy-4*Iz)*du[5]*cos(u[3])*cos(u[4])+(2*Iy-2*Iz)*du[4]*sin(u[3])*cos(2*u[4])+(Iy-Iz)*du[3]*cos(u[3])*sin(2*u[4]))*cos(2*u[5])+(((-2*Iy)+2*Iz)*du[3]*sin(u[3])*cos(u[4])+((-2*Iy)+2*Iz)*du[5]*sin(u[3])*sin(2*u[4]))*sin(2*u[5])) 
c24 = (1/2)*(2*Ix*du[5]*sin(u[3])*sin(u[4])+((-2*Iy)+2*Iz)*du[5]*sin(u[3])*sin(u[4])*cos(2*u[5])+(((-2*Iy)+2*Iz)*du[5]*cos(u[3])+((-Iy)+Iz)*du[4]*sin(u[3])*cos(u[4]))*sin(2*u[5])) 
c25 = 0 

c31 = -(1/16)*((8*Ix+8*Ixg+4*Iy+4*Iz+8*Izg+16*Izs)*du[2]*cos(u[2])+(8*Iy+16*Iyg+8*Iz)*du[4]*cos(u[2])*cos(u[3])+((-8*Ix)-8*Ixg-16*Ixs+4*Iy+16*Iyg+4*Iz-8*Izg)*du[2]*cos(u[2])*cos(2*u[3])+(((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[1]+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[1]*cos(2*u[2]))*sin(2*u[3])-16*Ix*du[5]*cos(u[2])*sin(u[3])*cos(u[4])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[2]*cos(u[2])+((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*du[4]*cos(u[2])*cos(u[3])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[2]*cos(u[2])*cos(2*u[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[1]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[1]*cos(2*u[2]))*sin(2*u[3]))*cos(2*u[4])+((16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*du[4]*sin(u[2])+(16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*du[2]*sin(u[2])*cos(u[3])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*du[1]*sin(2*u[2])*sin(u[3]))*sin(2*u[4])+(((-4*Iy)+4*Iz)*du[2]*cos(u[2])+(8*Iy-8*Iz)*du[4]*cos(u[2])*cos(u[3])+(12*Iy-12*Iz)*du[2]*cos(u[2])*cos(2*u[3])+((3*Iy-3*Iz)*du[1]+(3*Iy-3*Iz)*du[1]*cos(2*u[2]))*sin(2*u[3])+(16*Iy-16*Iz)*du[5]*cos(u[2])*sin(u[3])*cos(u[4])+(((-4*Iy)+4*Iz)*du[2]*cos(u[2])+((-8*Iy)+8*Iz)*du[4]*cos(u[2])*cos(u[3])+((-4*Iy)+4*Iz)*du[2]*cos(u[2])*cos(2*u[3])+(((-Iy)+Iz)*du[1]+((-Iy)+Iz)*du[1]*cos(2*u[2]))*sin(2*u[3]))*cos(2*u[4])+((8*Iy-8*Iz)*du[4]*sin(u[2])+(8*Iy-8*Iz)*du[2]*sin(u[2])*cos(u[3])+(2*Iy-2*Iz)*du[1]*sin(2*u[2])*sin(u[3]))*sin(2*u[4]))*cos(2*u[5])+((8*Iy-8*Iz)*du[5]*sin(u[2])+((4*Iy-4*Iz)*du[1]*sin(2*u[2])*cos(u[3])+((-16*Iy)+16*Iz)*du[2]*sin(u[2])*sin(u[3]))*cos(u[4])+(((-16*Iy)+16*Iz)*du[4]*cos(u[2])*sin(u[3])+((4*Iy-4*Iz)*du[1]+(4*Iy-4*Iz)*du[1]*cos(2*u[2]))*cos(2*u[3])+((-16*Iy)+16*Iz)*du[2]*cos(u[2])*sin(2*u[3]))*sin(u[4])+(8*Iy-8*Iz)*du[5]*sin(u[2])*cos(2*u[4])+(8*Iy-8*Iz)*du[5]*cos(u[2])*cos(u[3])*sin(2*u[4]))*sin(2*u[5])+(16*du[2]*cos(u[2])*cos(2*u[3])+(4*du[1]+4*du[1]*cos(2*u[2]))*sin(2*u[3]))*Iys) 
c32 = (1/8)*((4*Iy+8*Iyg+4*Iz)*du[4]*sin(u[3])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*du[2]*sin(2*u[3])+8*Ix*du[5]*cos(u[3])*cos(u[4])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[4]*sin(u[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[2]*sin(2*u[3]))*cos(2*u[4])+((4*Iy-4*Iz)*du[4]*sin(u[3])+(3*Iy-3*Iz)*du[2]*sin(2*u[3])+((-8*Iy)+8*Iz)*du[5]*cos(u[3])*cos(u[4])+(((-4*Iy)+4*Iz)*du[4]*sin(u[3])+((-Iy)+Iz)*du[2]*sin(2*u[3]))*cos(2*u[4]))*cos(2*u[5])+(((8*Iy-8*Iz)*du[4]*cos(u[3])+(4*Iy-4*Iz)*du[2]*cos(2*u[3]))*sin(u[4])+(4*Iy-4*Iz)*du[5]*sin(u[3])*sin(2*u[4]))*sin(2*u[5])+4*du[2]*sin(2*u[3])*Iys) 
c33 = -(1/2)*(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[4]*sin(2*u[4])+((-Iy)+Iz)*du[4]*sin(2*u[4])*cos(2*u[5])+(((-Iy)+Iz)*du[5]+((-Iy)+Iz)*du[5]*cos(2*u[4]))*sin(2*u[5])) 
c34 = -(1/2)*((-2*Ix*du[5]*cos(u[4]))+(2*Iy-2*Iz)*du[5]*cos(u[4])*cos(2*u[5])+((-Iy)+Iz)*du[4]*sin(u[4])*sin(2*u[5])) 
c35 = 0 

c41 = -(1/16)*(((-8*Iy)-16*Iyg-8*Iz)*du[3]*cos(u[2])*cos(u[3])+(8*Iy+16*Iyg+8*Iz)*du[2]*sin(u[2])*sin(u[3])-16*Ix*du[5]*sin(u[2])*cos(u[4])-16*Ix*du[5]*cos(u[2])*cos(u[3])*sin(u[4])+(((16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*du[3]*cos(u[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*du[1]*sin(2*u[2]))*cos(u[3])+(16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*du[2]*sin(u[2])*sin(u[3]))*cos(2*u[4])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*du[1]+((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*du[3]*sin(u[2])+((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*du[1]*cos(2*u[2])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[1]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[1]*cos(2*u[2]))*cos(2*u[3])+(8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*du[2]*cos(u[2])*sin(2*u[3]))*sin(2*u[4])+(((-8*Iy)+8*Iz)*du[3]*cos(u[2])*cos(u[3])+(8*Iy-8*Iz)*du[2]*sin(u[2])*sin(u[3])+((-16*Iy)+16*Iz)*du[5]*sin(u[2])*cos(u[4])+((-16*Iy)+16*Iz)*du[5]*cos(u[2])*cos(u[3])*sin(u[4])+(((8*Iy-8*Iz)*du[3]*cos(u[2])+((-4*Iy)+4*Iz)*du[1]*sin(2*u[2]))*cos(u[3])+(8*Iy-8*Iz)*du[2]*sin(u[2])*sin(u[3]))*cos(2*u[4])+((Iy-Iz)*du[1]+((-8*Iy)+8*Iz)*du[3]*sin(u[2])+((-3*Iy)+3*Iz)*du[1]*cos(2*u[2])+(((-Iy)+Iz)*du[1]+((-Iy)+Iz)*du[1]*cos(2*u[2]))*cos(2*u[3])+(4*Iy-4*Iz)*du[2]*cos(u[2])*sin(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+((16*Iy-16*Iz)*du[5]*cos(u[2])*sin(u[3])+(((-8*Iy)+8*Iz)*du[2]*cos(u[2])+(8*Iy-8*Iz)*du[2]*cos(u[2])*cos(2*u[3])+((2*Iy-2*Iz)*du[1]+(2*Iy-2*Iz)*du[1]*cos(2*u[2]))*sin(2*u[3]))*cos(u[4])+((16*Iy-16*Iz)*du[3]*cos(u[2])+((-4*Iy)+4*Iz)*du[1]*sin(2*u[2]))*sin(u[3])*sin(u[4]))*sin(2*u[5])) 
c42 = (1/8)*(((-4*Iy)-8*Iyg-4*Iz)*du[3]*sin(u[3])-8*Ix*du[5]*sin(u[3])*sin(u[4])+(8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*du[3]*sin(u[3])*cos(2*u[4])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*du[2]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[2]*cos(2*u[3]))*sin(2*u[4])+(((-4*Iy)+4*Iz)*du[3]*sin(u[3])+((-8*Iy)+8*Iz)*du[5]*sin(u[3])*sin(u[4])+(4*Iy-4*Iz)*du[3]*sin(u[3])*cos(2*u[4])+((Iy-Iz)*du[2]+((-Iy)+Iz)*du[2]*cos(2*u[3]))*sin(2*u[4]))*cos(2*u[5])+(((-8*Iy)+8*Iz)*du[5]*cos(u[3])+(2*Iy-2*Iz)*du[2]*sin(2*u[3])*cos(u[4])+((-8*Iy)+8*Iz)*du[3]*cos(u[3])*sin(u[4]))*sin(2*u[5])) 
c43 = (1/4)*((-4*Ix*du[5]*cos(u[4]))+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*du[3]*sin(2*u[4])+(((-4*Iy)+4*Iz)*du[5]*cos(u[4])+((-Iy)+Iz)*du[3]*sin(2*u[4]))*cos(2*u[5])) 
c44 = ((-Iy)+Iz)*du[5]*sin(2*u[5]) 

c45 = 0 

c51 = -(1/16)*((16*Ix*du[4]*sin(u[2])+16*Ix*du[2]*sin(u[2])*cos(u[3])+16*Ix*du[3]*cos(u[2])*sin(u[3]))*cos(u[4])+(16*Ix*du[2]*cos(u[2])+16*Ix*du[4]*cos(u[2])*cos(u[3]))*sin(u[4])+(((16*Iy-16*Iz)*du[4]*sin(u[2])+(16*Iy-16*Iz)*du[2]*sin(u[2])*cos(u[3])+(((-16*Iy)+16*Iz)*du[3]*cos(u[2])+(8*Iy-8*Iz)*du[1]*sin(2*u[2]))*sin(u[3]))*cos(u[4])+((16*Iy-16*Iz)*du[4]*cos(u[2])*cos(u[3])+(16*Iy-16*Iz)*du[2]*cos(u[2])*cos(2*u[3])+((4*Iy-4*Iz)*du[1]+(4*Iy-4*Iz)*du[1]*cos(2*u[2]))*sin(2*u[3]))*sin(u[4]))*cos(2*u[5])+((Iy-Iz)*du[1]+((-8*Iy)+8*Iz)*du[3]*sin(u[2])+((-3*Iy)+3*Iz)*du[1]*cos(2*u[2])+((-16*Iy)+16*Iz)*du[4]*cos(u[2])*sin(u[3])+((3*Iy-3*Iz)*du[1]+(3*Iy-3*Iz)*du[1]*cos(2*u[2]))*cos(2*u[3])+((-12*Iy)+12*Iz)*du[2]*cos(u[2])*sin(2*u[3])+((Iy-Iz)*du[1]+((-8*Iy)+8*Iz)*du[3]*sin(u[2])+((-3*Iy)+3*Iz)*du[1]*cos(2*u[2])+(((-Iy)+Iz)*du[1]+((-Iy)+Iz)*du[1]*cos(2*u[2]))*cos(2*u[3])+(4*Iy-4*Iz)*du[2]*cos(u[2])*sin(2*u[3]))*cos(2*u[4])+((((-8*Iy)+8*Iz)*du[3]*cos(u[2])+(4*Iy-4*Iz)*du[1]*sin(2*u[2]))*cos(u[3])+((-8*Iy)+8*Iz)*du[2]*sin(u[2])*sin(u[3]))*sin(2*u[4]))*sin(2*u[5])) 
c52 = (1/8)*((-8*Ix*du[3]*cos(u[3])*cos(u[4]))+8*Ix*du[4]*sin(u[3])*sin(u[4])+((8*Iy-8*Iz)*du[3]*cos(u[3])*cos(u[4])+((8*Iy-8*Iz)*du[4]*sin(u[3])+(4*Iy-4*Iz)*du[2]*sin(2*u[3]))*sin(u[4]))*cos(2*u[5])+((Iy-Iz)*du[2]+(8*Iy-8*Iz)*du[4]*cos(u[3])+(3*Iy-3*Iz)*du[2]*cos(2*u[3])+((Iy-Iz)*du[2]+((-Iy)+Iz)*du[2]*cos(2*u[3]))*cos(2*u[4])+((-4*Iy)+4*Iz)*du[3]*sin(u[3])*sin(2*u[4]))*sin(2*u[5])) 
c53 = (1/4)*(4*Ix*du[4]*cos(u[4])+(4*Iy-4*Iz)*du[4]*cos(u[4])*cos(2*u[5])+(((-Iy)+Iz)*du[3]+((-Iy)+Iz)*du[3]*cos(2*u[4]))*sin(2*u[5])) 
c54 = -(1/2)*((-Iy)+Iz)*du[4]*sin(2*u[5]) 

c55 = 0 

M=[m11 m12 m13 m14 m15
    m12 m22 m23 m24 m25
    m13 m23 m33 m34 m35
    m14 m24 m34 m44 m45
    m15 m25 m35 m45 m55]


 C=[c11 c12 c13 c14 c15
    c21 c22 c23 c24 c25
    c31 c32 c33 c34 c35
    c41 c42 c43 c44 c45
    c51 c52 c53 c54 c55]


g = inv(M);

θp= [du[1];du[2];du[3];du[4];du[5]];
τ = [0;0;0;τ₄;τ₅];

g = Minv;
f = Minv*(-C*θp);
xp = f  + g*τ;

xp = Minv*(τ -C*θp);

θ₁ₚₚ = xp[1];
θ₂ₚₚ = xp[2];

β₁ = mycoeffs(θ₁ₚₚ,τ₄,1);
β₂ = mycoeffs(θ₁ₚₚ,τ₅,1);

β₃ = mycoeffs(θ₂ₚₚ,τ₄,1);
β₄ = mycoeffs(θ₂ₚₚ,τ₅,1);

α₁ = substitute(θ₁ₚₚ,Dict([ (τ₄,0),(τ₅,0) ]))
α₂ = substitute(θ₂ₚₚ,Dict([ (τ₄,0),(τ₅,0) ]))


B = [β₁ β₂
     β₃ β₄];
A = [α₁
     α₂]
v = [v₁
     v₂]

τ = inv(B)*(v - A)

formatted_expr_str = replace(string(f), r"(\d)([a-zA-Z])" => s"\1 * \2");
formatted_expr_str2 = replace(formatted_expr_str, r"(\d)(\()" => s"\1 * \2");

open("xp.txt", "w") do f
    write(f, string(formatted_expr_str2))
end