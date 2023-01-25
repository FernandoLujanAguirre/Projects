//Read the json file



const response = await fetch("./datos/datos_rotor.json");
const datos = await response.json();


function buscarDatos(tiempoActual,eje){
  for (var i = 0; i < datos.timestamp.length; i++){
    // look for the entry with a matching `code` value
    if (datos.timestamp[i] == tiempoActual){
       switch (eje){
        case "x":
       return(datos.value1[i])
       case "y":
       return(datos.value3[i])
       case "z":
       return(datos.value5[i])
      } 

      }
  }
  
}

export{buscarDatos};