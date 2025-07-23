//Read the json file



//const response = await fetch("./simulaciones/datos_GCMRA_MasasPuntuales.json");
const response = await fetch("./simulaciones/datos_GCMRA_PRIMSA.json");
const datos = await response.json();
let donde = 0;
// Tamaño del vector de datos
let dataSize =0;
let LastTimeData = 0;
dataSize = datos.timestamp.length
LastTimeData = datos.timestamp[dataSize-1]
//-- Progress bar------
const div = document.getElementById('progress-bar');
const divtext = document.getElementById('progress-bar-text');
//--------------


function buscarDatos(tiempoActual,eje){
  for (let i = donde; i <= datos.timestamp.length; i++){
    
    
    if (datos.timestamp[i] == tiempoActual){
      divtext.textContent = tiempoActual + "s";
      div.style.width = 100*tiempoActual/LastTimeData + '%'
      donde =  i;
      switch (eje){
        case "t1":
          return(datos.value6[i])
        case "t2":
          return(datos.value7[i])
        case "t3":
          return(datos.value8[i])
        case "t4":
          return(datos.value9[i]);
        case "t5":
          return(datos.value10[i]);
        }
        
      } else if(tiempoActual>datos.timestamp[datos.timestamp.length-1]){
        
        switch (eje){

        case "t1":
        return(datos.value6[datos.timestamp.length-1])
        case "t2":
        return(datos.value7[datos.timestamp.length-1])
        case "t3":
        return(datos.value8[datos.timestamp.length-1])
        case "t4":
        return(datos.value9[datos.timestamp.length-1]);
        case "t5":
        return(datos.value10[datos.timestamp.length-1]);
          }
        

      }
        }
      }
      
export{buscarDatos};