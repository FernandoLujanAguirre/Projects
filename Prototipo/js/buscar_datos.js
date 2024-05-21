//Read the json file



//const response = await fetch("./simulaciones/datos_GCMRA_MasasPuntuales.json");
const response = await fetch("./simulaciones/datos_GCMRA_esfera.json");
const datos = await response.json();
let donde = 0;
function buscarDatos(tiempoActual,eje){
  for (let i = donde; i <= datos.timestamp.length; i++){
    // look for the entry with a matching `code` value
   
    if (datos.timestamp[i] == tiempoActual){
      donde =  i;
      switch (eje){
        case "x":
          return(datos.value5[i])
        case "y":
          return(datos.value6[i])
        case "z":
          return(datos.value7[i])
        case "x2":
          return(datos.value8[i]);
        case "a1":
          return(datos.value5[i]);
        case "a2":
          return(datos.value6[i]);
        case "a3":
          return(datos.value7[i]);
        case "alert":
         return(0);
      
        }
        
      } else if(tiempoActual>datos.timestamp[datos.timestamp.length-1]){
        
        switch (eje){

        case "x":
        return(datos.value5[datos.timestamp.length-1])
        case "y":
        return(datos.value6[datos.timestamp.length-1])
        case "z":
        return(datos.value7[datos.timestamp.length-1])
        case "x2":
        return(datos.value8[datos.timestamp.length-1]);
          }
        

      }
        }
      }
      
export{buscarDatos};