function cadena(){
    console.clear()
    let texto = document.getElementById("cuadro").value 
    const begMatrix = "$\\left(\\begin{array}{ccc}";
    const endMatrix = "\\end{array}\\right)$";
    const space = " ";
    const textrm = "\\textrm";

    texto = texto.replaceAll(begMatrix,"\\begin{bmatrix}");
    texto = texto.replaceAll(endMatrix,"\\end{bmatrix}");
    texto = texto.replaceAll(space,"");
    let textofinal = texto.replaceAll(textrm,"");

    document.getElementById("cuadro2").innerHTML = textofinal     
   console.log(texto)



}   

var btn = document.getElementById("boton");

btn.addEventListener("click", cadena);