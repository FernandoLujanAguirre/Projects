<TeXmacs|2.1.4>

<style|<tuple|generic|large-formulas|maxima>>

<\body>
  <\session|maxima|default>
    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>1) >
    <|input>
      kill(all)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>1) >
    <|input>
      <code|load("lrats")>$
    </input>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>2) >
    <|unfolded-io>
      load("/home/usuario/Documents/Vaults/Zettel_new/01Curación-Conexión/Anexos/Codigo_Maxima/find_subexp.mac")$
    <|unfolded-io>
      \;

      <math|<with|math-display|true|<text|<verbatim|f><verbatim|i><verbatim|l><verbatim|e><verbatim|_><verbatim|s><verbatim|e><verbatim|a><verbatim|r><verbatim|c><verbatim|h><verbatim|1><verbatim|:><verbatim|
      >/home/usuario/Documents/Vaults/Zettel_new/01Curación-Conexión/Anexos/Codigo_Maxima/find_subexp.mac
      <verbatim| ><verbatim|n><verbatim|o><verbatim|t><verbatim|
      ><verbatim|f><verbatim|o><verbatim|u><verbatim|n><verbatim|d><verbatim|
      ><verbatim|i><verbatim|n><verbatim|
      ><verbatim|f><verbatim|i><verbatim|l><verbatim|e><verbatim|_><verbatim|s><verbatim|e><verbatim|a><verbatim|r><verbatim|c><verbatim|h><verbatim|_><verbatim|m><verbatim|a><verbatim|x><verbatim|i><verbatim|m><verbatim|a><verbatim|,><verbatim|f><verbatim|i><verbatim|l><verbatim|e><verbatim|_><verbatim|s><verbatim|e><verbatim|a><verbatim|r><verbatim|c><verbatim|h><verbatim|_><verbatim|l><verbatim|i><verbatim|s><verbatim|p><verbatim|.>>>>

      \ -- an error. To debug this try: debugmode(true);
    </unfolded-io>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>3) >
    <|input>
      load(linearalgebra)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>4) >
    <|input>
      file_search_demo: append (file_search_demo,["/home/fernando/Documents/maxima/maxima-5.47.0/clifford-master/$$$.{dem,wxm}"])$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>5) >
    <|input>
      file_search_maxima: append (file_search_maxima,["/home/fernando/Documents/maxima/maxima-5.47.0/clifford-master/$$$.{mac,wxm}"])$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>6) >
    <|input>
      setup_autoload ("clifford.mac", clifford)$
    </input>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>7) >
    <|unfolded-io>
      load("clifford")$
    <|unfolded-io>
      define: warning: redefining the built-in function clifford

      <math|<with|math-display|true|<text|package name: clifford.mac >>>

      \;

      \ <math|<with|math-display|true|<text|author: Dimiter Prodanov >>>

      <math|<with|math-display|true|<text|version:
      ><with|math-font-family|rm|v25>>>

      \;

      \ <math|<with|math-display|true|<text|Recommended location:
      share/contrib >>>

      <math|<with|math-display|true|<text|last update: 9 May 2023 >>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>8) >
    <|unfolded-io>
      clifford(e,3)
    <|unfolded-io>
      <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o8>)
      >><around*|[|1,1,1|]>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>9) >
    <|unfolded-io>
      mtable2()
    <|unfolded-io>
      \;

      \ <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o9>)
      >><matrix|<tformat|<table|<row|<cell|1>|<cell|e<rsub|1>>|<cell|e<rsub|2>>|<cell|e<rsub|3>>|<cell|e<rsub|1>\<cdot\>e<rsub|2>>|<cell|e<rsub|1>\<cdot\>e<rsub|3>>|<cell|e<rsub|2>\<cdot\>e<rsub|3>>|<cell|e<rsub|1>\<cdot\>e<rsub|2>\<cdot\>e<rsub|3>>>|<row|<cell|e<rsub|1>>|<cell|1>|<cell|e<rsub|1>\<cdot\>e<rsub|2>>|<cell|e<rsub|1>\<cdot\>e<rsub|3>>|<cell|e<rsub|2>>|<cell|e<rsub|3>>|<cell|e<rsub|1>\<cdot\>e<rsub|2>\<cdot\>e<rsub|3>>|<cell|e<rsub|2>\<cdot\>e<rsub|3>>>|<row|<cell|e<rsub|2>>|<cell|-e<rsub|1>\<cdot\>e<rsub|2>>|<cell|1>|<cell|e<rsub|2>\<cdot\>e<rsub|3>>|<cell|-e<rsub|1>>|<cell|-e<rsub|1>\<cdot\>e<rsub|2>\<cdot\>e<rsub|3>>|<cell|e<rsub|3>>|<cell|-e<rsub|1>\<cdot\>e<rsub|3>>>|<row|<cell|e<rsub|3>>|<cell|-e<rsub|1>\<cdot\>e<rsub|3>>|<cell|-e<rsub|2>\<cdot\>e<rsub|3>>|<cell|1>|<cell|e<rsub|1>\<cdot\>e<rsub|2>\<cdot\>e<rsub|3>>|<cell|-e<rsub|1>>|<cell|-e<rsub|2>>|<cell|e<rsub|1>\<cdot\>e<rsub|2>>>|<row|<cell|e<rsub|1>\<cdot\>e<rsub|2>>|<cell|-e<rsub|2>>|<cell|e<rsub|1>>|<cell|e<rsub|1>\<cdot\>e<rsub|2>\<cdot\>e<rsub|3>>|<cell|-1>|<cell|-e<rsub|2>\<cdot\>e<rsub|3>>|<cell|e<rsub|1>\<cdot\>e<rsub|3>>|<cell|-e<rsub|3>>>|<row|<cell|e<rsub|1>\<cdot\>e<rsub|3>>|<cell|-e<rsub|3>>|<cell|-e<rsub|1>\<cdot\>e<rsub|2>\<cdot\>e<rsub|3>>|<cell|e<rsub|1>>|<cell|e<rsub|2>\<cdot\>e<rsub|3>>|<cell|-1>|<cell|-e<rsub|1>\<cdot\>e<rsub|2>>|<cell|e<rsub|2>>>|<row|<cell|e<rsub|2>\<cdot\>e<rsub|3>>|<cell|e<rsub|1>\<cdot\>e<rsub|2>\<cdot\>e<rsub|3>>|<cell|-e<rsub|3>>|<cell|e<rsub|2>>|<cell|-e<rsub|1>\<cdot\>e<rsub|3>>|<cell|e<rsub|1>\<cdot\>e<rsub|2>>|<cell|-1>|<cell|-e<rsub|1>>>|<row|<cell|e<rsub|1>\<cdot\>e<rsub|2>\<cdot\>e<rsub|3>>|<cell|e<rsub|2>\<cdot\>e<rsub|3>>|<cell|-e<rsub|1>\<cdot\>e<rsub|3>>|<cell|e<rsub|1>\<cdot\>e<rsub|2>>|<cell|-e<rsub|3>>|<cell|e<rsub|2>>|<cell|-e<rsub|1>>|<cell|-1>>>>>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>10) >
    <|unfolded-io>
      trigexpandtimes:false
    <|unfolded-io>
      <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o10>)
      >><math-bf|false>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>11) >
    <|unfolded-io>
      trigexpandplus:true
    <|unfolded-io>
      \;

      \ <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o11>)
      >><math-bf|true>>>
    </unfolded-io>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>12) >
    <|input>
      \;
    </input>
  </session>

  \;

  <\session|maxima|default>
    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>12) >
    <|input>
      texput(t1,"\\\\theta_1")$texput(t2,"\\\\theta_2")$texput(t3,"\\\\theta_3")$

      texput(t1p,"\\\\dot\\\\theta_1")$texput(t2p,"\\\\dot\\\\theta_2")$texput(t3p,"\\\\dot\\\\theta_3")$texput(t1pp,"\\\\ddot\\\\theta_1")$texput(t2pp,"\\\\ddot\\\\theta_2")$texput(t3pp,"\\\\ddot\\\\theta_3")$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>21) >
    <|input>
      declare([t1,t2,t3,t1p,t2p,t3p,t1pp,t2pp,t3pp,Ix,Iy,Iz],scalar)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>22) >
    <|input>
      depends([t1,t2,t3,t1p,t2p,t3p],t)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>23) >
    <|input>
      derivadas:[diff(t1,t)=t1p,diff(t2,t)=t2p,diff(t3,t)=t3p,

      diff(t1p,t)=t1pp,diff(t2p,t)=t2pp,diff(t3p,t)=t3pp]$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>24) >
    <|input>
      simple(A):=rat(fullratsimp(trigexpand(trigreduce(cliffsimpall(subst(derivadas,

      A

      ))))),cos(t2),cos(2*t2),sin(2*t3),sin(2*t2),t1,t2,t3,t1p,t2p,t3p,t1pp,t2pp,t3pp,Bx,By,Bz)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>25) >
    <|input>
      I(B,i1,i2,i3):=rat (ratcoef(B,Bx)*Bx*i1 + ratcoef(B,By)*By*i2 +
      ratcoef(B,Bz)*Bz*i3 ,i1,i2,i3,Bx,By,Bz)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>26) >
    <|input>
      Bx:e[2].e[3]$By:e[1].e[3]$Bz:e[1].e[2]$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>29) >
    <|input>
      B:[Bx,By,Bz]$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>30) >
    <|input>
      R1:cos(t1/2)-sin(t1/2).Bx$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>31) >
    <|input>
      R2:cos(t2/2)-sin(t2/2).By$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>32) >
    <|input>
      R3:cos(t3/2)-sin(t3/2).Bz$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>33) >
    <|input>
      R1d:creverse(R1)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>34) >
    <|input>
      R2d:creverse(R2)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>35) >
    <|input>
      R3d:creverse(R3)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>36) >
    <|input>
      T1:R1$T2:simple(T1.R2)$T3:simple(T2.R3)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>39) >
    <|input>
      T1d:creverse(T1)$T2d:creverse(T2)$T3d:creverse(T3)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>42) >
    <|input>
      T:[T1,T2,T3]$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>43) >
    <|input>
      Td:[T1d,T2d,T3d]$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>44) >
    <|input>
      T1p:simple( diff(T1,t) )$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>45) >
    <|input>
      T2p:simple( diff(T2,t) )$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>46) >
    <|input>
      T3p:simple( diff(T3,t) )$
    </input>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>47) >
    <|unfolded-io>
      WB1:simple(-2*T1d.T1p)
    <|unfolded-io>
      <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o47>)
      >><wide|\<theta\>|\<dot\>><rsub|1>*e<rsub|2>\<cdot\>e<rsub|3>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>48) >
    <|unfolded-io>
      WB2:simple(-2*T2d.T2p)
    <|unfolded-io>
      <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o48>)
      >>cos <around*|(|\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|1>*e<rsub|2>\<cdot\>e<rsub|3>+<wide|\<theta\>|\<dot\>><rsub|2>*e<rsub|1>\<cdot\>e<rsub|3>-sin
      <around*|(|\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|1>*e<rsub|1>\<cdot\>e<rsub|2>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>49) >
    <|unfolded-io>
      WB3:simple(-2*T3d.T3p)
    <|unfolded-io>
      <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o49>)
      >><around*|(|cos <around*|(|\<theta\><rsub|3>|)>*cos
      <around*|(|\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|1>-sin
      <around*|(|\<theta\><rsub|3>|)>*<wide|\<theta\>|\<dot\>><rsub|2>|)>*e<rsub|2>\<cdot\>e<rsub|3>+<around*|(|sin
      <around*|(|\<theta\><rsub|3>|)>*cos
      <around*|(|\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|1>+cos
      <around*|(|\<theta\><rsub|3>|)>*<wide|\<theta\>|\<dot\>><rsub|2>|)>*e<rsub|1>\<cdot\>e<rsub|3>+<around*|(|-sin
      <around*|(|\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|1>+<wide|\<theta\>|\<dot\>><rsub|3>|)>*e<rsub|1>\<cdot\>e<rsub|2>>>
    </unfolded-io>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>50) >
    <|input>
      WB3d:creverse(WB3)$
    </input>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>51) >
    <|unfolded-io>
      I(WB3,Ix,Iy,Iz)
    <|unfolded-io>
      <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o51>)
      >><around*|(|<wide|\<theta\>|\<dot\>><rsub|1>*cos
      <around*|(|\<theta\><rsub|2>|)>*cos
      <around*|(|\<theta\><rsub|3>|)>-<wide|\<theta\>|\<dot\>><rsub|2>*sin
      <around*|(|\<theta\><rsub|3>|)>|)>*<math-up|Ix>*e<rsub|2>\<cdot\>e<rsub|3>+<around*|(|<wide|\<theta\>|\<dot\>><rsub|2>*cos
      <around*|(|\<theta\><rsub|3>|)>+<wide|\<theta\>|\<dot\>><rsub|1>*cos
      <around*|(|\<theta\><rsub|2>|)>*sin
      <around*|(|\<theta\><rsub|3>|)>|)>*<math-up|Iy>*e<rsub|1>\<cdot\>e<rsub|3>+<around*|(|-<wide|\<theta\>|\<dot\>><rsub|1>*sin
      <around*|(|\<theta\><rsub|2>|)>+<wide|\<theta\>|\<dot\>><rsub|3>|)>*<math-up|Iz>*e<rsub|1>\<cdot\>e<rsub|2>>>
    </unfolded-io>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>52) >
    <|input>
      K3:simple( 1/2*(WB3d\|I(WB3,Ix,Iy,Iz) ) )$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>53) >
    <|input>
      SS:matrix([Ix+Iy-2*Iz],[Ix-Iy],[Iz])$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>54) >
    <|input>
      solveparam:solve(makelist(SS[i,1]=a[i],i,1,3),[Ix,Iy,Iz])$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>55) >
    <|input>
      K3:simple(subst(solveparam,K3))$
    </input>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>56) >
    <|unfolded-io>
      EC1: simple( diff(diff(K3,t1p),t) - diff(K3,t1))
    <|unfolded-io>
      \;

      \ <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o56>)
      >>-<frac|1|4>*<around*|(|<around*|(|2*a<rsub|1>+2*a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|3>|)>|)>*sin
      <around*|(|2*\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|1>*<wide|\<theta\>|\<dot\>><rsub|2>-2*a<rsub|2>*sin
      <around*|(|\<theta\><rsub|2>|)>*sin
      <around*|(|2*\<theta\><rsub|3>|)>*<wide|\<theta\>|\<dot\>><rsub|2><rsup|2>+<around*|(|<around*|(|2*a<rsub|2>+2*a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|2>|)>|)>*sin
      <around*|(|2*\<theta\><rsub|3>|)>*<wide|\<theta\>|\<dot\>><rsub|1>+<around*|(|4*a<rsub|3>+4*a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|3>|)>|)>*cos
      <around*|(|\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|3>+<around*|(|-a<rsub|1>-4*a<rsub|3>-a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|3>|)>+<around*|(|-a<rsub|1>-a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|3>|)>|)>*cos
      <around*|(|2*\<theta\><rsub|2>|)>|)>*<wide|\<theta\>|\<ddot\>><rsub|1>+2*a<rsub|2>*cos
      <around*|(|\<theta\><rsub|2>|)>*sin
      <around*|(|2*\<theta\><rsub|3>|)>*<wide|\<theta\>|\<ddot\>><rsub|2>+4*a<rsub|3>*sin
      <around*|(|\<theta\><rsub|2>|)>*<wide|\<theta\>|\<ddot\>><rsub|3>|)>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>57) >
    <|unfolded-io>
      EC2: simple( diff(diff(K3,t2p),t) - diff(K3,t2))
    <|unfolded-io>
      \;

      \ <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o57>)
      >>-<frac|1|4>*<around*|(|<around*|(|-a<rsub|1>-a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|3>|)>|)>*sin
      <around*|(|2*\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|1><rsup|2>+<around*|(|<around*|(|-4*a<rsub|3>+4*a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|3>|)>|)>*cos
      <around*|(|\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|1>-4*a<rsub|2>*sin
      <around*|(|2*\<theta\><rsub|3>|)>*<wide|\<theta\>|\<dot\>><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|3>+2*a<rsub|2>*cos
      <around*|(|\<theta\><rsub|2>|)>*sin
      <around*|(|2*\<theta\><rsub|3>|)>*<wide|\<theta\>|\<ddot\>><rsub|1>+<around*|(|-2*a<rsub|1>-4*a<rsub|3>+2*a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|3>|)>|)>*<wide|\<theta\>|\<ddot\>><rsub|2>|)>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>58) >
    <|unfolded-io>
      EC3: simple( diff(diff(K3,t3p),t) - diff(K3,t3))
    <|unfolded-io>
      <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o58>)
      >><frac|1|4>*<around*|(|<around*|(|a<rsub|2>+a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|2>|)>|)>*sin
      <around*|(|2*\<theta\><rsub|3>|)>*<wide|\<theta\>|\<dot\>><rsub|1><rsup|2>+<around*|(|-4*a<rsub|3>+4*a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|3>|)>|)>*cos
      <around*|(|\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|1>*<wide|\<theta\>|\<dot\>><rsub|2>-2*a<rsub|2>*sin
      <around*|(|2*\<theta\><rsub|3>|)>*<wide|\<theta\>|\<dot\>><rsub|2><rsup|2>-4*a<rsub|3>*sin
      <around*|(|\<theta\><rsub|2>|)>*<wide|\<theta\>|\<ddot\>><rsub|1>+4*a<rsub|3>*<wide|\<theta\>|\<ddot\>><rsub|3>|)>>>
    </unfolded-io>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>59) >
    <|input>
      m11:ratcoef(EC1,t1pp)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>60) >
    <|input>
      m12:ratcoef(EC1,t2pp)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>61) >
    <|input>
      m13:ratcoef(EC1,t3pp)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>62) >
    <|input>
      m21:ratcoef(EC2,t1pp)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>63) >
    <|input>
      m22:ratcoef(EC2,t2pp)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>64) >
    <|input>
      m23:ratcoef(EC2,t3pp)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>65) >
    <|input>
      m31:ratcoef(EC3,t1pp)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>66) >
    <|input>
      m32:ratcoef(EC3,t2pp)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>67) >
    <|input>
      m33:ratcoef(EC3,t3pp)$
    </input>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>68) >
    <|unfolded-io>
      M:matrix([m11,m12,m13],[m21,m22,m23],[m31,m32,m33])
    <|unfolded-io>
      <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o68>)
      >><matrix|<tformat|<table|<row|<cell|<frac|1|4>*<around*|(|a<rsub|1>+4*a<rsub|3>+a<rsub|1>*cos
      <around*|(|2*\<theta\><rsub|2>|)>+<around*|(|a<rsub|2>+a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|2>|)>|)>*cos
      <around*|(|2*\<theta\><rsub|3>|)>|)>>|<cell|-<frac|1|2>*<around*|(|a<rsub|2>*cos
      <around*|(|\<theta\><rsub|2>|)>*sin
      <around*|(|2*\<theta\><rsub|3>|)>|)>>|<cell|-a<rsub|3>*sin
      <around*|(|\<theta\><rsub|2>|)>>>|<row|<cell|-<frac|1|2>*<around*|(|a<rsub|2>*cos
      <around*|(|\<theta\><rsub|2>|)>*sin
      <around*|(|2*\<theta\><rsub|3>|)>|)>>|<cell|-<frac|1|2>*<around*|(|-a<rsub|1>-2*a<rsub|3>+a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|3>|)>|)>>|<cell|0>>|<row|<cell|-a<rsub|3>*sin
      <around*|(|\<theta\><rsub|2>|)>>|<cell|0>|<cell|a<rsub|3>>>>>>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>69) >
    <|unfolded-io>
      inercias:subst([Ix=1,Iy=2,Iz=3],makelist(a[i]=SS[i,1],i,1,3))
    <|unfolded-io>
      \;

      \ <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o69>)
      >><around*|[|a<rsub|1>=-3,a<rsub|2>=-1,a<rsub|3>=3|]>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>101) >
    <|unfolded-io>
      parametros:append(inercias,[t1=0,t2=%pi/2,t3=0])
    <|unfolded-io>
      <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o101>)
      >><around*|[|a<rsub|1>=-3,a<rsub|2>=-1,a<rsub|3>=3,\<theta\><rsub|1>=0,\<theta\><rsub|2>=<frac|1|2>*\<pi\>,\<theta\><rsub|3>=0|]>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>102) >
    <|unfolded-io>
      Mnumerica:subst(parametros,M)
    <|unfolded-io>
      <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o102>)
      >><matrix|<tformat|<table|<row|<cell|3>|<cell|0>|<cell|-3>>|<row|<cell|0>|<cell|2>|<cell|0>>|<row|<cell|-3>|<cell|0>|<cell|3>>>>>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>103) >
    <|unfolded-io>
      invert(Mnumerica)
    <|unfolded-io>
      \;

      expt: undefined: 0 to a negative exponent.

      \ -- an error. To debug this try: debugmode(true);
    </unfolded-io>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>73) >
    <|input>
      Cttp:<code*|ratexpand>(trigexpand(trigreduce(-expand(M).(matrix([t1pp],[t2pp],[t3pp]))+expand(matrix([EC1],[EC2],[EC3])))))$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>74) >
    <|input>
      tetCuad1:ratcoef(Cttp,t1p,2)*t1p$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>75) >
    <|input>
      tetCuad2:ratexpand(ratcoef(Cttp,t2p,2)*t2p)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>76) >
    <|input>
      tetCuad3:ratexpand(ratcoef(Cttp,t3p,2)*t3p)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>77) >
    <|input>
      Ccuadraticos:addcol(tetCuad1,tetCuad2,tetCuad3)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>78) >
    <|input>
      cruzados:ratexpand(Cttp-(tetCuad1*t1p + tetCuad2*t2p + tetCuad3*t3p))$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>79) >
    <|input>
      cruz1:rat(trigexpand(trigreduce(cruzados[1][1])),t1p,t2p,t3p)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>80) >
    <|input>
      cruz2:rat(trigexpand(trigreduce(cruzados[2][1])),t1p,t2p,t3p)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>81) >
    <|input>
      cruz3:rat(trigexpand(trigreduce(cruzados[3][1])),t1p,t2p,t3p)$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>82) >
    <|input>
      c11:ratcoeff(cruz1,t1p*t2p)*t2p$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>83) >
    <|input>
      c12:ratcoeff(cruz1,t2p*t3p)*t3p$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>84) >
    <|input>
      c13:ratcoeff(cruz1,t1p*t3p)*t1p$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>85) >
    <|input>
      c21:ratcoeff(cruz2,t1p*t2p)*t2p$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>86) >
    <|input>
      c22:ratcoeff(cruz2,t2p*t3p)*t3p$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>87) >
    <|input>
      c23:ratcoeff(cruz2,t1p*t3p)*t1p$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>88) >
    <|input>
      c31:ratcoeff(cruz3,t1p*t2p)*t2p$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>89) >
    <|input>
      c32:ratcoeff(cruz3,t2p*t3p)*t3p$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>90) >
    <|input>
      c33:ratcoeff(cruz3,t1p*t3p)*t1p$
    </input>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>91) >
    <|input>
      Ccruzados:matrix([c11,c12,c13],[c21,c22,c23],[c31,c32,c33])$
    </input>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>92) >
    <|unfolded-io>
      C:simple(Ccruzados+Ccuadraticos)
    <|unfolded-io>
      <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o92>)
      >><matrix|<tformat|<table|<row|<cell|-<frac|1|2>*<around*|(|<around*|(|a<rsub|1>+a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|3>|)>|)>*sin
      <around*|(|2*\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|2>|)>>|<cell|-<frac|1|2>*<around*|(|-a<rsub|2>*sin
      <around*|(|\<theta\><rsub|2>|)>*sin
      <around*|(|2*\<theta\><rsub|3>|)>*<wide|\<theta\>|\<dot\>><rsub|2>+<around*|(|2*a<rsub|3>+2*a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|3>|)>|)>*cos
      <around*|(|\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|3>|)>>|<cell|-<frac|1|2>*<around*|(|<around*|(|a<rsub|2>+a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|2>|)>|)>*sin
      <around*|(|2*\<theta\><rsub|3>|)>*<wide|\<theta\>|\<dot\>><rsub|1>|)>>>|<row|<cell|<frac|1|4>*<around*|(|<around*|(|a<rsub|1>+a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|3>|)>|)>*sin
      <around*|(|2*\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|1>|)>>|<cell|a<rsub|2>*sin
      <around*|(|2*\<theta\><rsub|3>|)>*<wide|\<theta\>|\<dot\>><rsub|3>>|<cell|<around*|(|a<rsub|3>-a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|3>|)>|)>*cos
      <around*|(|\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|1>>>|<row|<cell|<frac|1|4>*<around*|(|<around*|(|a<rsub|2>+a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|2>|)>|)>*sin
      <around*|(|2*\<theta\><rsub|3>|)>*<wide|\<theta\>|\<dot\>><rsub|1>+<around*|(|-4*a<rsub|3>+4*a<rsub|2>*cos
      <around*|(|2*\<theta\><rsub|3>|)>|)>*cos
      <around*|(|\<theta\><rsub|2>|)>*<wide|\<theta\>|\<dot\>><rsub|2>|)>>|<cell|-<frac|1|2>*<around*|(|a<rsub|2>*sin
      <around*|(|2*\<theta\><rsub|3>|)>*<wide|\<theta\>|\<dot\>><rsub|2>|)>>|<cell|0>>>>>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>93) >
    <|unfolded-io>
      trigsimp(fullratsimp(Cttp-C.matrix([t1p],[t2p],[t3p])))
    <|unfolded-io>
      <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o93>)
      >><matrix|<tformat|<table|<row|<cell|0>>|<row|<cell|0>>|<row|<cell|0>>>>>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>95) >
    <|unfolded-io>
      fullratsimp(trigexpand(trigreduce(matrix([EC1],[EC2],[EC3])-(M.matrix([t1pp],[t2pp],[t3pp])+C.matrix([t1p],[t2p],[t3p])))))
    <|unfolded-io>
      \;

      \ <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o95>)
      >><matrix|<tformat|<table|<row|<cell|0>>|<row|<cell|0>>|<row|<cell|0>>>>>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>96) >
    <|unfolded-io>
      mostrar_valoresM(M) :=

      \ \ \ \ block(

      \ \ \ \ \ \ \ \ [filas, columnas, i, j],

      \ \ \ \ \ \ \ \ filas: 3,

      \ \ \ \ \ \ \ \ columnas: 3,

      \ \ \ \ \ \ \ \ for i: 1 thru filas do (

      \ \ \ \ \ \ \ \ \ \ \ \ for j: 1 thru columnas do (

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ print(sconcat("m", string(i),
      string(j), " = ",M[i][j]))

      \ \ \ \ \ \ \ \ \ \ \ \ )

      \ \ \ \ \ \ \ \ )

      \ \ \ \ );
    <|unfolded-io>
      <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o96>)
      >><with|math-font-family|rm|mostrar_valoresM><around*|(|M|)>\<assign\><math-bf|block><space|0.27em><around*|(|<around*|[|<math-up|filas>,<math-up|columnas>,i,j|]>,<math-up|filas>:3,<math-up|columnas>:3,<text|``<math-bf|for>''
      ><space|0.27em>i<space|0.27em><text|``<math-bf|thru>''
      ><space|0.27em><math-up|filas><space|0.27em><text|``<math-bf|do>''
      ><space|0.27em><text|``<math-bf|for>''
      ><space|0.27em>j<space|0.27em><text|``<math-bf|thru>''
      ><space|0.27em><math-up|columnas><space|0.27em><text|``<math-bf|do>''
      ><space|0.27em><math-up|print><around*|(|<math-up|sconcat><around*|(|<text|``m''
      >,<math-up|string><around*|(|i|)>,<math-up|string><around*|(|j|)>,<text|``
      = '' >,<around*|(|M<rsub|i>|)><rsub|j>|)>|)>|)>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>97) >
    <|unfolded-io>
      mostrar_valoresC(C) :=

      \ \ \ \ block(

      \ \ \ \ \ \ \ \ [filas, columnas, i, j],

      \ \ \ \ \ \ \ \ filas: 3,

      \ \ \ \ \ \ \ \ columnas: 3,

      \ \ \ \ \ \ \ \ for i: 1 thru filas do (

      \ \ \ \ \ \ \ \ \ \ \ \ for j: 1 thru columnas do (

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ print(sconcat("c", string(i),
      string(j), " = ",C[i][j]))

      \ \ \ \ \ \ \ \ \ \ \ \ )

      \ \ \ \ \ \ \ \ )

      \ \ \ \ );
    <|unfolded-io>
      <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o97>)
      >><with|math-font-family|rm|mostrar_valoresC><around*|(|C|)>\<assign\><math-bf|block><space|0.27em><around*|(|<around*|[|<math-up|filas>,<math-up|columnas>,i,j|]>,<math-up|filas>:3,<math-up|columnas>:3,<text|``<math-bf|for>''
      ><space|0.27em>i<space|0.27em><text|``<math-bf|thru>''
      ><space|0.27em><math-up|filas><space|0.27em><text|``<math-bf|do>''
      ><space|0.27em><text|``<math-bf|for>''
      ><space|0.27em>j<space|0.27em><text|``<math-bf|thru>''
      ><space|0.27em><math-up|columnas><space|0.27em><text|``<math-bf|do>''
      ><space|0.27em><math-up|print><around*|(|<math-up|sconcat><around*|(|<text|``c''
      >,<math-up|string><around*|(|i|)>,<math-up|string><around*|(|j|)>,<text|``
      = '' >,<around*|(|C<rsub|i>|)><rsub|j>|)>|)>|)>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>98) >
    <|unfolded-io>
      mostrar_valoresM(M)
    <|unfolded-io>
      <math|<with|math-display|true|<text|m11 =
      (1/4)*(a[1]+4*a[3]+a[1]*cos(2*t2)+(a[2]+a[2]*cos(2*t2))*cos(2*t3)) >>>

      <math|<with|math-display|true|<text|m12 =
      -(1/2)*(a[2]*cos(t2)*sin(2*t3)) >>>

      \;

      \ <math|<with|math-display|true|<text|m13 = -a[3]*sin(t2) >>>

      \;

      \ <math|<with|math-display|true|<text|m21 =
      -(1/2)*(a[2]*cos(t2)*sin(2*t3)) >>>

      <math|<with|math-display|true|<text|m22 =
      -(1/2)*((-a[1])-2*a[3]+a[2]*cos(2*t3)) >>>

      \;

      \ <math|<with|math-display|true|<text|m23 = 0 >>>

      \;

      \ <math|<with|math-display|true|<text|m31 = -a[3]*sin(t2) >>>

      \;

      \ <math|<with|math-display|true|<text|m32 = 0 >>>

      \;

      \ <math|<with|math-display|true|<text|m33 = a[3] >>>

      \;

      \ <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o98>)
      >><math-bf|done>>>
    </unfolded-io>

    <\unfolded-io>
      <with|color|red|(<with|math-font-family|rm|%i>100) >
    <|unfolded-io>
      mostrar_valoresC(C)
    <|unfolded-io>
      <math|<with|math-display|true|<text|c11 =
      -(1/2)*((a[1]+a[2]*cos(2*t3))*sin(2*t2)*t2p) >>>

      <math|<with|math-display|true|<text|c12 =
      -(1/2)*((-a[2]*sin(t2)*sin(2*t3)*t2p)+(2*a[3]+2*a[2]*cos(2*t3))*cos(t2)*t3p)
      >>>

      <math|<with|math-display|true|<text|c13 =
      -(1/2)*((a[2]+a[2]*cos(2*t2))*sin(2*t3)*t1p) >>>

      <math|<with|math-display|true|<text|c21 =
      (1/4)*((a[1]+a[2]*cos(2*t3))*sin(2*t2)*t1p) >>>

      <math|<with|math-display|true|<text|c22 = a[2]*sin(2*t3)*t3p >>>

      <math|<with|math-display|true|<text|c23 =
      (a[3]-a[2]*cos(2*t3))*cos(t2)*t1p >>>

      \;

      \ <math|<with|math-display|true|<text|c31 =
      (1/4)*((a[2]+a[2]*cos(2*t2))*sin(2*t3)*t1p+((-4*a[3])+4*a[2]*cos(2*t3))*cos(t2)*t2p)
      >>>

      <math|<with|math-display|true|<text|c32 = -(1/2)*(a[2]*sin(2*t3)*t2p)
      >>>

      \;

      \ <math|<with|math-display|true|<text|c33 = 0 >>>

      \;

      \ <math|<with|math-display|true|<text|<with|font-family|tt|color|red|(<with|math-font-family|rm|%o100>)
      >><math-bf|done>>>
    </unfolded-io>

    <\input>
      <with|color|red|(<with|math-font-family|rm|%i>101) >
    <|input>
      \ 
    </input>
  </session>
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
  </collection>
</initial>