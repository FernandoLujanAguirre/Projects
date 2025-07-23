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

@variables Ix Iy Iz Ig Izg Is t τ₄ τ₅
@variables u[1] u[2] u[3] u[4] u[5] u[6] u[7] u[8] u[9] u[10]

m11 = 0.02+0.013*cos(2*u[2])+1.1E-4*cos(2*u[3])+1.1E-4*cos(2*u[2])*cos(2*u[3])+6.5E-7*cos(2*u[4])+-2.0E-6*cos(2*u[2])*cos(2*u[4])+-6.5E-7*cos(2*u[3])*cos(2*u[4])+-6.5E-7*cos(2*u[2])*cos(2*u[3])*cos(2*u[4])+2.6E-6*sin(2*u[2])*cos(u[3])*sin(2*u[4])+1.4E-7*cos(2*u[5])+-4.3E-7*cos(2*u[2])*cos(2*u[5])+4.3E-7*cos(2*u[3])*cos(2*u[5])+4.3E-7*cos(2*u[2])*cos(2*u[3])*cos(2*u[5])+1.4E-7*cos(2*u[4])*cos(2*u[5])+-4.3E-7*cos(2*u[2])*cos(2*u[4])*cos(2*u[5])+-1.4E-7*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])+-1.4E-7*cos(2*u[2])*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])+5.7E-7*sin(2*u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])+-1.1E-6*sin(2*u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])+-5.7E-7*sin(2*u[3])*sin(u[4])*sin(2*u[5])+-5.7E-7*cos(2*u[2])*sin(2*u[3])*sin(u[4])*sin(2*u[5])
m12 = -2.2E-4*cos(u[2])*sin(2*u[3])+1.3E-6*cos(u[2])*sin(2*u[3])*cos(2*u[4])+-2.6E-6*sin(u[2])*sin(u[3])*sin(2*u[4])+-8.6E-7*cos(u[2])*sin(2*u[3])*cos(2*u[5])+2.9E-7*cos(u[2])*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])+-5.7E-7*sin(u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])+-1.1E-6*sin(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])+-1.1E-6*cos(u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])
m13 = -0.0069*sin(u[2])+-2.6E-6*sin(u[2])*cos(2*u[4])+-2.6E-6*cos(u[2])*cos(u[3])*sin(2*u[4])+-5.7E-7*sin(u[2])*cos(2*u[5])+-5.7E-7*sin(u[2])*cos(2*u[4])*cos(2*u[5])+-5.7E-7*cos(u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])+1.1E-6*cos(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])
m14 = 8.5E-6*cos(u[2])*sin(u[3])+-1.1E-6*cos(u[2])*sin(u[3])*cos(2*u[5])+-1.1E-6*sin(u[2])*cos(u[4])*sin(2*u[5])+-1.1E-6*cos(u[2])*cos(u[3])*sin(u[4])*sin(2*u[5])
m15 = 3.3E-6*cos(u[2])*cos(u[3])*cos(u[4])+-3.3E-6*sin(u[2])*sin(u[4])

m21 = -2.2E-4*cos(u[2])*sin(2*u[3])+1.3E-6*cos(u[2])*sin(2*u[3])*cos(2*u[4])+-2.6E-6*sin(u[2])*sin(u[3])*sin(2*u[4])+-8.6E-7*cos(u[2])*sin(2*u[3])*cos(2*u[5])+2.9E-7*cos(u[2])*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])+-5.7E-7*sin(u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])+-1.1E-6*sin(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])+-1.1E-6*cos(u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])
m22 = 0.033+-2.2E-4*cos(2*u[3])+-1.3E-6*cos(2*u[4])+1.3E-6*cos(2*u[3])*cos(2*u[4])+-2.9E-7*cos(2*u[5])+-8.6E-7*cos(2*u[3])*cos(2*u[5])+-2.9E-7*cos(2*u[4])*cos(2*u[5])+2.9E-7*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])+1.1E-6*sin(2*u[3])*sin(u[4])*sin(2*u[5])
m23 = 2.6E-6*sin(u[3])*sin(2*u[4])+5.7E-7*sin(u[3])*sin(2*u[4])*cos(2*u[5])+1.1E-6*cos(u[3])*cos(u[4])*sin(2*u[5])
m24 = 8.5E-6*cos(u[3])+-1.1E-6*cos(u[3])*cos(2*u[5])+1.1E-6*sin(u[3])*sin(u[4])*sin(2*u[5])
m25 = -3.3E-6*sin(u[3])*cos(u[4])

