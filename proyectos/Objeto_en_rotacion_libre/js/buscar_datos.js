//Read the json file



const response = await fetch("./datos/datos_rotor.json");
const datos = await response.json();
let donde = 0;
function buscarDatos(tiempoActual,eje){
  for (let i = donde; i <= datos.timestamp.length; i++){
    // look for the entry with a matching `code` value
    
    if (datos.timestamp[i] == tiempoActual){
      donde =  i;
       switch (eje){
      case "x":
      const x = datos.value1[i];
      return(x);
      case "y":
      return(datos.value3[i]);
      case "z":
      return(datos.value5[i]);
      case "alert":
      return(0);
        }

      } else if(i == datos.timestamp.length){

        switch (eje){
          case "x":
          return(datos.value1[datos.timestamp.length-1]);
          case "y":
          return(datos.value3[datos.timestamp.length-1]);
          case "z":
          return(datos.value5[datos.timestamp.length-1]);
          case "alert":
          return(1);
          }


      }
      
      
      //else if(){
          //switch (eje){
            
        }
      }
      




export{buscarDatos};