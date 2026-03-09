import { CSS2DObject } from 'https://esm.sh/three@0.161.0/examples/jsm/renderers/CSS2DRenderer.js';
import * as THREE from 'https://esm.sh/three@0.161.0';

/**
 * Crea un objeto CSS2DObject con texto y posición
 * @param {string} text - Texto que se mostrará
 * @param {THREE.Vector3} position - Posición en el espacio
 * @param {string} color - Color del texto (opcional, default: blanco)
 * @param {string} fontSize - Tamaño de fuente (opcional, default: 16px)
 * @returns {CSS2DObject}
 */
function CreateLabel(text,color='white', fontSize='16px') {
  const div = document.createElement('div');
  div.className = 'label';
  div.innerHTML = text;
  div.style.color = color;
  div.style.fontSize = fontSize;
  div.style.whiteSpace = 'nowrap';
  div.style.backgroundColor = 'rgba(255,255,255,0.5)'; // opcional
  const label = new CSS2DObject(div);
  label.position.set( 0, 0, 0 );
  return label;
}

export { CreateLabel };