m31 = -0.0069*sin(u[2])+-2.6E-6*sin(u[2])*cos(2*u[4])+-2.6E-6*cos(u[2])*cos(u[3])*sin(2*u[4])+-5.7E-7*sin(u[2])*cos(2*u[5])+-5.7E-7*sin(u[2])*cos(2*u[4])*cos(2*u[5])+-5.7E-7*cos(u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])+1.1E-6*cos(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])
m32 = 2.6E-6*sin(u[3])*sin(2*u[4])+5.7E-7*sin(u[3])*sin(2*u[4])*cos(2*u[5])+1.1E-6*cos(u[3])*cos(u[4])*sin(2*u[5])
m33 = 0.0069+2.6E-6*cos(2*u[4])+5.7E-7*cos(2*u[5])+5.7E-7*cos(2*u[4])*cos(2*u[5])
m34 = 1.1E-6*cos(u[4])*sin(2*u[5])
m35 = 3.3E-6*sin(u[4])

m41 = 8.5E-6*cos(u[2])*sin(u[3])+-1.1E-6*cos(u[2])*sin(u[3])*cos(2*u[5])+-1.1E-6*sin(u[2])*cos(u[4])*sin(2*u[5])+-1.1E-6*cos(u[2])*cos(u[3])*sin(u[4])*sin(2*u[5])
m42 = 8.5E-6*cos(u[3])+-1.1E-6*cos(u[3])*cos(2*u[5])+1.1E-6*sin(u[3])*sin(u[4])*sin(2*u[5])
m43 = 1.1E-6*cos(u[4])*sin(2*u[5])
m44 = 8.5E-6+-1.1E-6*cos(2*u[5])
m45 = 

m51 = 3.3E-6*cos(u[2])*cos(u[3])*cos(u[4])+-3.3E-6*sin(u[2])*sin(u[4])
m52 = -3.3E-6*sin(u[3])*cos(u[4])
m53 = 3.3E-6*sin(u[4])
m54 = 0
m55 = 3.3E-6

