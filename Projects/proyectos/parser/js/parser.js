function cadenaM(){
    console.clear()
    const space = " ";
    const textrm = "\\textrm";
    const beginArray = "$\\left(\\begin{array}{ccc}";
    const endArray = "\\end{array}\\right)$"
    const left = "\\left";
    const right = "\\right";
    const dphi = "\\frac{d}{dt}\\varphi";
    const dtheta = "\\frac{d}{dt}\\vartheta";
    const dpsi = "\\frac{d}{dt}\\psi";

    const phi = "\\varphi";
    const theta = "\\vartheta";
    const psi = "\\psi";

    const mult = "\\"
    const llaveI = "{"
    const llaveD = "}"

    let texto = document.getElementById("cuadro").value 

    texto = texto.replaceAll("\\\\","&");
    let splitText=texto.split("&");

    let textoFinal= [];

    let i =0
    let fila = 1
    let columna =1
    for (const elements of splitText){

        let newtexto = elements.replaceAll(beginArray,"");
        newtexto = newtexto.replaceAll(endArray,"");
        newtexto = newtexto.replaceAll(space,"");
        newtexto = newtexto.replaceAll(textrm,"");
        newtexto = newtexto.replaceAll(left,"");
        newtexto = newtexto.replaceAll(right,"");
        newtexto = newtexto.replaceAll(dphi,"du[1]");
        newtexto = newtexto.replaceAll(dtheta,"du[2]");
        newtexto = newtexto.replaceAll(dpsi,"du[3]");
        newtexto = newtexto.replaceAll(phi,"u[1]");
        newtexto = newtexto.replaceAll(theta,"u[2]");
        newtexto = newtexto.replaceAll(psi,"u[3]");
        newtexto = newtexto.replaceAll(mult,"*");
        newtexto = newtexto.replaceAll(llaveI,"(");
        newtexto = newtexto.replaceAll(llaveD,")");
  
        //const textoFinal = newtexto
         //console.log("M" + fila + columna + "=" + newtexto);
         let output = "M" + fila + columna + "=" +newtexto;
         document.getElementById("cuadro2").innerHTML+=output+"<br>";
        if (columna ==3){
            columna=0;
            fila++
        }
        

        columna++
    }

}   

function cadenaC(){
    console.clear()
    const space = " ";
    const textrm = "\\textrm";
    const beginArray = "$\\left(\\begin{array}{ccc}";
    const endArray = "\\end{array}\\right)$"
    const left = "\\left";
    const right = "\\right";
    const dphi = "\\frac{d}{dt}\\varphi";
    const dtheta = "\\frac{d}{dt}\\vartheta";
    const dpsi = "\\frac{d}{dt}\\psi";

    const phi = "\\varphi";
    const theta = "\\vartheta";
    const psi = "\\psi";

    const mult = "\\"
    const llaveI = "{"
    const llaveD = "}"

    let texto = document.getElementById("cuadro").value 

    texto = texto.replaceAll("\\\\","&");
    let splitText=texto.split("&");

    let textoFinal= [];

    let i =0
    let fila = 1
    let columna =1
    for (const elements of splitText){

        let newtexto = elements.replaceAll(beginArray,"");
        newtexto = newtexto.replaceAll(endArray,"");
        newtexto = newtexto.replaceAll(space,"");
        newtexto = newtexto.replaceAll(textrm,"");
        newtexto = newtexto.replaceAll(left,"");
        newtexto = newtexto.replaceAll(right,"");
        newtexto = newtexto.replaceAll(dphi,"du[1]");
        newtexto = newtexto.replaceAll(dtheta,"du[2]");
        newtexto = newtexto.replaceAll(dpsi,"du[3]");
        newtexto = newtexto.replaceAll(phi,"u[1]");
        newtexto = newtexto.replaceAll(theta,"u[2]");
        newtexto = newtexto.replaceAll(psi,"u[3]");
        newtexto = newtexto.replaceAll(mult,"*");
        newtexto = newtexto.replaceAll(llaveI,"(");
        newtexto = newtexto.replaceAll(llaveD,")");
  
        //const textoFinal = newtexto
         //console.log("M" + fila + columna + "=" + newtexto);
         let output = "C" + fila + columna + "=" +newtexto;
         document.getElementById("cuadro2").innerHTML+=output+"<br>";
        if (columna ==3){
            columna=0;
            fila++
        }
        

        columna++
    }

}  

let btnM = document.getElementById("botonM");
let btnC = document.getElementById("botonC");

btnM.addEventListener("click", cadenaM);
btnC.addEventListener("click", cadenaC);