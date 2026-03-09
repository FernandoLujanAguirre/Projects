const dataPath = "./simulaciones/Data/labels.json";


async function Labels() {
  const response = await fetch(dataPath);
  const datos = await response.json();
  console.log("function"+datos["q1d"]);   // aquí sí es el JSON, no un Promise
  return datos;
}


export{Labels}