c11 = -0.026*u[7]*sin(2*u[2])+-2.2E-4*u[7]*sin(2*u[2])*cos(2*u[3])+-2.2E-4*u[8]*sin(2*u[3])+-2.2E-4*u[8]*cos(2*u[2])*sin(2*u[3])+3.9E-6*u[7]*sin(2*u[2])*cos(2*u[4])+5.2E-6*u[9]*sin(2*u[2])*cos(u[3])*cos(2*u[4])+1.3E-6*u[7]*sin(2*u[2])*cos(2*u[3])*cos(2*u[4])+1.3E-6*u[8]*sin(2*u[3])*cos(2*u[4])+1.3E-6*u[8]*cos(2*u[2])*sin(2*u[3])*cos(2*u[4])+-1.3E-6*u[9]*sin(2*u[4])+3.9E-6*u[9]*cos(2*u[2])*sin(2*u[4])+5.2E-6*u[7]*cos(2*u[2])*cos(u[3])*sin(2*u[4])+-2.6E-6*u[8]*sin(2*u[2])*sin(u[3])*sin(2*u[4])+1.3E-6*u[9]*cos(2*u[3])*sin(2*u[4])+1.3E-6*u[9]*cos(2*u[2])*cos(2*u[3])*sin(2*u[4])+8.6E-7*u[7]*sin(2*u[2])*cos(2*u[5])+-8.6E-7*u[7]*sin(2*u[2])*cos(2*u[3])*cos(2*u[5])+-8.6E-7*u[8]*sin(2*u[3])*cos(2*u[5])+-8.6E-7*u[8]*cos(2*u[2])*sin(2*u[3])*cos(2*u[5])+-2.3E-6*u[10]*sin(2*u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])+-1.1E-6*u[10]*sin(2*u[3])*sin(u[4])*cos(2*u[5])+-1.1E-6*u[10]*cos(2*u[2])*sin(2*u[3])*sin(u[4])*cos(2*u[5])+8.6E-7*u[7]*sin(2*u[2])*cos(2*u[4])*cos(2*u[5])+1.1E-6*u[9]*sin(2*u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])+2.9E-7*u[7]*sin(2*u[2])*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])+2.9E-7*u[8]*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])+2.9E-7*u[8]*cos(2*u[2])*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])+-2.9E-7*u[9]*sin(2*u[4])*cos(2*u[5])+8.6E-7*u[9]*cos(2*u[2])*sin(2*u[4])*cos(2*u[5])+1.1E-6*u[7]*cos(2*u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])+-5.7E-7*u[8]*sin(2*u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])+2.9E-7*u[9]*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])+2.9E-7*u[9]*cos(2*u[2])*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])+-2.9E-7*u[10]*sin(2*u[5])+8.6E-7*u[10]*cos(2*u[2])*sin(2*u[5])+-8.6E-7*u[10]*cos(2*u[3])*sin(2*u[5])+-8.6E-7*u[10]*cos(2*u[2])*cos(2*u[3])*sin(2*u[5])+-1.1E-6*u[8]*sin(2*u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])+-2.3E-6*u[7]*cos(2*u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])+-5.7E-7*u[9]*sin(2*u[3])*cos(u[4])*sin(2*u[5])+-5.7E-7*u[9]*cos(2*u[2])*sin(2*u[3])*cos(u[4])*sin(2*u[5])+1.1E-6*u[9]*sin(2*u[2])*sin(u[3])*sin(u[4])*sin(2*u[5])+-1.1E-6*u[8]*cos(2*u[3])*sin(u[4])*sin(2*u[5])+-1.1E-6*u[8]*cos(2*u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])+1.1E-6*u[7]*sin(2*u[2])*sin(2*u[3])*sin(u[4])*sin(2*u[5])+-2.9E-7*u[10]*cos(2*u[4])*sin(2*u[5])+8.6E-7*u[10]*cos(2*u[2])*cos(2*u[4])*sin(2*u[5])+2.9E-7*u[10]*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])+2.9E-7*u[10]*cos(2*u[2])*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])+-1.1E-6*u[10]*sin(2*u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5]) 
c12 = -0.0069*u[8]*cos(u[2])+-8.5E-6*u[9]*sin(u[2])*sin(u[3])+-4.4E-4*u[8]*cos(u[2])*cos(2*u[3])+2.2E-4*u[7]*sin(u[2])*sin(2*u[3])+-3.2E-6*u[10]*sin(u[2])*cos(u[3])*cos(u[4])+-3.2E-6*u[10]*cos(u[2])*sin(u[4])+-2.6E-6*u[8]*cos(u[2])*cos(2*u[4])+-5.2E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[4])+2.6E-6*u[8]*cos(u[2])*cos(2*u[3])*cos(2*u[4])+-1.3E-6*u[7]*sin(u[2])*sin(2*u[3])*cos(2*u[4])+-2.6E-6*u[7]*cos(u[2])*sin(u[3])*sin(2*u[4])+-2.6E-6*u[9]*cos(u[2])*sin(2*u[3])*sin(2*u[4])+-5.7E-7*u[8]*cos(u[2])*cos(2*u[5])+1.1E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[5])+-1.7E-6*u[8]*cos(u[2])*cos(2*u[3])*cos(2*u[5])+8.6E-7*u[7]*sin(u[2])*sin(2*u[3])*cos(2*u[5])+-2.3E-6*u[10]*sin(u[2])*cos(u[3])*cos(u[4])*cos(2*u[5])+-2.3E-6*u[10]*cos(u[2])*cos(2*u[3])*sin(u[4])*cos(2*u[5])+-5.7E-7*u[8]*cos(u[2])*cos(2*u[4])*cos(2*u[5])+-1.1E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[4])*cos(2*u[5])+5.7E-7*u[8]*cos(u[2])*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])+-2.9E-7*u[7]*sin(u[2])*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])+-5.7E-7*u[7]*cos(u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])+-5.7E-7*u[9]*cos(u[2])*sin(2*u[3])*sin(2*u[4])*cos(2*u[5])+1.7E-6*u[10]*cos(u[2])*sin(2*u[3])*sin(2*u[5])+-1.1E-6*u[9]*cos(u[2])*cos(u[4])*sin(2*u[5])+-1.1E-6*u[7]*cos(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])+-1.1E-6*u[9]*cos(u[2])*cos(2*u[3])*cos(u[4])*sin(2*u[5])+2.3E-6*u[9]*sin(u[2])*cos(u[3])*sin(u[4])*sin(2*u[5])+1.1E-6*u[7]*sin(u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])+2.3E-6*u[8]*cos(u[2])*sin(2*u[3])*sin(u[4])*sin(2*u[5])+-5.7E-7*u[10]*cos(u[2])*sin(2*u[3])*cos(2*u[4])*sin(2*u[5])+1.1E-6*u[10]*sin(u[2])*sin(u[3])*sin(2*u[4])*sin(2*u[5]) 
c13 = 8.5E-6*u[9]*cos(u[2])*cos(u[3])+-3.3E-6*u[10]*cos(u[2])*sin(u[3])*cos(u[4])+-5.2E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[4])+5.2E-6*u[9]*sin(u[2])*sin(2*u[4])+2.6E-6*u[8]*cos(u[2])*sin(u[3])*sin(2*u[4])+-1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[5])+2.3E-6*u[10]*cos(u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])+-1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])+1.1E-6*u[9]*sin(u[2])*sin(2*u[4])*cos(2*u[5])+5.7E-7*u[8]*cos(u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])+1.1E-6*u[10]*sin(u[2])*sin(2*u[5])+1.1E-6*u[8]*cos(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])+1.1E-6*u[10]*sin(u[2])*cos(2*u[4])*sin(2*u[5])+1.1E-6*u[10]*cos(u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5]) 
c14 = -3.3E-6*u[10]*sin(u[2])*cos(u[4])+-3.3E-6*u[10]*cos(u[2])*cos(u[3])*sin(u[4])+-2.3E-6*u[10]*sin(u[2])*cos(u[4])*cos(2*u[5])+-2.3E-6*u[10]*cos(u[2])*cos(u[3])*sin(u[4])*cos(2*u[5])+2.3E-6*u[10]*cos(u[2])*sin(u[3])*sin(2*u[5])+-1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])+1.1E-6*u[9]*sin(u[2])*sin(u[4])*sin(2*u[5]) 
c15 = 0

