// -----------------------------
// Cargar JSON una sola vez
// -----------------------------
const dataSelector = document.getElementById('data-selector');
const response = await fetch(dataSelector.value);
const datos = await response.json();

// Accesos rápidos a arrays (más rápido)
const timestamps = datos.timestamp;
const v1 = datos.value1;
const v2 = datos.value2;
const v3 = datos.value3;
const v4 = datos.value4;
const v5 = datos.value5;

// Metadatos
const dataSize = timestamps.length;
const lastTime = timestamps[dataSize - 1];

// Barra de progreso
const div = document.getElementById('progress-bar');
const divtext = document.getElementById('progress-bar-text');

// Índice de búsqueda incremental (clutch)
let idx = 0;


// -----------------------------
// Función optimizada buscarDatos
// -----------------------------
function buscarDatos(t, eje) {

  // --- Caso tiempo "Last" (rápido) ---
  if (t === "Last") {
    switch (eje) {
      case "t1": return v1[dataSize - 1];
      case "t2": return v2[dataSize - 1];
      case "t3": return v3[dataSize - 1];
      case "t4": return v4[dataSize - 1];
      case "t5": return v5[dataSize - 1];
    }
  }

  // --- Si el tiempo supera los datos, devuelve el último ---
  if (t >= lastTime) {
    switch (eje) {
      case "t1": return v1[dataSize - 1];
      case "t2": return v2[dataSize - 1];
      case "t3": return v3[dataSize - 1];
      case "t4": return v4[dataSize - 1];
      case "t5": return v5[dataSize - 1];
    }
  }

  // --- Búsqueda incremental (O(1) promedio) ---
  // Se asume que t siempre crece o cambia poco
  while (idx < dataSize - 1 && timestamps[idx] < t) {
    idx++;
  }

  // Ahora idx es el primer tiempo >= t
  // Perfecto para animación continua
  const i = idx;

  // --- Actualizar progress bar solamente cuando cambia mucho ---
  divtext.textContent = t + "s";
  div.style.width = (100 * t / lastTime) + "%";

  // --- Retorno rápido ---
  switch (eje) {
    case "t1": return v1[i];
    case "t2": return v2[i];
    case "t3": return v3[i];
    case "t4": return v4[i];
    case "t5": return v5[i];
  }
}

export { buscarDatos };
