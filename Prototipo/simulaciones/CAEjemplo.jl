using Symbolics
using LinearAlgebra
@variables x[1] x[2] x[3]
@variables dx[1] dx[2] dx[3]
@variables u
@variables α[1:3]

x = [x[1],x[2],x[3]]
dx = [dx[1],dx[2],dx[3]]

dx[1] = x[2] +x[3]*u
dx[2] = u
dx[3] = u + x[2] - x[3]

dx1 = Differential(x[1])
dx2 = Differential(x[2])
dx3 = Differential(x[3])

du = Differential(u)

fᵗ = [expand_derivatives(dx1(dx[1])) expand_derivatives(dx2(dx[1])) expand_derivatives(dx3(dx[1]));
      expand_derivatives(dx1(dx[2])) expand_derivatives(dx2(dx[2])) expand_derivatives(dx3(dx[2]));
      expand_derivatives(dx1(dx[3])) expand_derivatives(dx2(dx[3])) expand_derivatives(dx3(dx[3]))]

g₁ = [expand_derivatives(du(dx[1])),
      expand_derivatives(du(dx[2])),
      expand_derivatives(du(dx[3]))]

 α = [α[1], α[2], α[3]]

 eq = α'*g₁ ~ 0
 left_null_space = nullspace(eq)