c21 = 0.0069*u[8]*cos(u[2])+0.013*u[6]*sin(2*u[2])+8.5E-6*u[9]*sin(u[2])*sin(u[3])+-4.4E-4*u[8]*cos(u[2])*cos(2*u[3])+1.1E-4*u[6]*sin(2*u[2])*cos(2*u[3])+3.3E-6*u[10]*sin(u[2])*cos(u[3])*cos(u[4])+3.3E-6*u[10]*cos(u[2])*sin(u[4])+2.6E-6*u[8]*cos(u[2])*cos(2*u[4])+-2.0E-6*u[6]*sin(2*u[2])*cos(2*u[4])+-5.2E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[4])+2.6E-6*u[8]*cos(u[2])*cos(2*u[3])*cos(2*u[4])+-6.5E-7*u[6]*sin(2*u[2])*cos(2*u[3])*cos(2*u[4])+-5.2E-6*u[8]*sin(u[2])*cos(u[3])*sin(2*u[4])+-2.6E-6*u[6]*cos(2*u[2])*cos(u[3])*sin(2*u[4])+-2.6E-6*u[9]*cos(u[2])*sin(2*u[3])*sin(2*u[4])+5.7E-7*u[8]*cos(u[2])*cos(2*u[5])+-4.3E-7*u[6]*sin(2*u[2])*cos(2*u[5])+-1.1E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[5])+-1.7E-6*u[8]*cos(u[2])*cos(2*u[3])*cos(2*u[5])+4.3E-7*u[6]*sin(2*u[2])*cos(2*u[3])*cos(2*u[5])+-2.3E-6*u[10]*sin(u[2])*cos(u[3])*cos(u[4])*cos(2*u[5])+-2.3E-6*u[10]*cos(u[2])*cos(2*u[3])*sin(u[4])*cos(2*u[5])+5.7E-7*u[8]*cos(u[2])*cos(2*u[4])*cos(2*u[5])+-4.3E-7*u[6]*sin(2*u[2])*cos(2*u[4])*cos(2*u[5])+-1.1E-6*u[9]*sin(u[2])*sin(u[3])*cos(2*u[4])*cos(2*u[5])+5.7E-7*u[8]*cos(u[2])*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])+-1.4E-7*u[6]*sin(2*u[2])*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])+-1.1E-6*u[8]*sin(u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])+-5.7E-7*u[6]*cos(2*u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])+-5.7E-7*u[9]*cos(u[2])*sin(2*u[3])*sin(2*u[4])*cos(2*u[5])+1.7E-6*u[10]*cos(u[2])*sin(2*u[3])*sin(2*u[5])+1.1E-6*u[9]*cos(u[2])*cos(u[4])*sin(2*u[5])+2.3E-6*u[8]*sin(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])+1.1E-6*u[6]*cos(2*u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])+-1.1E-6*u[9]*cos(u[2])*cos(2*u[3])*cos(u[4])*sin(2*u[5])+2.3E-6*u[8]*cos(u[2])*sin(2*u[3])*sin(u[4])*sin(2*u[5])+-5.7E-7*u[6]*sin(2*u[2])*sin(2*u[3])*sin(u[4])*sin(2*u[5])+-5.7E-7*u[10]*cos(u[2])*sin(2*u[3])*cos(2*u[4])*sin(2*u[5])+1.1E-6*u[10]*sin(u[2])*sin(u[3])*sin(2*u[4])*sin(2*u[5]) 
c22 = 4.4E-4*u[8]*sin(2*u[3])+-2.6E-6*u[8]*sin(2*u[3])*cos(2*u[4])+2.6E-6*u[9]*sin(2*u[4])+-2.6E-6*u[9]*cos(2*u[3])*sin(2*u[4])+1.7E-6*u[8]*sin(2*u[3])*cos(2*u[5])+2.3E-6*u[10]*sin(2*u[3])*sin(u[4])*cos(2*u[5])+-5.7E-7*u[8]*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])+5.7E-7*u[9]*sin(2*u[4])*cos(2*u[5])+-5.7E-7*u[9]*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])+5.7E-7*u[10]*sin(2*u[5])+1.7E-6*u[10]*cos(2*u[3])*sin(2*u[5])+1.1E-6*u[9]*sin(2*u[3])*cos(u[4])*sin(2*u[5])+2.3E-6*u[8]*cos(2*u[3])*sin(u[4])*sin(2*u[5])+5.7E-7*u[10]*cos(2*u[4])*sin(2*u[5])+-5.7E-7*u[10]*cos(2*u[3])*cos(2*u[4])*sin(2*u[5]) 
c23 = -8.5E-6*u[9]*sin(u[3])+-3.3E-6*u[10]*cos(u[3])*cos(u[4])+5.2E-6*u[9]*sin(u[3])*cos(2*u[4])+2.6E-6*u[8]*cos(u[3])*sin(2*u[4])+1.1E-6*u[9]*sin(u[3])*cos(2*u[5])+2.3E-6*u[10]*cos(u[3])*cos(u[4])*cos(2*u[5])+1.1E-6*u[9]*sin(u[3])*cos(2*u[4])*cos(2*u[5])+5.7E-7*u[8]*cos(u[3])*sin(2*u[4])*cos(2*u[5])+-1.1E-6*u[8]*sin(u[3])*cos(u[4])*sin(2*u[5])+-1.1E-6*u[10]*sin(u[3])*sin(2*u[4])*sin(2*u[5]) 
c24 = 3.3E-6*u[10]*sin(u[3])*sin(u[4])+2.3E-6*u[10]*sin(u[3])*sin(u[4])*cos(2*u[5])+2.3E-6*u[10]*cos(u[3])*sin(2*u[5])+1.1E-6*u[9]*sin(u[3])*cos(u[4])*sin(2*u[5]) 
c25 = 0

