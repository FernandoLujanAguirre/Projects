//Read the json file



const response = await fetch("./simulations/datos_rotor_cuaterniones.json");
const datos = await response.json();
let donde = 0;
function buscarDatos(tiempoActual,eje){
  for (let i = donde; i <= datos.timestamp.length; i++){
    // look for the entry with a matching `code` value
    
    if (datos.timestamp[i] == tiempoActual){
      donde =  i;
       switch (eje){
      case "a0":
      const x = datos.value4[i];
      return(x);
      case "a1":
      return(datos.value5[i]);
      case "a2":
      return(datos.value6[i]);
      case "a3":
      return(datos.value7[i]);
      case "alert":
      return(0);
      
        }

      } else if(i == datos.timestamp.length){

        switch (eje){
          case "a0":
          return(datos.value4[datos.timestamp.length-1]);
          case "a1":
          return(datos.value5[datos.timestamp.length-1]);
          case "a2":
          return(datos.value6[datos.timestamp.length-1]);
          case "a3":
          return(datos.value7[datos.timestamp.length-1]);
          case "alert":
          return(1);
          }


      }
        }
      }
      
export{buscarDatos};