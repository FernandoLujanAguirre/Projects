using Symbolics
using LinearAlgebra

@variables x[1] x[2] x[3] x[4] x[5] x[6] x[7] x[8] x[9] x[10]
@variables v31 v32

    #Satélite
    Ixs = 33.581e-3
    Iys = 33.147e-3
    Izs = 6.921e-3
    
    # Gimball #-6
    Ixg = 3.77e-6
    Iyg = 2.74e-6
    Izg = 6.49e-6
    
    
    #Prisma con agujero-6
    Ix = 3.250e-6
    Iy = 4.681e-6
    Iz = 6.909e-6
    
    m11 = -(1/16)*((-6*Ix)-6*Ixg-4*Ixs-5*Iy-4*Iyg-5*Iz-6*Izg-8*Izs+(2*Ix+2*Ixg-4*Ixs-Iy-4*Iyg-Iz+2*Izg+8*Izs)*cos(2*x[2])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*cos(2*x[2]))*cos(2*x[3])+(2*Ix+2*Ixg-Iy-Iz-2*Izg+((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*cos(2*x[2])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*x[2]))*cos(2*x[3]))*cos(2*x[4])+(8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*sin(2*x[2])*cos(x[3])*sin(2*x[4])+(Iy-Iz+((-3*Iy)+3*Iz)*cos(2*x[2])+(3*Iy-3*Iz+(3*Iy-3*Iz)*cos(2*x[2]))*cos(2*x[3])+(Iy-Iz+((-3*Iy)+3*Iz)*cos(2*x[2])+((-Iy)+Iz+((-Iy)+Iz)*cos(2*x[2]))*cos(2*x[3]))*cos(2*x[4])+(4*Iy-4*Iz)*sin(2*x[2])*cos(x[3])*sin(2*x[4]))*cos(2*x[5])+(((-8*Iy)+8*Iz)*sin(2*x[2])*sin(x[3])*cos(x[4])+((-4*Iy)+4*Iz+((-4*Iy)+4*Iz)*cos(2*x[2]))*sin(2*x[3])*sin(x[4]))*sin(2*x[5])+((-4)-4*cos(2*x[2])+(4+4*cos(2*x[2]))*cos(2*x[3]))*Iys) 
    m12 = (1/8)*(((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*cos(x[2])*sin(2*x[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(x[2])*sin(2*x[3])*cos(2*x[4])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*sin(x[2])*sin(x[3])*sin(2*x[4])+((3*Iy-3*Iz)*cos(x[2])*sin(2*x[3])+((-Iy)+Iz)*cos(x[2])*sin(2*x[3])*cos(2*x[4])+(2*Iy-2*Iz)*sin(x[2])*sin(x[3])*sin(2*x[4]))*cos(2*x[5])+((4*Iy-4*Iz)*sin(x[2])*cos(x[3])*cos(x[4])+(4*Iy-4*Iz)*cos(x[2])*cos(2*x[3])*sin(x[4]))*sin(2*x[5])+4*cos(x[2])*sin(2*x[3])*Iys) 
    m13 = (1/4)*(((-2*Ix)-2*Ixg-Iy-Iz-2*Izg-4*Izs)*sin(x[2])+(2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(x[2])*cos(2*x[4])+(2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(x[2])*cos(x[3])*sin(2*x[4])+((Iy-Iz)*sin(x[2])+(Iy-Iz)*sin(x[2])*cos(2*x[4])+(Iy-Iz)*cos(x[2])*cos(x[3])*sin(2*x[4]))*cos(2*x[5])+((-2*Iy)+2*Iz)*cos(x[2])*sin(x[3])*cos(x[4])*sin(2*x[5])) 
    m14 = -(1/2)*(((-Iy)-2*Iyg-Iz)*cos(x[2])*sin(x[3])+((-Iy)+Iz)*cos(x[2])*sin(x[3])*cos(2*x[5])+(((-Iy)+Iz)*sin(x[2])*cos(x[4])+((-Iy)+Iz)*cos(x[2])*cos(x[3])*sin(x[4]))*sin(2*x[5])) 
    m15 = Ix*cos(x[2])*cos(x[3])*cos(x[4])-Ix*sin(x[2])*sin(x[4]) 
    m21 = (1/8)*(((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*cos(x[2])*sin(2*x[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(x[2])*sin(2*x[3])*cos(2*x[4])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*sin(x[2])*sin(x[3])*sin(2*x[4])+((3*Iy-3*Iz)*cos(x[2])*sin(2*x[3])+((-Iy)+Iz)*cos(x[2])*sin(2*x[3])*cos(2*x[4])+(2*Iy-2*Iz)*sin(x[2])*sin(x[3])*sin(2*x[4]))*cos(2*x[5])+((4*Iy-4*Iz)*sin(x[2])*cos(x[3])*cos(x[4])+(4*Iy-4*Iz)*cos(x[2])*cos(2*x[3])*sin(x[4]))*sin(2*x[5])+4*cos(x[2])*sin(2*x[3])*Iys) 
    m22 = (1/8)*(2*Ix+2*Ixg+4*Ixs+3*Iy+4*Iyg+3*Iz+2*Izg+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*cos(2*x[3])+(2*Ix+2*Ixg-Iy-Iz-2*Izg+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*x[3]))*cos(2*x[4])+(Iy-Iz+(3*Iy-3*Iz)*cos(2*x[3])+(Iy-Iz+((-Iy)+Iz)*cos(2*x[3]))*cos(2*x[4]))*cos(2*x[5])+((-4*Iy)+4*Iz)*sin(2*x[3])*sin(x[4])*sin(2*x[5])+(4+4*cos(2*x[3]))*Iys) 
    m23 = (1/4)*(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(x[3])*sin(2*x[4])+((-Iy)+Iz)*sin(x[3])*sin(2*x[4])*cos(2*x[5])+((-2*Iy)+2*Iz)*cos(x[3])*cos(x[4])*sin(2*x[5])) 
    m24 = (1/2)*((Iy+2*Iyg+Iz)*cos(x[3])+(Iy-Iz)*cos(x[3])*cos(2*x[5])+((-Iy)+Iz)*sin(x[3])*sin(x[4])*sin(2*x[5])) 
    m25 = -Ix*sin(x[3])*cos(x[4]) 
    
    m31 = (1/4)*(((-2*Ix)-2*Ixg-Iy-Iz-2*Izg-4*Izs)*sin(x[2])+(2*Ix+2*Ixg-Iy-Iz-2*Izg)*sin(x[2])*cos(2*x[4])+(2*Ix+2*Ixg-Iy-Iz-2*Izg)*cos(x[2])*cos(x[3])*sin(2*x[4])+((Iy-Iz)*sin(x[2])+(Iy-Iz)*sin(x[2])*cos(2*x[4])+(Iy-Iz)*cos(x[2])*cos(x[3])*sin(2*x[4]))*cos(2*x[5])+((-2*Iy)+2*Iz)*cos(x[2])*sin(x[3])*cos(x[4])*sin(2*x[5])) 
    m32 = (1/4)*(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*sin(x[3])*sin(2*x[4])+((-Iy)+Iz)*sin(x[3])*sin(2*x[4])*cos(2*x[5])+((-2*Iy)+2*Iz)*cos(x[3])*cos(x[4])*sin(2*x[5])) 
    m33 = (1/4)*(2*Ix+2*Ixg+Iy+Iz+2*Izg+4*Izs+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*cos(2*x[4])+((-Iy)+Iz+((-Iy)+Iz)*cos(2*x[4]))*cos(2*x[5])) 
    m34 = (1/2)*((-Iy)+Iz)*cos(x[4])*sin(2*x[5]) 
    m35 = Ix*sin(x[4]) 
    
    m41 = -(1/2)*(((-Iy)-2*Iyg-Iz)*cos(x[2])*sin(x[3])+((-Iy)+Iz)*cos(x[2])*sin(x[3])*cos(2*x[5])+(((-Iy)+Iz)*sin(x[2])*cos(x[4])+((-Iy)+Iz)*cos(x[2])*cos(x[3])*sin(x[4]))*sin(2*x[5])) 
    m42 = (1/2)*((Iy+2*Iyg+Iz)*cos(x[3])+(Iy-Iz)*cos(x[3])*cos(2*x[5])+((-Iy)+Iz)*sin(x[3])*sin(x[4])*sin(2*x[5])) 
    m43 = (1/2)*((-Iy)+Iz)*cos(x[4])*sin(2*x[5]) 
    m44 = -(1/2)*((-Iy)-2*Iyg-Iz+((-Iy)+Iz)*cos(2*x[5])) 
    m45 = 0 
    
    m51 = Ix*cos(x[2])*cos(x[3])*cos(x[4])-Ix*sin(x[2])*sin(x[4]) 
    m52 = -Ix*sin(x[3])*cos(x[4]) 
    
    m53 = Ix*sin(x[4]) 
    
    m54 = 0 
    
    m55 = Ix 
    
    c11 = (1/8)*((2*Ix+2*Ixg-4*Ixs-Iy-4*Iyg-Iz+2*Izg+8*Izs)*x[7]*sin(2*x[2])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*x[7]*sin(2*x[2])*cos(2*x[3])+(((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*x[8]+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*x[8]*cos(2*x[2]))*sin(2*x[3])+(((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*x[7]*sin(2*x[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*x[9]*sin(2*x[2])*cos(x[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[7]*sin(2*x[2])*cos(2*x[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[8]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[8]*cos(2*x[2]))*sin(2*x[3]))*cos(2*x[4])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*x[9]+((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*x[9]*cos(2*x[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*x[7]*cos(2*x[2])*cos(x[3])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*x[8]*sin(2*x[2])*sin(x[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[9]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[9]*cos(2*x[2]))*cos(2*x[3]))*sin(2*x[4])+(((-3*Iy)+3*Iz)*x[7]*sin(2*x[2])+(3*Iy-3*Iz)*x[7]*sin(2*x[2])*cos(2*x[3])+((3*Iy-3*Iz)*x[8]+(3*Iy-3*Iz)*x[8]*cos(2*x[2]))*sin(2*x[3])+(8*Iy-8*Iz)*x[10]*sin(2*x[2])*sin(x[3])*cos(x[4])+((4*Iy-4*Iz)*x[10]+(4*Iy-4*Iz)*x[10]*cos(2*x[2]))*sin(2*x[3])*sin(x[4])+(((-3*Iy)+3*Iz)*x[7]*sin(2*x[2])+((-4*Iy)+4*Iz)*x[9]*sin(2*x[2])*cos(x[3])+((-Iy)+Iz)*x[7]*sin(2*x[2])*cos(2*x[3])+(((-Iy)+Iz)*x[8]+((-Iy)+Iz)*x[8]*cos(2*x[2]))*sin(2*x[3]))*cos(2*x[4])+((Iy-Iz)*x[9]+((-3*Iy)+3*Iz)*x[9]*cos(2*x[2])+((-4*Iy)+4*Iz)*x[7]*cos(2*x[2])*cos(x[3])+(2*Iy-2*Iz)*x[8]*sin(2*x[2])*sin(x[3])+(((-Iy)+Iz)*x[9]+((-Iy)+Iz)*x[9]*cos(2*x[2]))*cos(2*x[3]))*sin(2*x[4]))*cos(2*x[5])+((Iy-Iz)*x[10]+((-3*Iy)+3*Iz)*x[10]*cos(2*x[2])+((3*Iy-3*Iz)*x[10]+(3*Iy-3*Iz)*x[10]*cos(2*x[2]))*cos(2*x[3])+((4*Iy-4*Iz)*x[8]*sin(2*x[2])*cos(x[3])+(8*Iy-8*Iz)*x[7]*cos(2*x[2])*sin(x[3])+((2*Iy-2*Iz)*x[9]+(2*Iy-2*Iz)*x[9]*cos(2*x[2]))*sin(2*x[3]))*cos(x[4])+(((-4*Iy)+4*Iz)*x[9]*sin(2*x[2])*sin(x[3])+((4*Iy-4*Iz)*x[8]+(4*Iy-4*Iz)*x[8]*cos(2*x[2]))*cos(2*x[3])+((-4*Iy)+4*Iz)*x[7]*sin(2*x[2])*sin(2*x[3]))*sin(x[4])+((Iy-Iz)*x[10]+((-3*Iy)+3*Iz)*x[10]*cos(2*x[2])+(((-Iy)+Iz)*x[10]+((-Iy)+Iz)*x[10]*cos(2*x[2]))*cos(2*x[3]))*cos(2*x[4])+(4*Iy-4*Iz)*x[10]*sin(2*x[2])*cos(x[3])*sin(2*x[4]))*sin(2*x[5])+((-4*x[7]*sin(2*x[2]))+4*x[7]*sin(2*x[2])*cos(2*x[3])+(4*x[8]+4*x[8]*cos(2*x[2]))*sin(2*x[3]))*Iys) 
    c12 = -(1/8)*((4*Ix+4*Ixg+2*Iy+2*Iz+4*Izg+8*Izs)*x[8]*cos(x[2])+(4*Iy+8*Iyg+4*Iz)*x[9]*sin(x[2])*sin(x[3])+(4*Ix+4*Ixg+8*Ixs-2*Iy-8*Iyg-2*Iz+4*Izg)*x[8]*cos(x[2])*cos(2*x[3])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*x[7]*sin(x[2])*sin(2*x[3])+8*Ix*x[10]*sin(x[2])*cos(x[3])*cos(x[4])+8*Ix*x[10]*cos(x[2])*sin(x[4])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*x[8]*cos(x[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*x[9]*sin(x[2])*sin(x[3])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*x[8]*cos(x[2])*cos(2*x[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[7]*sin(x[2])*sin(2*x[3]))*cos(2*x[4])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*x[7]*cos(x[2])*sin(x[3])+((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*x[9]*cos(x[2])*sin(2*x[3]))*sin(2*x[4])+(((-2*Iy)+2*Iz)*x[8]*cos(x[2])+(4*Iy-4*Iz)*x[9]*sin(x[2])*sin(x[3])+((-6*Iy)+6*Iz)*x[8]*cos(x[2])*cos(2*x[3])+(3*Iy-3*Iz)*x[7]*sin(x[2])*sin(2*x[3])+((-8*Iy)+8*Iz)*x[10]*sin(x[2])*cos(x[3])*cos(x[4])+((-8*Iy)+8*Iz)*x[10]*cos(x[2])*cos(2*x[3])*sin(x[4])+(((-2*Iy)+2*Iz)*x[8]*cos(x[2])+((-4*Iy)+4*Iz)*x[9]*sin(x[2])*sin(x[3])+(2*Iy-2*Iz)*x[8]*cos(x[2])*cos(2*x[3])+((-Iy)+Iz)*x[7]*sin(x[2])*sin(2*x[3]))*cos(2*x[4])+(((-2*Iy)+2*Iz)*x[7]*cos(x[2])*sin(x[3])+((-2*Iy)+2*Iz)*x[9]*cos(x[2])*sin(2*x[3]))*sin(2*x[4]))*cos(2*x[5])+((6*Iy-6*Iz)*x[10]*cos(x[2])*sin(2*x[3])+(((-4*Iy)+4*Iz)*x[9]*cos(x[2])+((-4*Iy)+4*Iz)*x[7]*cos(x[2])*cos(x[3])+((-4*Iy)+4*Iz)*x[9]*cos(x[2])*cos(2*x[3]))*cos(x[4])+((8*Iy-8*Iz)*x[9]*sin(x[2])*cos(x[3])+(4*Iy-4*Iz)*x[7]*sin(x[2])*cos(2*x[3])+(8*Iy-8*Iz)*x[8]*cos(x[2])*sin(2*x[3]))*sin(x[4])+((-2*Iy)+2*Iz)*x[10]*cos(x[2])*sin(2*x[3])*cos(2*x[4])+(4*Iy-4*Iz)*x[10]*sin(x[2])*sin(x[3])*sin(2*x[4]))*sin(2*x[5])+((-8*x[8]*cos(x[2])*cos(2*x[3]))+4*x[7]*sin(x[2])*sin(2*x[3]))*Iys) 
    c13 = (1/4)*((2*Iy+4*Iyg+2*Iz)*x[9]*cos(x[2])*cos(x[3])-4*Ix*x[10]*cos(x[2])*sin(x[3])*cos(x[4])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*x[9]*cos(x[2])*cos(x[3])*cos(2*x[4])+(((-4*Ix)-4*Ixg+2*Iy+2*Iz+4*Izg)*x[9]*sin(x[2])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[8]*cos(x[2])*sin(x[3]))*sin(2*x[4])+((2*Iy-2*Iz)*x[9]*cos(x[2])*cos(x[3])+((-4*Iy)+4*Iz)*x[10]*cos(x[2])*sin(x[3])*cos(x[4])+(2*Iy-2*Iz)*x[9]*cos(x[2])*cos(x[3])*cos(2*x[4])+(((-2*Iy)+2*Iz)*x[9]*sin(x[2])+((-Iy)+Iz)*x[8]*cos(x[2])*sin(x[3]))*sin(2*x[4]))*cos(2*x[5])+(((-2*Iy)+2*Iz)*x[10]*sin(x[2])+((-2*Iy)+2*Iz)*x[8]*cos(x[2])*cos(x[3])*cos(x[4])+((-2*Iy)+2*Iz)*x[10]*sin(x[2])*cos(2*x[4])+((-2*Iy)+2*Iz)*x[10]*cos(x[2])*cos(x[3])*sin(2*x[4]))*sin(2*x[5])) 
    c14 = (1/2)*((-2*Ix*x[10]*sin(x[2])*cos(x[4]))-2*Ix*x[10]*cos(x[2])*cos(x[3])*sin(x[4])+((2*Iy-2*Iz)*x[10]*sin(x[2])*cos(x[4])+(2*Iy-2*Iz)*x[10]*cos(x[2])*cos(x[3])*sin(x[4]))*cos(2*x[5])+(((-2*Iy)+2*Iz)*x[10]*cos(x[2])*sin(x[3])+(Iy-Iz)*x[9]*cos(x[2])*cos(x[3])*cos(x[4])+((-Iy)+Iz)*x[9]*sin(x[2])*sin(x[4]))*sin(2*x[5])) 
    c15 = 0 
    
    c21 = -(1/16)*(((-8*Ix)-8*Ixg-4*Iy-4*Iz-8*Izg-16*Izs)*x[8]*cos(x[2])+(2*Ix+2*Ixg-4*Ixs-Iy-4*Iyg-Iz+2*Izg+8*Izs)*x[6]*sin(2*x[2])+((-8*Iy)-16*Iyg-8*Iz)*x[9]*sin(x[2])*sin(x[3])+((8*Ix+8*Ixg+16*Ixs-4*Iy-16*Iyg-4*Iz+8*Izg)*x[8]*cos(x[2])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*x[6]*sin(2*x[2]))*cos(2*x[3])-16*Ix*x[10]*sin(x[2])*cos(x[3])*cos(x[4])-16*Ix*x[10]*cos(x[2])*sin(x[4])+((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*x[8]*cos(x[2])+((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*x[6]*sin(2*x[2])+((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*x[9]*sin(x[2])*sin(x[3])+((8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*x[8]*cos(x[2])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[6]*sin(2*x[2]))*cos(2*x[3]))*cos(2*x[4])+((((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*x[8]*sin(x[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*x[6]*cos(2*x[2]))*cos(x[3])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*x[9]*cos(x[2])*sin(2*x[3]))*sin(2*x[4])+((4*Iy-4*Iz)*x[8]*cos(x[2])+((-3*Iy)+3*Iz)*x[6]*sin(2*x[2])+((-8*Iy)+8*Iz)*x[9]*sin(x[2])*sin(x[3])+(((-12*Iy)+12*Iz)*x[8]*cos(x[2])+(3*Iy-3*Iz)*x[6]*sin(2*x[2]))*cos(2*x[3])+((-16*Iy)+16*Iz)*x[10]*sin(x[2])*cos(x[3])*cos(x[4])+((-16*Iy)+16*Iz)*x[10]*cos(x[2])*cos(2*x[3])*sin(x[4])+((4*Iy-4*Iz)*x[8]*cos(x[2])+((-3*Iy)+3*Iz)*x[6]*sin(2*x[2])+((-8*Iy)+8*Iz)*x[9]*sin(x[2])*sin(x[3])+((4*Iy-4*Iz)*x[8]*cos(x[2])+((-Iy)+Iz)*x[6]*sin(2*x[2]))*cos(2*x[3]))*cos(2*x[4])+((((-8*Iy)+8*Iz)*x[8]*sin(x[2])+((-4*Iy)+4*Iz)*x[6]*cos(2*x[2]))*cos(x[3])+((-4*Iy)+4*Iz)*x[9]*cos(x[2])*sin(2*x[3]))*sin(2*x[4]))*cos(2*x[5])+((12*Iy-12*Iz)*x[10]*cos(x[2])*sin(2*x[3])+((8*Iy-8*Iz)*x[9]*cos(x[2])+((16*Iy-16*Iz)*x[8]*sin(x[2])+(8*Iy-8*Iz)*x[6]*cos(2*x[2]))*sin(x[3])+((-8*Iy)+8*Iz)*x[9]*cos(x[2])*cos(2*x[3]))*cos(x[4])+((16*Iy-16*Iz)*x[8]*cos(x[2])+((-4*Iy)+4*Iz)*x[6]*sin(2*x[2]))*sin(2*x[3])*sin(x[4])+((-4*Iy)+4*Iz)*x[10]*cos(x[2])*sin(2*x[3])*cos(2*x[4])+(8*Iy-8*Iz)*x[10]*sin(x[2])*sin(x[3])*sin(2*x[4]))*sin(2*x[5])+((-4*x[6]*sin(2*x[2]))+((-16*x[8]*cos(x[2]))+4*x[6]*sin(2*x[2]))*cos(2*x[3]))*Iys) 
    c22 = -(1/4)*(((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*x[8]*sin(2*x[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[8]*sin(2*x[3])*cos(2*x[4])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*x[9]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[9]*cos(2*x[3]))*sin(2*x[4])+((3*Iy-3*Iz)*x[8]*sin(2*x[3])+(4*Iy-4*Iz)*x[10]*sin(2*x[3])*sin(x[4])+((-Iy)+Iz)*x[8]*sin(2*x[3])*cos(2*x[4])+((Iy-Iz)*x[9]+((-Iy)+Iz)*x[9]*cos(2*x[3]))*sin(2*x[4]))*cos(2*x[5])+((Iy-Iz)*x[10]+(3*Iy-3*Iz)*x[10]*cos(2*x[3])+(2*Iy-2*Iz)*x[9]*sin(2*x[3])*cos(x[4])+(4*Iy-4*Iz)*x[8]*cos(2*x[3])*sin(x[4])+((Iy-Iz)*x[10]+((-Iy)+Iz)*x[10]*cos(2*x[3]))*cos(2*x[4]))*sin(2*x[5])+4*x[8]*sin(2*x[3])*Iys) 
    c23 = -(1/4)*((2*Iy+4*Iyg+2*Iz)*x[9]*sin(x[3])+4*Ix*x[10]*cos(x[3])*cos(x[4])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*x[9]*sin(x[3])*cos(2*x[4])+(2*Ix+2*Ixg-Iy-Iz-2*Izg)*x[8]*cos(x[3])*sin(2*x[4])+((2*Iy-2*Iz)*x[9]*sin(x[3])+(4*Iy-4*Iz)*x[10]*cos(x[3])*cos(x[4])+(2*Iy-2*Iz)*x[9]*sin(x[3])*cos(2*x[4])+(Iy-Iz)*x[8]*cos(x[3])*sin(2*x[4]))*cos(2*x[5])+(((-2*Iy)+2*Iz)*x[8]*sin(x[3])*cos(x[4])+((-2*Iy)+2*Iz)*x[10]*sin(x[3])*sin(2*x[4]))*sin(2*x[5])) 
    c24 = (1/2)*(2*Ix*x[10]*sin(x[3])*sin(x[4])+((-2*Iy)+2*Iz)*x[10]*sin(x[3])*sin(x[4])*cos(2*x[5])+(((-2*Iy)+2*Iz)*x[10]*cos(x[3])+((-Iy)+Iz)*x[9]*sin(x[3])*cos(x[4]))*sin(2*x[5])) 
    c25 = 0 
    
    c31 = -(1/16)*((8*Ix+8*Ixg+4*Iy+4*Iz+8*Izg+16*Izs)*x[7]*cos(x[2])+(8*Iy+16*Iyg+8*Iz)*x[9]*cos(x[2])*cos(x[3])+((-8*Ix)-8*Ixg-16*Ixs+4*Iy+16*Iyg+4*Iz-8*Izg)*x[7]*cos(x[2])*cos(2*x[3])+(((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*x[6]+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*x[6]*cos(2*x[2]))*sin(2*x[3])-16*Ix*x[10]*cos(x[2])*sin(x[3])*cos(x[4])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*x[7]*cos(x[2])+((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*x[9]*cos(x[2])*cos(x[3])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*x[7]*cos(x[2])*cos(2*x[3])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[6]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[6]*cos(2*x[2]))*sin(2*x[3]))*cos(2*x[4])+((16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*x[9]*sin(x[2])+(16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*x[7]*sin(x[2])*cos(x[3])+(4*Ix+4*Ixg-2*Iy-2*Iz-4*Izg)*x[6]*sin(2*x[2])*sin(x[3]))*sin(2*x[4])+(((-4*Iy)+4*Iz)*x[7]*cos(x[2])+(8*Iy-8*Iz)*x[9]*cos(x[2])*cos(x[3])+(12*Iy-12*Iz)*x[7]*cos(x[2])*cos(2*x[3])+((3*Iy-3*Iz)*x[6]+(3*Iy-3*Iz)*x[6]*cos(2*x[2]))*sin(2*x[3])+(16*Iy-16*Iz)*x[10]*cos(x[2])*sin(x[3])*cos(x[4])+(((-4*Iy)+4*Iz)*x[7]*cos(x[2])+((-8*Iy)+8*Iz)*x[9]*cos(x[2])*cos(x[3])+((-4*Iy)+4*Iz)*x[7]*cos(x[2])*cos(2*x[3])+(((-Iy)+Iz)*x[6]+((-Iy)+Iz)*x[6]*cos(2*x[2]))*sin(2*x[3]))*cos(2*x[4])+((8*Iy-8*Iz)*x[9]*sin(x[2])+(8*Iy-8*Iz)*x[7]*sin(x[2])*cos(x[3])+(2*Iy-2*Iz)*x[6]*sin(2*x[2])*sin(x[3]))*sin(2*x[4]))*cos(2*x[5])+((8*Iy-8*Iz)*x[10]*sin(x[2])+((4*Iy-4*Iz)*x[6]*sin(2*x[2])*cos(x[3])+((-16*Iy)+16*Iz)*x[7]*sin(x[2])*sin(x[3]))*cos(x[4])+(((-16*Iy)+16*Iz)*x[9]*cos(x[2])*sin(x[3])+((4*Iy-4*Iz)*x[6]+(4*Iy-4*Iz)*x[6]*cos(2*x[2]))*cos(2*x[3])+((-16*Iy)+16*Iz)*x[7]*cos(x[2])*sin(2*x[3]))*sin(x[4])+(8*Iy-8*Iz)*x[10]*sin(x[2])*cos(2*x[4])+(8*Iy-8*Iz)*x[10]*cos(x[2])*cos(x[3])*sin(2*x[4]))*sin(2*x[5])+(16*x[7]*cos(x[2])*cos(2*x[3])+(4*x[6]+4*x[6]*cos(2*x[2]))*sin(2*x[3]))*Iys) 
    c32 = (1/8)*((4*Iy+8*Iyg+4*Iz)*x[9]*sin(x[3])+((-2*Ix)-2*Ixg-4*Ixs+Iy+4*Iyg+Iz-2*Izg)*x[7]*sin(2*x[3])+8*Ix*x[10]*cos(x[3])*cos(x[4])+(((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*x[9]*sin(x[3])+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[7]*sin(2*x[3]))*cos(2*x[4])+((4*Iy-4*Iz)*x[9]*sin(x[3])+(3*Iy-3*Iz)*x[7]*sin(2*x[3])+((-8*Iy)+8*Iz)*x[10]*cos(x[3])*cos(x[4])+(((-4*Iy)+4*Iz)*x[9]*sin(x[3])+((-Iy)+Iz)*x[7]*sin(2*x[3]))*cos(2*x[4]))*cos(2*x[5])+(((8*Iy-8*Iz)*x[9]*cos(x[3])+(4*Iy-4*Iz)*x[7]*cos(2*x[3]))*sin(x[4])+(4*Iy-4*Iz)*x[10]*sin(x[3])*sin(2*x[4]))*sin(2*x[5])+4*x[7]*sin(2*x[3])*Iys) 
    c33 = -(1/2)*(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[9]*sin(2*x[4])+((-Iy)+Iz)*x[9]*sin(2*x[4])*cos(2*x[5])+(((-Iy)+Iz)*x[10]+((-Iy)+Iz)*x[10]*cos(2*x[4]))*sin(2*x[5])) 
    c34 = -(1/2)*((-2*Ix*x[10]*cos(x[4]))+(2*Iy-2*Iz)*x[10]*cos(x[4])*cos(2*x[5])+((-Iy)+Iz)*x[9]*sin(x[4])*sin(2*x[5])) 
    c35 = 0 
    
    c41 = -(1/16)*(((-8*Iy)-16*Iyg-8*Iz)*x[8]*cos(x[2])*cos(x[3])+(8*Iy+16*Iyg+8*Iz)*x[7]*sin(x[2])*sin(x[3])-16*Ix*x[10]*sin(x[2])*cos(x[4])-16*Ix*x[10]*cos(x[2])*cos(x[3])*sin(x[4])+(((16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*x[8]*cos(x[2])+((-8*Ix)-8*Ixg+4*Iy+4*Iz+8*Izg)*x[6]*sin(2*x[2]))*cos(x[3])+(16*Ix+16*Ixg-8*Iy-8*Iz-16*Izg)*x[7]*sin(x[2])*sin(x[3]))*cos(2*x[4])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*x[6]+((-16*Ix)-16*Ixg+8*Iy+8*Iz+16*Izg)*x[8]*sin(x[2])+((-6*Ix)-6*Ixg+3*Iy+3*Iz+6*Izg)*x[6]*cos(2*x[2])+(((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[6]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[6]*cos(2*x[2]))*cos(2*x[3])+(8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*x[7]*cos(x[2])*sin(2*x[3]))*sin(2*x[4])+(((-8*Iy)+8*Iz)*x[8]*cos(x[2])*cos(x[3])+(8*Iy-8*Iz)*x[7]*sin(x[2])*sin(x[3])+((-16*Iy)+16*Iz)*x[10]*sin(x[2])*cos(x[4])+((-16*Iy)+16*Iz)*x[10]*cos(x[2])*cos(x[3])*sin(x[4])+(((8*Iy-8*Iz)*x[8]*cos(x[2])+((-4*Iy)+4*Iz)*x[6]*sin(2*x[2]))*cos(x[3])+(8*Iy-8*Iz)*x[7]*sin(x[2])*sin(x[3]))*cos(2*x[4])+((Iy-Iz)*x[6]+((-8*Iy)+8*Iz)*x[8]*sin(x[2])+((-3*Iy)+3*Iz)*x[6]*cos(2*x[2])+(((-Iy)+Iz)*x[6]+((-Iy)+Iz)*x[6]*cos(2*x[2]))*cos(2*x[3])+(4*Iy-4*Iz)*x[7]*cos(x[2])*sin(2*x[3]))*sin(2*x[4]))*cos(2*x[5])+((16*Iy-16*Iz)*x[10]*cos(x[2])*sin(x[3])+(((-8*Iy)+8*Iz)*x[7]*cos(x[2])+(8*Iy-8*Iz)*x[7]*cos(x[2])*cos(2*x[3])+((2*Iy-2*Iz)*x[6]+(2*Iy-2*Iz)*x[6]*cos(2*x[2]))*sin(2*x[3]))*cos(x[4])+((16*Iy-16*Iz)*x[8]*cos(x[2])+((-4*Iy)+4*Iz)*x[6]*sin(2*x[2]))*sin(x[3])*sin(x[4]))*sin(2*x[5])) 
    c42 = (1/8)*(((-4*Iy)-8*Iyg-4*Iz)*x[8]*sin(x[3])-8*Ix*x[10]*sin(x[3])*sin(x[4])+(8*Ix+8*Ixg-4*Iy-4*Iz-8*Izg)*x[8]*sin(x[3])*cos(2*x[4])+((2*Ix+2*Ixg-Iy-Iz-2*Izg)*x[7]+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[7]*cos(2*x[3]))*sin(2*x[4])+(((-4*Iy)+4*Iz)*x[8]*sin(x[3])+((-8*Iy)+8*Iz)*x[10]*sin(x[3])*sin(x[4])+(4*Iy-4*Iz)*x[8]*sin(x[3])*cos(2*x[4])+((Iy-Iz)*x[7]+((-Iy)+Iz)*x[7]*cos(2*x[3]))*sin(2*x[4]))*cos(2*x[5])+(((-8*Iy)+8*Iz)*x[10]*cos(x[3])+(2*Iy-2*Iz)*x[7]*sin(2*x[3])*cos(x[4])+((-8*Iy)+8*Iz)*x[8]*cos(x[3])*sin(x[4]))*sin(2*x[5])) 
    c43 = (1/4)*((-4*Ix*x[10]*cos(x[4]))+((-2*Ix)-2*Ixg+Iy+Iz+2*Izg)*x[8]*sin(2*x[4])+(((-4*Iy)+4*Iz)*x[10]*cos(x[4])+((-Iy)+Iz)*x[8]*sin(2*x[4]))*cos(2*x[5])) 
    c44 = ((-Iy)+Iz)*x[10]*sin(2*x[5]) 
    
    c45 = 0 
    
    c51 = -(1/16)*((16*Ix*x[9]*sin(x[2])+16*Ix*x[7]*sin(x[2])*cos(x[3])+16*Ix*x[8]*cos(x[2])*sin(x[3]))*cos(x[4])+(16*Ix*x[7]*cos(x[2])+16*Ix*x[9]*cos(x[2])*cos(x[3]))*sin(x[4])+(((16*Iy-16*Iz)*x[9]*sin(x[2])+(16*Iy-16*Iz)*x[7]*sin(x[2])*cos(x[3])+(((-16*Iy)+16*Iz)*x[8]*cos(x[2])+(8*Iy-8*Iz)*x[6]*sin(2*x[2]))*sin(x[3]))*cos(x[4])+((16*Iy-16*Iz)*x[9]*cos(x[2])*cos(x[3])+(16*Iy-16*Iz)*x[7]*cos(x[2])*cos(2*x[3])+((4*Iy-4*Iz)*x[6]+(4*Iy-4*Iz)*x[6]*cos(2*x[2]))*sin(2*x[3]))*sin(x[4]))*cos(2*x[5])+((Iy-Iz)*x[6]+((-8*Iy)+8*Iz)*x[8]*sin(x[2])+((-3*Iy)+3*Iz)*x[6]*cos(2*x[2])+((-16*Iy)+16*Iz)*x[9]*cos(x[2])*sin(x[3])+((3*Iy-3*Iz)*x[6]+(3*Iy-3*Iz)*x[6]*cos(2*x[2]))*cos(2*x[3])+((-12*Iy)+12*Iz)*x[7]*cos(x[2])*sin(2*x[3])+((Iy-Iz)*x[6]+((-8*Iy)+8*Iz)*x[8]*sin(x[2])+((-3*Iy)+3*Iz)*x[6]*cos(2*x[2])+(((-Iy)+Iz)*x[6]+((-Iy)+Iz)*x[6]*cos(2*x[2]))*cos(2*x[3])+(4*Iy-4*Iz)*x[7]*cos(x[2])*sin(2*x[3]))*cos(2*x[4])+((((-8*Iy)+8*Iz)*x[8]*cos(x[2])+(4*Iy-4*Iz)*x[6]*sin(2*x[2]))*cos(x[3])+((-8*Iy)+8*Iz)*x[7]*sin(x[2])*sin(x[3]))*sin(2*x[4]))*sin(2*x[5])) 
    c52 = (1/8)*((-8*Ix*x[8]*cos(x[3])*cos(x[4]))+8*Ix*x[9]*sin(x[3])*sin(x[4])+((8*Iy-8*Iz)*x[8]*cos(x[3])*cos(x[4])+((8*Iy-8*Iz)*x[9]*sin(x[3])+(4*Iy-4*Iz)*x[7]*sin(2*x[3]))*sin(x[4]))*cos(2*x[5])+((Iy-Iz)*x[7]+(8*Iy-8*Iz)*x[9]*cos(x[3])+(3*Iy-3*Iz)*x[7]*cos(2*x[3])+((Iy-Iz)*x[7]+((-Iy)+Iz)*x[7]*cos(2*x[3]))*cos(2*x[4])+((-4*Iy)+4*Iz)*x[8]*sin(x[3])*sin(2*x[4]))*sin(2*x[5])) 
    c53 = (1/4)*(4*Ix*x[9]*cos(x[4])+(4*Iy-4*Iz)*x[9]*cos(x[4])*cos(2*x[5])+(((-Iy)+Iz)*x[8]+((-Iy)+Iz)*x[8]*cos(2*x[4]))*sin(2*x[5])) 
    c54 = -(1/2)*((-Iy)+Iz)*x[9]*sin(2*x[5]) 
    
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

dx = [x[6]
      x[7]
      x[8]
      x[9]
      x[10]]

    h = C*dx[1:5];
    h1 = h[1:2,:];
    h2 = h[3:3,:];
    h3 = h[4:5,:];
    
    M22bar =M22 - M21*inv(M11)*M12;
    M23bar = M23 - M21*inv(M11)*M13;
    h2bar = h2 - M21*M11*h1;
    
    M13bar = (M13 - M12*inv(M22)*M23bar);
    h1bar = h1 - M12*inv(M22bar)*h2bar;
    
    M33bar = M33 - M31*inv(M11)*M13bar - M32*inv(M22bar)*M23bar;
    h3bar = h3 - M31*inv(M11)*h1bar - M32*inv(M22)*h2bar;

v3 = [v31
      v32];
τ = M33bar*v3 + h3bar;



f = [x[1]
     x[2]
     x[3]
     x[4]
     x[5]
     -inv(M11)*(M13bar*v3);
     -only(inv(M22bar)*(M23bar*v3));
     inv(M33bar)*(τ)];

g = [0
     0
     0
     0
     0
     -inv(M11)*(h1bar)
     -only(inv(M22bar)*h2bar)
     -inv(M33bar)*h3bar];


     