c31 = -0.0069*u[7]*cos(u[2])+-8.5E-6*u[9]*cos(u[2])*cos(u[3])+4.4E-4*u[7]*cos(u[2])*cos(2*u[3])+1.1E-4*u[6]*sin(2*u[3])+1.1E-4*u[6]*cos(2*u[2])*sin(2*u[3])+3.3E-6*u[10]*cos(u[2])*sin(u[3])*cos(u[4])+-2.6E-6*u[7]*cos(u[2])*cos(2*u[4])+-5.2E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[4])+-2.6E-6*u[7]*cos(u[2])*cos(2*u[3])*cos(2*u[4])+-6.5E-7*u[6]*sin(2*u[3])*cos(2*u[4])+-6.5E-7*u[6]*cos(2*u[2])*sin(2*u[3])*cos(2*u[4])+5.2E-6*u[9]*sin(u[2])*sin(2*u[4])+5.2E-6*u[7]*sin(u[2])*cos(u[3])*sin(2*u[4])+1.3E-6*u[6]*sin(2*u[2])*sin(u[3])*sin(2*u[4])+-5.7E-7*u[7]*cos(u[2])*cos(2*u[5])+1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[5])+1.7E-6*u[7]*cos(u[2])*cos(2*u[3])*cos(2*u[5])+4.3E-7*u[6]*sin(2*u[3])*cos(2*u[5])+4.3E-7*u[6]*cos(2*u[2])*sin(2*u[3])*cos(2*u[5])+2.3E-6*u[10]*cos(u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])+-5.7E-7*u[7]*cos(u[2])*cos(2*u[4])*cos(2*u[5])+-1.1E-6*u[9]*cos(u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])+-5.7E-7*u[7]*cos(u[2])*cos(2*u[3])*cos(2*u[4])*cos(2*u[5])+-1.4E-7*u[6]*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])+-1.4E-7*u[6]*cos(2*u[2])*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])+1.1E-6*u[9]*sin(u[2])*sin(2*u[4])*cos(2*u[5])+1.1E-6*u[7]*sin(u[2])*cos(u[3])*sin(2*u[4])*cos(2*u[5])+2.9E-7*u[6]*sin(2*u[2])*sin(u[3])*sin(2*u[4])*cos(2*u[5])+1.1E-6*u[10]*sin(u[2])*sin(2*u[5])+5.7E-7*u[6]*sin(2*u[2])*cos(u[3])*cos(u[4])*sin(2*u[5])+-2.3E-6*u[7]*sin(u[2])*sin(u[3])*cos(u[4])*sin(2*u[5])+-2.3E-6*u[9]*cos(u[2])*sin(u[3])*sin(u[4])*sin(2*u[5])+5.7E-7*u[6]*cos(2*u[3])*sin(u[4])*sin(2*u[5])+5.7E-7*u[6]*cos(2*u[2])*cos(2*u[3])*sin(u[4])*sin(2*u[5])+-2.3E-6*u[7]*cos(u[2])*sin(2*u[3])*sin(u[4])*sin(2*u[5])+1.1E-6*u[10]*sin(u[2])*cos(2*u[4])*sin(2*u[5])+1.1E-6*u[10]*cos(u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5]) 
c32 = 8.5E-6*u[9]*sin(u[3])+-2.2E-4*u[7]*sin(2*u[3])+3.3E-6*u[10]*cos(u[3])*cos(u[4])+5.2E-6*u[9]*sin(u[3])*cos(2*u[4])+1.3E-6*u[7]*sin(2*u[3])*cos(2*u[4])+-1.1E-6*u[9]*sin(u[3])*cos(2*u[5])+-8.6E-7*u[7]*sin(2*u[3])*cos(2*u[5])+2.3E-6*u[10]*cos(u[3])*cos(u[4])*cos(2*u[5])+1.1E-6*u[9]*sin(u[3])*cos(2*u[4])*cos(2*u[5])+2.9E-7*u[7]*sin(2*u[3])*cos(2*u[4])*cos(2*u[5])+-2.3E-6*u[9]*cos(u[3])*sin(u[4])*sin(2*u[5])+-1.1E-6*u[7]*cos(2*u[3])*sin(u[4])*sin(2*u[5])+-1.1E-6*u[10]*sin(u[3])*sin(2*u[4])*sin(2*u[5]) 
c33 = -5.2E-6*u[9]*sin(2*u[4])+-1.1E-6*u[9]*sin(2*u[4])*cos(2*u[5])+-1.1E-6*u[10]*sin(2*u[5])+-1.1E-6*u[10]*cos(2*u[4])*sin(2*u[5]) 
c34 = 3.3E-6*u[10]*cos(u[4])+2.3E-6*u[10]*cos(u[4])*cos(2*u[5])+-1.1E-6*u[9]*sin(u[4])*sin(2*u[5]) 
c35 = 0

