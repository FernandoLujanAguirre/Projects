using Symbolics
using LinearAlgebra
@variables m11 m12 m13 m14 m15 m22 m23 m24 m25 m33 m34 m35 m44 m45 m55
@variables c11 c12 c13 c14 c15 c21 c22 c23 c24 c25 c31 c32 c33 c34 c35 c41 c42 c43 c44 c45 c51 c52 c53 c54 c55
@variables du1 du2 du3 du4 du5
@variables v1 v2
C=[c11 c12 c13 c14 c15
c21 c22 c23 c24 c25
c31 c32 c33 c34 c35
c41 c42 c43 c44 c45
c51 c52 c53 c54 c55]

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

M = vcat(hcat(M11,M12,M13),hcat(M12',M22,M23),hcat(M13',M23',M33))

du = [du1
      du2
      du3
      du4
      du5
      ];
h = C*du;#*du
h1 = h[1:2,:];
h2 = h[3:3,:];
h3 = h[4:5,:];

M22bar =M22 - M21*inv(M11)*M12;
M23bar = M23 - M21*inv(M11)*M13;
h2bar = h2 - M21*M11*h1;

M13bar = Symbolics.factorize.(M13 - M12*inv(M22)*M23bar);
h1bar = h1 - M12*inv(M22)*h2bar;

M33bar = M33 - M31*inv(M11)*M13bar - M32*inv(M22bar)*M23bar;
h3bar = h3 - M31*inv(M11)*h1bar - M32*inv(M22)*h2bar;

v3  = [v1
      v2];
τ = M33bar*v3 + h3bar;
-inv(M11)*(M13bar*v3 + h1bar);
-inv(M22bar)*(M23bar*v3 + h2bar);

f = [-inv(M11)*(M13bar*v3);
     -only(inv(M22bar)*(M23bar*v3));
     inv(M33bar)*(τ)];

g = [-inv(M11)*(h1bar)
     -only(inv(M22bar)*h2bar)
     -inv(M33bar)*h3bar];


     simplify.(inv(M33bar)*(M33bar*([v1;v2]) + h3bar))
