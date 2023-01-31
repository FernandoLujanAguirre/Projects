//Read the json file



const response = await fetch("./datos/datos_rotor.json");
const datos = await response.json();

function buscarDatos(tiempoActual,eje){
  for (var i = 0; i <= datos.timestamp.length; i++){
    // look for the entry with a matching `code` value
    
    if (datos.timestamp[i] == tiempoActual){

       switch (eje){
        case "x":
          const x = datos.value1[i];
       return(x);
       case "y":
       return(datos.value3[i]);
       case "z":
       return(datos.value5[i]);
        }

      } else if(i == datos.timestamp.length){

        switch (eje){
          case "x":
            const x = null;
         return(x);
         case "y":
         return(null);
         case "z":
         return(null);
          }


      }
      
      
      //else if(){
          //switch (eje){
            //case "x":
            //return(datos.value1[datos.timestamp.length-1]);
            //case "y":
            //return(datos.value3[datos.timestamp.length-1]);
            //case "z":
            //return(datos.value5[datos.timestamp.length-1]);
        }
      }
      




export{buscarDatos};