c41 = 8.5E-6*u[8]*cos(u[2])*cos(u[3])+-8.5E-6*u[7]*sin(u[2])*sin(u[3])+3.3E-6*u[10]*sin(u[2])*cos(u[4])+3.3E-6*u[10]*cos(u[2])*cos(u[3])*sin(u[4])+5.2E-6*u[8]*cos(u[2])*cos(u[3])*cos(2*u[4])+-2.6E-6*u[6]*sin(2*u[2])*cos(u[3])*cos(2*u[4])+5.2E-6*u[7]*sin(u[2])*sin(u[3])*cos(2*u[4])+6.5E-7*u[6]*sin(2*u[4])+-5.2E-6*u[8]*sin(u[2])*sin(2*u[4])+-2.0E-6*u[6]*cos(2*u[2])*sin(2*u[4])+-6.5E-7*u[6]*cos(2*u[3])*sin(2*u[4])+-6.5E-7*u[6]*cos(2*u[2])*cos(2*u[3])*sin(2*u[4])+2.6E-6*u[7]*cos(u[2])*sin(2*u[3])*sin(2*u[4])+-1.1E-6*u[8]*cos(u[2])*cos(u[3])*cos(2*u[5])+1.1E-6*u[7]*sin(u[2])*sin(u[3])*cos(2*u[5])+-2.3E-6*u[10]*sin(u[2])*cos(u[4])*cos(2*u[5])+-2.3E-6*u[10]*cos(u[2])*cos(u[3])*sin(u[4])*cos(2*u[5])+1.1E-6*u[8]*cos(u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])+-5.7E-7*u[6]*sin(2*u[2])*cos(u[3])*cos(2*u[4])*cos(2*u[5])+1.1E-6*u[7]*sin(u[2])*sin(u[3])*cos(2*u[4])*cos(2*u[5])+1.4E-7*u[6]*sin(2*u[4])*cos(2*u[5])+-1.1E-6*u[8]*sin(u[2])*sin(2*u[4])*cos(2*u[5])+-4.3E-7*u[6]*cos(2*u[2])*sin(2*u[4])*cos(2*u[5])+-1.4E-7*u[6]*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])+-1.4E-7*u[6]*cos(2*u[2])*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])+5.7E-7*u[7]*cos(u[2])*sin(2*u[3])*sin(2*u[4])*cos(2*u[5])+2.3E-6*u[10]*cos(u[2])*sin(u[3])*sin(2*u[5])+-1.1E-6*u[7]*cos(u[2])*cos(u[4])*sin(2*u[5])+1.1E-6*u[7]*cos(u[2])*cos(2*u[3])*cos(u[4])*sin(2*u[5])+2.9E-7*u[6]*sin(2*u[3])*cos(u[4])*sin(2*u[5])+2.9E-7*u[6]*cos(2*u[2])*sin(2*u[3])*cos(u[4])*sin(2*u[5])+2.3E-6*u[8]*cos(u[2])*sin(u[3])*sin(u[4])*sin(2*u[5])+-5.7E-7*u[6]*sin(2*u[2])*sin(u[3])*sin(u[4])*sin(2*u[5]) 
c42 = -8.5E-6*u[8]*sin(u[3])+-3.3E-6*u[10]*sin(u[3])*sin(u[4])+-5.2E-6*u[8]*sin(u[3])*cos(2*u[4])+-1.3E-6*u[7]*sin(2*u[4])+1.3E-6*u[7]*cos(2*u[3])*sin(2*u[4])+1.1E-6*u[8]*sin(u[3])*cos(2*u[5])+2.3E-6*u[10]*sin(u[3])*sin(u[4])*cos(2*u[5])+-1.1E-6*u[8]*sin(u[3])*cos(2*u[4])*cos(2*u[5])+-2.9E-7*u[7]*sin(2*u[4])*cos(2*u[5])+2.9E-7*u[7]*cos(2*u[3])*sin(2*u[4])*cos(2*u[5])+2.3E-6*u[10]*cos(u[3])*sin(2*u[5])+-5.7E-7*u[7]*sin(2*u[3])*cos(u[4])*sin(2*u[5])+2.3E-6*u[8]*cos(u[3])*sin(u[4])*sin(2*u[5]) 
c43 = -3.3E-6*u[10]*cos(u[4])+2.6E-6*u[8]*sin(2*u[4])+2.3E-6*u[10]*cos(u[4])*cos(2*u[5])+5.7E-7*u[8]*sin(2*u[4])*cos(2*u[5]) 
c44 = 2.3E-6*u[10]*sin(2*u[5]) 
c45 = 0

c51 = -3.3E-6*u[9]*sin(u[2])*cos(u[4])+-3.3E-6*u[7]*sin(u[2])*cos(u[3])*cos(u[4])+-3.3E-6*u[8]*cos(u[2])*sin(u[3])*cos(u[4])+-3.3E-6*u[7]*cos(u[2])*sin(u[4])+-3.3E-6*u[9]*cos(u[2])*cos(u[3])*sin(u[4])+2.3E-6*u[9]*sin(u[2])*cos(u[4])*cos(2*u[5])+2.3E-6*u[7]*sin(u[2])*cos(u[3])*cos(u[4])*cos(2*u[5])+-2.3E-6*u[8]*cos(u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])+1.1E-6*u[6]*sin(2*u[2])*sin(u[3])*cos(u[4])*cos(2*u[5])+2.3E-6*u[9]*cos(u[2])*cos(u[3])*sin(u[4])*cos(2*u[5])+2.3E-6*u[7]*cos(u[2])*cos(2*u[3])*sin(u[4])*cos(2*u[5])+5.7E-7*u[6]*sin(2*u[3])*sin(u[4])*cos(2*u[5])+5.7E-7*u[6]*cos(2*u[2])*sin(2*u[3])*sin(u[4])*cos(2*u[5])+1.4E-7*u[6]*sin(2*u[5])+-1.1E-6*u[8]*sin(u[2])*sin(2*u[5])+-4.3E-7*u[6]*cos(2*u[2])*sin(2*u[5])+-2.3E-6*u[9]*cos(u[2])*sin(u[3])*sin(2*u[5])+4.3E-7*u[6]*cos(2*u[3])*sin(2*u[5])+4.3E-7*u[6]*cos(2*u[2])*cos(2*u[3])*sin(2*u[5])+-1.7E-6*u[7]*cos(u[2])*sin(2*u[3])*sin(2*u[5])+1.4E-7*u[6]*cos(2*u[4])*sin(2*u[5])+-1.1E-6*u[8]*sin(u[2])*cos(2*u[4])*sin(2*u[5])+-4.3E-7*u[6]*cos(2*u[2])*cos(2*u[4])*sin(2*u[5])+-1.4E-7*u[6]*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])+-1.4E-7*u[6]*cos(2*u[2])*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])+5.7E-7*u[7]*cos(u[2])*sin(2*u[3])*cos(2*u[4])*sin(2*u[5])+-1.1E-6*u[8]*cos(u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5])+5.7E-7*u[6]*sin(2*u[2])*cos(u[3])*sin(2*u[4])*sin(2*u[5])+-1.1E-6*u[7]*sin(u[2])*sin(u[3])*sin(2*u[4])*sin(2*u[5]) 
c52 = -3.3E-6*u[8]*cos(u[3])*cos(u[4])+3.3E-6*u[9]*sin(u[3])*sin(u[4])+-2.3E-6*u[8]*cos(u[3])*cos(u[4])*cos(2*u[5])+-2.3E-6*u[9]*sin(u[3])*sin(u[4])*cos(2*u[5])+-1.1E-6*u[7]*sin(2*u[3])*sin(u[4])*cos(2*u[5])+-2.9E-7*u[7]*sin(2*u[5])+-2.3E-6*u[9]*cos(u[3])*sin(2*u[5])+-8.6E-7*u[7]*cos(2*u[3])*sin(2*u[5])+-2.9E-7*u[7]*cos(2*u[4])*sin(2*u[5])+2.9E-7*u[7]*cos(2*u[3])*cos(2*u[4])*sin(2*u[5])+1.1E-6*u[8]*sin(u[3])*sin(2*u[4])*sin(2*u[5]) 
c53 = 3.3E-6*u[9]*cos(u[4])+-2.3E-6*u[9]*cos(u[4])*cos(2*u[5])+5.7E-7*u[8]*sin(2*u[5])+5.7E-7*u[8]*cos(2*u[4])*sin(2*u[5]) 
c54 = -1.1E-6*u[9]*sin(2*u[5])
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
θp= [u[6];u[7];u[8];u[9];u[10]];
f = g * (-C * θp )

τ = [0;0;0;τ₄;τ₅];


formatted_expr_str = replace(string(τ₄), r"(\d)([a-zA-Z])" => s"\1 * \2");
formatted_expr_str2 = replace(formatted_expr_str, r"(\d)(\()" => s"\1 * \2");


open("expression.txt", "w") do f
    write(f, string(formatted_expr_str2))
end




